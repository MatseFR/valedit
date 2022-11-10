package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedInt extends ExposedValue 
{
	
	/**
	   
	   @param	name
	**/
	public function new(name:String) 
	{
		super(name);
		this.defaultValue = 0;
	}
	
	override public function clone():ExposedValue 
	{
		var int:ExposedInt = new ExposedInt(this.name);
		super.clone_internal(int);
		return int;
	}
	
}