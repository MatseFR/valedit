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
		if (storeValue && _object != null)
		{
			if (_storedValue == null)
			{
				_storedValue = Reflect.getProperty(_object, propertyName);
			}
			return _storedValue;
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
	
	override public function childValueChanged():Void 
	{
		if (reassignOnChange && _object != null)
		{
			Reflect.setProperty(_object, propertyName, this.value);
		}
		
		super.childValueChanged();
	}
	
	public function reloadObject():Void
	{
		_storedValue = Reflect.getProperty(_object, propertyName);
		for (value in _childValues)
		{
			value.object = _storedValue;
		}
	}
	
	override public function clone():ExposedValue 
	{
		var object:ExposedObject = new ExposedObject(this.propertyName, this.name, storeValue, reassignOnChange);
		super.clone_internal(object);
		return object;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		return super.toJSON(json);
	}
	
}