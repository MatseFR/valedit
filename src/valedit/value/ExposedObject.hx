package valedit.value;

import valedit.ExposedCollection;
import valedit.animation.TweenData;
import valedit.animation.TweenProperties;
import valedit.events.ValueEvent;
import valedit.value.base.ExposedValue;
import valedit.value.base.ExposedValueWithChildren;
import valeditor.ValEditor;
import valeditor.ValEditorObject;

/**
 * ...
 * @author Matse
 */
class ExposedObject extends ExposedValueWithChildren 
{
	static private var _POOL:Array<ExposedObject> = new Array<ExposedObject>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null, storeValue:Bool = false, reassignOnChange:Bool = false, isUIOpen:Bool = false):ExposedObject
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, storeValue, reassignOnChange, isUIOpen);
		return new ExposedObject(propertyName, name, storeValue, reassignOnChange, isUIOpen);
	}
	
	public var isUIOpen:Bool = false;
	public var objectCollection(get, set):ExposedCollection;
	public var reassignOnChange:Bool = false;
	public var storeValue:Bool = false;
	
	private var _objectCollection:ExposedCollection;
	private function get_objectCollection() { return this._objectCollection; }
	private function set_objectCollection(value:ExposedCollection):ExposedCollection
	{
		if (this._objectCollection == value) return value;
		if (this._objectCollection != null)
		{
			this._objectCollection.removeEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
		}
		this._objectCollection = value;
		if (this._objectCollection != null)
		{
			this._objectCollection.parentValue = this;
			this._objectCollection.valEditorObject = this._valEditorObject;
			this._objectCollection.addEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
		}
		return this._objectCollection;
	}
	
	private var _objectCollectionSaveData:Dynamic;
	
	#if valeditor
	override function set_valEditorObject(value:ValEditorObject):ValEditorObject 
	{
		if (this.objectCollection != null)
		{
			this.objectCollection.valEditorObject = value;
		}
		return super.set_valEditorObject(value);
	}
	#end
	
	override function set_isTweenable(value:Bool):Bool 
	{
		return this._isTweenable = value;
	}
	
	override function set_object(value:Dynamic):Dynamic 
	{
		if (this._object == value) return value;
		if (value != null)
		{
			this._storedValue = Reflect.getProperty(value, this.propertyName);
			if (this._objectCollection == null)
			{
				var objectCollection:ExposedCollection = ValEditor.getCollectionForObject(this._storedValue);
				if (this._objectCollectionSaveData == null)
				{
					objectCollection.readAndSetObject(this._storedValue);
					this.objectCollection = objectCollection;
				}
				else
				{
					objectCollection.fromJSONSave(this._objectCollectionSaveData);
					objectCollection.applyAndSetObject(this._storedValue);
					this.objectCollection = objectCollection;
					if (this.reassignOnChange) 
					{
						this._object = value;
						reassignObject();
					}
				}
				
			}
			else
			{
				this._objectCollection.object = this._storedValue;
			}
			if (!this.storeValue) this._storedValue = null;
		}
		return super.set_object(value);
	}
	
	override function get_value():Dynamic 
	{
		if (this.storeValue && this._object != null)
		{
			if (this._storedValue == null)
			{
				this._storedValue = Reflect.getProperty(this._object, this.propertyName);
			}
			return this._storedValue;
		}
		else
		{
			return super.get_value();
		}
	}
	
	/**
	   
	   @param	propertyName
	   @param	name
	   @param	storeValue	set this to true for properties where the object keeps changing such as a regular OpenFL DisplayObject's transform
	   @param	reassignOnChange	set this to true if the object needs to be reassigned after one of its properties value changed
	**/
	public function new(propertyName:String, name:String = null, storeValue:Bool = false, reassignOnChange:Bool = false, isUIOpen:Bool = false) 
	{
		super(propertyName, name);
		this._isTweenable = true;
		this.storeValue = storeValue;
		this.reassignOnChange = reassignOnChange;
		this.isUIOpen = isUIOpen;
		this.canCopyValueOnClone = false;
	}
	
	override public function clear():Void 
	{
		this._isTweenable = true;
		this.isUIOpen = false;
		if (this.objectCollection != null)
		{
			this.objectCollection.pool();
			this.objectCollection = null;
		}
		super.clear();
		this.canCopyValueOnClone = false;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, storeValue:Bool, reassignOnChange:Bool, isUIOpen:Bool):ExposedObject
	{
		setNames(propertyName, name);
		this.storeValue = storeValue;
		this.reassignOnChange = reassignOnChange;
		this.isUIOpen = isUIOpen;
		return this;
	}
	
	public function getTweenData(tweenData:TweenData, targetValue:ExposedObject):Void
	{
		if (this.objectCollection != null && targetValue.objectCollection != null)
		{
			this.objectCollection.getTweenData(targetValue.objectCollection, tweenData);
			if (this.reassignOnChange)
			{
				var properties:TweenProperties = tweenData.getPropertiesForObject(this.value);
				if (properties != null)
				{
					properties.onUpdate = reassignObject;
				}
			}
		}
	}
	
	override public function applyToObject(object:Dynamic, applyIfDefaultValue:Bool = false):Void 
	{
		if (this.objectCollection != null)
		{
			if (this._object == null || this._object == object)
			{
				this.objectCollection.applyToObject(this.value, applyIfDefaultValue);
			}
			else
			{
				var realObject:Dynamic = Reflect.getProperty(object, this.propertyName);
				
				this.objectCollection.applyToObject(realObject, applyIfDefaultValue);
			}
			
			if (this.reassignOnChange)
			{
				if (this._object == null || this._object == object)
				{
					reassignObject();
				}
				else
				{
					var realObject:Dynamic = Reflect.getProperty(object, this.propertyName);
					Reflect.setProperty(object, this.propertyName, realObject);
				}
			}
		}
	}
	
	override public function readValue(dispatchEventIfChange:Bool = true):Void 
	{
		reloadObject();
		if (this._objectCollection != null)
		{
			this._objectCollection.readValues(dispatchEventIfChange);
		}
		//for (value in this._childValues)
		//{
			//value.readValue(dispatchEventIfChange);
		//}
	}
	
	override public function childValueChanged():Void 
	{
		if (this.reassignOnChange)
		{
			reassignObject();
		}
		
		super.childValueChanged();
	}
	
	public function reassignObject():Void
	{
		if (this._object != null)
		{
			Reflect.setProperty(this._object, this.propertyName, this.value);
		}
	}
	
	public function reloadObject():Void
	{
		this._storedValue = Reflect.getProperty(this._object, propertyName);
		if (this._objectCollection != null)
		{
			this._objectCollection.readAndSetObject(this._storedValue);
		}
	}
	
	private function onValueChange(evt:ValueEvent):Void
	{
		dispatchEvent(evt);
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var object:ExposedObject = fromPool(this.propertyName, this.name, this.storeValue, this.reassignOnChange);
		if (this._objectCollection != null)
		{
			object.objectCollection = this._objectCollection.clone(true);
		}
		super.clone_internal(object, copyValue);
		return object;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		if (json.childValues != null)
		{
			var data:Array<Dynamic> = json.childValues;
			var value:ExposedValue;
			for (node in data)
			{
				value = ExposedValue.valueFromJSON(node);
				addChildValue(value);
			}
		}
	}
	
	override public function fromJSONSave(json:Dynamic):Void 
	{
		if (this._objectCollection == null)
		{
			// store collection data, it will be applied to the collection when it will be created
			this._objectCollectionSaveData = json.collection;
		}
		else
		{
			this._objectCollection.fromJSONSave(json.collection);
		}
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		if (this._childValues.length != 0)
		{
			var data:Array<Dynamic> = new Array<Dynamic>();
			var valueJson:Dynamic;
			for (value in this._childValues)
			{
				valueJson = value.toJSON();
				if (valueJson != null) data.push(valueJson);
			}
			json.childValues = data;
		}
		return super.toJSON(json);
	}
	
	override public function toJSONSave(json:Dynamic):Void
	{
		var data:Dynamic = {};
		if (this._objectCollection != null)
		{
			var collectionData:Dynamic = {};
			this._objectCollection.toJSONSave(collectionData);
			data.collection = collectionData;
		}
		Reflect.setField(json, this.propertyName, data);
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		var childJson:Dynamic = {};
		for (value in this._childValues)
		{
			value.toJSONSimple(childJson);
		}
		Reflect.setField(json, this.propertyName, childJson);
	}
	
}