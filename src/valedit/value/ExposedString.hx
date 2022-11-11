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
	public var inputPercentWidth:Float;
	
	/**
	   
	   @param	name
	   @param	maxChars
	   @param	restrict
	   @param	inputWidthPercent
	**/
	public function new(name:String, maxChars:Int = 0, restrict:String = null, inputPercentWidth:Float = 100) 
	{
		super(name);
		this.maxChars = maxChars;
		this.restrict = restrict;
		this.inputPercentWidth = inputPercentWidth;
		this.defaultValue = "";
	}
	
	override public function clone():ExposedValue 
	{
		var string:ExposedString = new ExposedString(this.name, maxChars, restrict, inputPercentWidth);
		super.clone_internal(string);
		return string;
	}
	
}