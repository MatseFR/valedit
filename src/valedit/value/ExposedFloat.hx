package valedit.value;

import valeditor.ui.feathers.variant.TextInputVariant;
import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedFloat extends ExposedValue 
{
	static private var _POOL:Array<ExposedFloat> = new Array<ExposedFloat>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null, precision:Int = 2, numericMode:NumericMode = NumericMode.PositiveOrNegative, inputVariant:String = TextInputVariant.FULL_WIDTH):ExposedFloat
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, precision, numericMode, inputVariant);
		return new ExposedFloat(propertyName, name, precision, numericMode, inputVariant);
	}
	
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
	
	override public function clear():Void 
	{
		super.clear();
		this.defaultValue = 0.0;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, precision:Int, numericMode:NumericMode, inputVariant:String):ExposedFloat
	{
		setNames(propertyName, name);
		this.precision = precision;
		this.numericMode = numericMode;
		this.inputVariant = inputVariant;
		return this;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var float:ExposedFloat = fromPool(this.propertyName, this.name, this.precision, this.numericMode, this.inputVariant);
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