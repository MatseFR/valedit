package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedColor extends ExposedValue 
{
	
	/**
	   
	   @param	name
	**/
	public function new(name:String) 
	{
		super(name);
		this.defaultValue = 0xffffff;
	}
	
	override public function clone():ExposedValue 
	{
		var color:ExposedColor = new ExposedColor(this.name);
		super.clone_internal(color);
		return color;
	}
	
}