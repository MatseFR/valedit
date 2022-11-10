package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedString extends ExposedValue 
{
	/* 0 = unlimited */
	public var maxChars:Int = 0;
	public var restrict:String = null;
	
	/**
	   
	   @param	name
	   @param	maxChars
	   @param	restrict
	**/
	public function new(name:String, maxChars:Int = 0, restrict:String = null) 
	{
		super(name);
		this.maxChars = maxChars;
		this.restrict = restrict;
		this.defaultValue = "";
	}
	
	override public function clone():ExposedValue 
	{
		var string:ExposedString = new ExposedString(this.name, maxChars, restrict);
		super.clone_internal(string);
		return string;
	}
	
}