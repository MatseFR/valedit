package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedFloat extends ExposedValue 
{
	public var precision:Int;
	
	/**
	   
	   @param	name
	   @param	precision
	**/
	public function new(name:String, precision:Int = 2) 
	{
		super(name);
		this.precision = precision;
		this.defaultValue = 0.0;
	}
	
	override public function clone():ExposedValue 
	{
		var float:ExposedFloat = new ExposedFloat(this.name, this.precision);
		super.clone_internal(float);
		return float;
	}
	
}