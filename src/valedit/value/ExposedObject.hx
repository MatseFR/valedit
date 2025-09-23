package valedit.value;

import openfl.errors.Error;
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
	// DEBUG
	//static private var _OUT:Array<ExposedObject> = new Array<ExposedObject>();
	//\DEBUG
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null, reassignOnChange:Bool = false):ExposedObject
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, reassignOnChange);
		return new ExposedObject(propertyName, name, reassignOnChange);
	}
	
	public var autoCreateIfNull:Bool = false;
	public var autoCreationClassName:String;
	public var autoCreationParametersCollection:ExposedCollection;
	public var autoCreationObject(default, null):ValEditorObject;
	
	#if valeditor
	public var isUIOpen:Bool = false;
	#end
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
			
			if (this._storedValue == null && this.autoCreateIfNull)
			{
				autoCreate();
			}
			else
			{
				if (this._childCollection == null)
				{
					getChildCollection();
				}
				else
				{
					this._childCollection.object = this._storedValue;
				}
			}
			if (!this.storeValue) this._storedValue = null;
		}
		//else
		//{
			//if (this._childCollection != null)
			//{
				//this._childCollection.object = null;
			//}
		//}
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
	public function new(propertyName:String, name:String = null, reassignOnChange:Bool = false) 
	{
		super(propertyName, name);
		this._isTweenable = true;
		this._reassignObjectExtras.owner = this;
		this.reassignOnChange = reassignOnChange;
		// DEBUG
		//_OUT.push(this);
		//\DEBUG
	}
	
	override public function clear():Void 
	{
		this.autoCreateIfNull = false;
		this.autoCreationClassName = null;
		if (this.autoCreationParametersCollection != null)
		{
			this.autoCreationParametersCollection.pool();
			this.autoCreationParametersCollection = null;
		}
		if (this.autoCreationObject != null)
		{
			ValEditor.destroyObject(this.autoCreationObject);
			this.autoCreationObject = null;
		}
		this._hasIgnoredReassignChildProperty = false;
		this._ignoreReassignForChildPropertiesMap.clear();
		this._isTweenable = true;
		#if valeditor
		this.isUIOpen = false;
		#end
		this._reassignObjectExtras.clear();
		this._reassignObjectExtras.owner = this;
		this.storeValue = true;
		super.clear();
	}
	
	public function pool():Void
	{
		#if debug
		if (this.isInPool)
		{
			throw new Error("ExposedObject.pool ::: already in pool");
		}
		#end
		clear();
		_POOL[_POOL.length] = this;
		this.isInPool = true;
		// DEBUG
		//_OUT.remove(this);
		//\DEBUG
	}
	
	private function setTo(propertyName:String, name:String, reassignOnChange:Bool):ExposedObject
	{
		setNames(propertyName, name);
		this.reassignOnChange = reassignOnChange;
		this.isInPool = false;
		// DEBUG
		//_OUT.push(this);
		//\DEBUG
		return this;
	}
	
	public function autoCreate():Void
	{
		if (this.autoCreationObject != null)
		{
			throw new Error("ExposedObject ::: autoCreate function called while autoCreationObject is already set");
		}
		var params:Array<Dynamic> = new Array<Dynamic>();
		if (this.autoCreationParametersCollection != null)
		{
			this.autoCreationParametersCollection.toValueArray(params);
		}
		this.autoCreationObject = ValEditor.createObjectWithClassName(this.autoCreationClassName, null, params);
		this._storedValue = this.autoCreationObject.object;
		if (this._childCollection == null)
		{
			getChildCollection();
		}
		else
		{
			this._childCollection.object = this._storedValue;
		}
	}
	
	private function getChildCollection():Void
	{
		var childCollection:ExposedCollection = ValEditor.getCollectionForObject(this._storedValue);
		if (this._childCollectionSaveData == null)
		{
			if (childCollection != null)
			{
				childCollection.readAndSetObject(this._storedValue);
				this.childCollection = childCollection;
			}
		}
		else if (childCollection != null)
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
	
	override public function applyToObject(object:Dynamic, visibleOnly:Bool = true, applyIfDefaultValue:Bool = false):Void 
	{
		if (this._childCollection != null)
		{
			if (this._object == null || this._object == object)
			{
				this._childCollection.applyToObject(this.value, visibleOnly, applyIfDefaultValue);
			}
			else
			{
				var realObject:Dynamic = Reflect.getProperty(object, this.propertyName);
				
				this._childCollection.applyToObject(realObject, visibleOnly, applyIfDefaultValue);
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
	
	override public function read(dispatchEventIfChange:Bool = true):Void 
	{
		reloadObject();
		if (this._childCollection != null)
		{
			this._childCollection.read(dispatchEventIfChange);
		}
	}
	
	override public function readFromObject(object:Dynamic, dispatchEventIfChange:Bool = false):Void 
	{
		if (this._storedValue == null)
		{
			this._storedValue = Reflect.getProperty(object, this.propertyName);
		}
		if (this._childCollection == null)
		{
			this.childCollection = ValEditor.getCollectionForObject(this._storedValue);
			if (this._childCollection != null)
			{
				this._childCollection.object = this._storedValue;
			}
		}
		if (this._childCollection != null)
		{
			this._childCollection.readFromObject(this._storedValue);
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
		if (this._object == null && this.autoCreationObject != null)
		{
			this._storedValue = this.autoCreationObject.object;
		}
		else
		{
			this._storedValue = Reflect.getProperty(this._object, propertyName);
		}
		if (this._childCollection != null)
		{
			this._childCollection.readAndSetObject(this._storedValue);
		}
	}
	
	public function clone(copyValue:Bool = false):ExposedValue 
	{
		var object:ExposedObject = fromPool(this.propertyName, this.name, this.reassignOnChange);
		object.isUIOpen = this.isUIOpen;
		if (this.autoCreateIfNull)
		{
			object.autoCreateIfNull = true;
			object.autoCreationClassName = this.autoCreationClassName;
			if (this.autoCreationParametersCollection != null)
			{
				object.autoCreationParametersCollection = this.autoCreationParametersCollection.clone(true);
			}
		}
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
	
	override public function fromJSONSave(json:Dynamic):Void 
	{
		super.fromJSONSave(json);
		
		if (this.autoCreateIfNull && this.isConstructor)
		{
			autoCreate();
		}
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