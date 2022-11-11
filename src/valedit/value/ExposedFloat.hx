package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedFloat extends ExposedValue 
{
	public var numericMode:NumericMode;
	public var precision:Int;
	public var inputPercentWidth:Float;
	
	/**
	   
	   @param	name
	   @param	precision
	**/
	public function new(name:String, precision:Int = 2, numericMode:NumericMode = NumericMode.PositiveOrNegative, inputPercentWidth:Float = 100) 
	{
		super(name);
		this.precision = precision;
		this.numericMode = numericMode;
		this.inputPercentWidth = inputPercentWidth;
		this.defaultValue = 0.0;
	}
	
	override public function clone():ExposedValue 
	{
		var float:ExposedFloat = new ExposedFloat(this.name, this.precision, this.numericMode, inputPercentWidth);
		super.clone_internal(float);
		return float;
	}
	
}