package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedInt extends ExposedValue 
{
	public var numericMode:NumericMode;
	public var inputPercentWidth:Float;
	
	/**
	   
	   @param	name
	**/
	public function new(name:String, numericMode:NumericMode = NumericMode.PositiveOrNegative, inputPercentWidth:Float = 100) 
	{
		super(name);
		this.numericMode = numericMode;
		this.inputPercentWidth = inputPercentWidth;
		this.defaultValue = 0;
	}
	
	override public function clone():ExposedValue 
	{
		var int:ExposedInt = new ExposedInt(this.name, this.numericMode, inputPercentWidth);
		super.clone_internal(int);
		return int;
	}
	
}