package valedit.value;

import valedit.value.base.ExposedValue;
import valedit.value.base.ExposedValueWithChildren;

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
	
	static public function fromPool(propertyName:String, name:String = null, storeValue:Bool = false, reassignOnChange:Bool = false):ExposedObject
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, storeValue, reassignOnChange);
		return new ExposedObject(propertyName, name, storeValue, reassignOnChange);
	}
	
	public var reassignOnChange:Bool = false;
	public var storeValue:Bool = false;
	
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
	public function new(propertyName:String, name:String = null, storeValue:Bool = false, reassignOnChange:Bool = false) 
	{
		super(propertyName, name);
		this.storeValue = storeValue;
		this.reassignOnChange = reassignOnChange;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, storeValue:Bool, reassignOnChange:Bool):ExposedObject
	{
		setNames(propertyName, name);
		this.storeValue = storeValue;
		this.reassignOnChange = reassignOnChange;
		return this;
	}
	
	override public function applyToObject(object:Dynamic, applyIfDefaultValue:Bool = false):Void 
	{
		var realObject:Dynamic = Reflect.getProperty(object, this.propertyName);
		
		for (value in this._childValues)
		{
			value.applyToObject(realObject, applyIfDefaultValue);
		}
	}
	
	override public function readValue(dispatchEventIfChange:Bool = true):Void 
	{
		reloadObject();
		for (value in this._childValues)
		{
			value.readValue(dispatchEventIfChange);
		}
	}
	
	override public function childValueChanged():Void 
	{
		if (this.reassignOnChange && this._object != null)
		{
			Reflect.setProperty(this._object, this.propertyName, this.value);
		}
		
		super.childValueChanged();
	}
	
	public function reloadObject():Void
	{
		this._storedValue = Reflect.getProperty(this._object, propertyName);
		for (value in this._childValues)
		{
			value.object = _storedValue;
		}
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var object:ExposedObject = fromPool(this.propertyName, this.name, this.storeValue, this.reassignOnChange);
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