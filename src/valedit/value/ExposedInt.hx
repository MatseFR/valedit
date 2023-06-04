package valedit.value;

import valeditor.ui.feathers.variant.TextInputVariant;
import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedInt extends ExposedValue 
{
	public var numericMode:NumericMode;
	public var inputVariant:String;
	
	/**
	   
	   @param	propertyName
	   @param	name
	   @param	numericMode
	   @param	inputPercentWidth
	**/
	public function new(propertyName:String, name:String = null, numericMode:NumericMode = NumericMode.PositiveOrNegative, inputVariant:String = TextInputVariant.FULL_WIDTH) 
	{
		super(propertyName, name);
		this.numericMode = numericMode;
		this.inputVariant = inputVariant;
		this.defaultValue = 0;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var int:ExposedInt = new ExposedInt(this.propertyName, this.name, this.numericMode, this.inputVariant);
		super.clone_internal(int, copyValue);
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