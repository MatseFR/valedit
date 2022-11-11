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
				_storedValue = Reflect.getProperty(_object, name);
			}
			return _storedValue;
		}
		else
		{
			return super.get_value();
		}
	}
	
	/**
	   
	   @param	name
	   @param	storeValue
	   @param	reassignOnChange
	**/
	public function new(name:String, storeValue:Bool = false, reassignOnChange:Bool = false) 
	{
		super(name);
		this.storeValue = storeValue;
		this.reassignOnChange = reassignOnChange;
	}
	
	override public function childValueChanged():Void 
	{
		if (reassignOnChange && _object != null)
		{
			Reflect.setProperty(_object, name, this.value);
		}
		
		super.childValueChanged();
	}
	
	public function reloadObject():Void
	{
		_storedValue = Reflect.getProperty(_object, name);
		for (value in _childValues)
		{
			value.object = _storedValue;
		}
	}
	
	override public function clone():ExposedValue 
	{
		var object:ExposedObject = new ExposedObject(this.name);
		object.reassignOnChange = reassignOnChange;
		object.storeValue = storeValue;
		super.clone_internal(object);
		return object;
	}
	
}