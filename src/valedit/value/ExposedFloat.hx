package valedit.value;

import valeditor.ui.feathers.variant.TextInputVariant;
import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedFloat extends ExposedValue 
{
	public var numericMode:NumericMode;
	public var precision:Int;
	public var inputVariant:String;
	
	/**
	   
	   @param	propertyName
	   @param	name
	   @param	precision
	   @param	numericMode
	   @param	inputPercentWidth
	**/
	public function new(propertyName:String, name:String = null, precision:Int = 2, numericMode:NumericMode = NumericMode.PositiveOrNegative, inputVariant:String = TextInputVariant.FULL_WIDTH) 
	{
		super(propertyName, name);
		this.precision = precision;
		this.numericMode = numericMode;
		this.inputVariant = inputVariant;
		this.defaultValue = 0.0;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var float:ExposedFloat = new ExposedFloat(this.propertyName, this.name, this.precision, this.numericMode, this.inputVariant);
		super.clone_internal(float, copyValue);
		return float;
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