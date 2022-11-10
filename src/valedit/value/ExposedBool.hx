package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedBool extends ExposedValue 
{
	
	/**
	   
	   @param	name
	**/
	public function new(name:String) 
	{
		super(name);
		this.defaultValue = false;
	}
	
	override public function clone():ExposedValue 
	{
		var bool:ExposedBool = new ExposedBool(this.name);
		super.clone_internal(bool);
		return bool;
	}
	
}