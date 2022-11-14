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
	   
	   @param	propertyName
	   @param	name
	   @param	numericMode
	   @param	inputPercentWidth
	**/
	public function new(propertyName:String, name:String = null, numericMode:NumericMode = NumericMode.PositiveOrNegative, inputPercentWidth:Float = 100) 
	{
		super(propertyName, name);
		this.numericMode = numericMode;
		this.inputPercentWidth = inputPercentWidth;
		this.defaultValue = 0;
	}
	
	override public function clone():ExposedValue 
	{
		var int:ExposedInt = new ExposedInt(this.propertyName, this.name, numericMode, inputPercentWidth);
		super.clone_internal(int);
		return int;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		this.value = json.value;
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		json.value = this.value;
		return super.toJSON(json);
	}
	
}