package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedObject extends ExposedValue 
{
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
	   @param	storeValue
	   @param	reassignOnChange
	**/
	public function new(propertyName:String, name:String = null, storeValue:Bool = false, reassignOnChange:Bool = false) 
	{
		super(propertyName, name);
		this.storeValue = storeValue;
		this.reassignOnChange = reassignOnChange;
	}
	
	override public function applyToObject(object:Dynamic):Void 
	{
		var realObject:Dynamic = Reflect.getProperty(object, this.propertyName);
		
		for (value in this._childValues)
		{
			value.applyToObject(realObject);
		}
	}
	
	override public function readValue():Void 
	{
		for (value in this._childValues)
		{
			value.readValue();
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
		this._storedValue = Reflect.getProperty(_object, propertyName);
		for (value in this._childValues)
		{
			value.object = _storedValue;
		}
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var object:ExposedObject = new ExposedObject(this.propertyName, this.name, this.storeValue, this.reassignOnChange);
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