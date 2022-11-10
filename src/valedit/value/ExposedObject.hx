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
	
	override function set_object(value:Dynamic):Dynamic
	{
		if (_object == value) return value;
		_storedValue = null;
		return super.set_object(value);
	}
	
	override function get_value():Dynamic 
	{
		if (_object == null)
		{
			return defaultValue;
		}
		else
		{
			if (storeValue)
			{
				if (_storedValue == null)
				{
					_storedValue = Reflect.getProperty(_object, name);
				}
				return _storedValue;
			}
			else
			{
				return Reflect.getProperty(_object, name);
			}
		}
	}
	
	private var _storedValue:Dynamic;
	
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
	
	override public function clone():ExposedValue 
	{
		var object:ExposedObject = new ExposedObject(this.name);
		object.reassignOnChange = reassignOnChange;
		object.storeValue = storeValue;
		super.clone_internal(object);
		return object;
	}
	
}