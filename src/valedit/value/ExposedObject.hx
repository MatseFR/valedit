package valedit.value;

import valedit.ExposedCollection;
import valedit.animation.TweenData;
import valedit.animation.TweenProperties;
import valedit.value.base.ExposedValue;
import valedit.value.base.ExposedValueWithCollection;
import valedit.value.extra.ValueExtraContainer;
import valeditor.ValEditor;
import valeditor.ValEditorObject;

/**
 * ...
 * @author Matse
 */
class ExposedObject extends ExposedValueWithCollection 
{
	static private var _POOL:Array<ExposedObject> = new Array<ExposedObject>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null, reassignOnChange:Bool = false, isUIOpen:Bool = false):ExposedObject
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, reassignOnChange, isUIOpen);
		return new ExposedObject(propertyName, name, reassignOnChange, isUIOpen);
	}
	
	public var isUIOpen:Bool = false;
	public var reassignObjectExtras(get, never):ValueExtraContainer;
	public var reassignOnChange:Bool = false;
	public var storeValue:Bool = true;
	
	override function set_collection(value:ExposedCollection):ExposedCollection 
	{
		this._reassignObjectExtras.collection = value;
		return super.set_collection(value);
	}
	
	override function set_isTweenable(value:Bool):Bool 
	{
		return this._isTweenable = value;
	}
	
	override function set_object(value:Dynamic):Dynamic 
	{
		if (this._object == value) return value;
		if (value != null)
		{
			if (this._storedValue == null) this._storedValue = Reflect.getProperty(value, this.propertyName);
			if (this._childCollection == null)
			{
				var childCollection:ExposedCollection = ValEditor.getCollectionForObject(this._storedValue);
				if (this._childCollectionSaveData == null)
				{
					childCollection.readAndSetObject(this._storedValue);
					this.childCollection = childCollection;
				}
				else
				{
					childCollection.fromJSONSave(this._childCollectionSaveData);
					childCollection.applyAndSetObject(this._storedValue);
					this.childCollection = childCollection;
					if (this.reassignOnChange) 
					{
						this._object = value;
						reassignObject();
					}
				}
				
			}
			else
			{
				this._childCollection.object = this._storedValue;
			}
			if (!this.storeValue) this._storedValue = null;
		}
		this._reassignObjectExtras.object = value;
		return super.set_object(value);
	}
	
	private var _reassignObjectExtras:ValueExtraContainer = new ValueExtraContainer();
	private function get_reassignObjectExtras():ValueExtraContainer { return this._reassignObjectExtras; }
	
	#if valeditor
	override function set_valEditorObject(value:ValEditorObject):ValEditorObject 
	{
		if (this.childCollection != null)
		{
			this.childCollection.valEditorObject = value;
		}
		return super.set_valEditorObject(value);
	}
	#end
	
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
	
	private var _hasIgnoredReassignChildProperty:Bool = false;
	private var _ignoreReassignForChildPropertiesMap:Map<String, String> = new Map<String, String>();
	
	/**
	   
	   @param	propertyName
	   @param	name
	   @param	reassignOnChange	set this to true if the object needs to be reassigned after one of its properties value changed
	**/
	public function new(propertyName:String, name:String = null, reassignOnChange:Bool = false, isUIOpen:Bool = false) 
	{
		super(propertyName, name);
		this._isTweenable = true;
		this._reassignObjectExtras.owner = this;
		this.reassignOnChange = reassignOnChange;
		this.isUIOpen = isUIOpen;
		this.canCopyValueOnClone = false;
	}
	
	override public function clear():Void 
	{
		this._hasIgnoredReassignChildProperty = false;
		this._ignoreReassignForChildPropertiesMap.clear();
		this._isTweenable = true;
		this.isUIOpen = false;
		this._reassignObjectExtras.clear();
		this._reassignObjectExtras.owner = this;
		this.storeValue = true;
		super.clear();
		this.canCopyValueOnClone = false;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, reassignOnChange:Bool, isUIOpen:Bool):ExposedObject
	{
		setNames(propertyName, name);
		this.reassignOnChange = reassignOnChange;
		this.isUIOpen = isUIOpen;
		return this;
	}
	
	public function ignoreObjectReassignForChildProperty(propertyName:String):Void
	{
		this._hasIgnoredReassignChildProperty = true;
		this._ignoreReassignForChildPropertiesMap.set(propertyName, propertyName);
	}
	
	override public function getTweenData(tweenData:TweenData, targetValue:ExposedValueWithCollection):Bool 
	{
		if (super.getTweenData(tweenData, targetValue))
		{
			if (this.reassignOnChange)
			{
				var properties:TweenProperties = tweenData.getPropertiesForObject(this.value);
				if (properties == null)
				{
					properties = TweenProperties.fromPool();
					properties.object = this.value;
					tweenData.addProperties(properties);
				}
				properties.onUpdate = reassignObject;
			}
			return true;
		}
		return false;
	}
	
	override public function apply():Void 
	{
		if (this._childCollection != null)
		{
			this._childCollection.apply();
		}
	}
	
	override public function applyToObject(object:Dynamic, applyIfDefaultValue:Bool = false):Void 
	{
		if (this._childCollection != null)
		{
			if (this._object == null || this._object == object)
			{
				this._childCollection.applyToObject(this.value, applyIfDefaultValue);
			}
			else
			{
				var realObject:Dynamic = Reflect.getProperty(object, this.propertyName);
				
				this._childCollection.applyToObject(realObject, applyIfDefaultValue);
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
		if (this._childCollection != null)
		{
			this._childCollection.readValues(dispatchEventIfChange);
		}
	}
	
	override public function readValueFromObject(object:Dynamic, dispatchEventIfChange:Bool = false):Void 
	{
		if (this._storedValue == null)
		{
			this._storedValue = Reflect.getProperty(object, this.propertyName);
		}
		if (this._childCollection == null)
		{
			this.childCollection = ValEditor.getCollectionForObject(this._storedValue);
			this._childCollection.object = this._storedValue;
		}
		if (this._childCollection != null)
		{
			this._childCollection.readValuesFromObject(this._storedValue);
		}
	}
	
	override public function childValueChanged(value:ExposedValue):Void 
	{
		if (this.reassignOnChange)
		{
			if (this._hasIgnoredReassignChildProperty)
			{
				if (!this._ignoreReassignForChildPropertiesMap.exists(value.propertyName))
				{
					reassignObject();
				}
			}
			else
			{
				reassignObject();
			}
		}
		
		super.childValueChanged(value);
	}
	
	public function reassignObject():Void
	{
		// DEBUG
		//trace("reassignObject " + this.propertyName);
		//\DEBUG
		
		if (this._object != null)
		{
			Reflect.setProperty(this._object, this.propertyName, this.value);
			this._reassignObjectExtras.execute();
		}
	}
	
	public function reloadObject():Void
	{
		this._storedValue = Reflect.getProperty(this._object, propertyName);
		if (this._childCollection != null)
		{
			this._childCollection.readAndSetObject(this._storedValue);
		}
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var object:ExposedObject = fromPool(this.propertyName, this.name, this.reassignOnChange);
		if (this._childCollection != null)
		{
			object.childCollection = this._childCollection.clone(true);
		}
		for (propertyName in this._ignoreReassignForChildPropertiesMap)
		{
			object.ignoreObjectReassignForChildProperty(propertyName);
		}
		this._reassignObjectExtras.clone(object._reassignObjectExtras);
		clone_internal(object, copyValue);
		return object;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		//if (json.childValues != null)
		//{
			//var data:Array<Dynamic> = json.childValues;
			//var value:ExposedValue;
			//for (node in data)
			//{
				//value = ExposedValue.valueFromJSON(node);
				//addChildValue(value);
			//}
		//}
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		//if (this._childValues.length != 0)
		//{
			//var data:Array<Dynamic> = new Array<Dynamic>();
			//var valueJson:Dynamic;
			//for (value in this._childValues)
			//{
				//valueJson = value.toJSON();
				//if (valueJson != null) data.push(valueJson);
			//}
			//json.childValues = data;
		//}
		return super.toJSON(json);
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		//var childJson:Dynamic = {};
		//for (value in this._childValues)
		//{
			//value.toJSONSimple(childJson);
		//}
		//Reflect.setField(json, this.propertyName, childJson);
	}
	
}