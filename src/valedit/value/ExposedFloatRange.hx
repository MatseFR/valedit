package valedit.value;

import valeditor.ui.feathers.variant.TextInputVariant;
import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedFloatRange extends ExposedValue 
{
	public var max(get, set):Float;
	public var min(get, set):Float;
	public var precision:Int;
	public var step:Float = 1.0;
	public var inputVariant:String;
	
	private var _max:Float;
	private function get_max():Float { return _max; }
	private function set_max(value:Float):Float
	{
		if (this.defaultValue > value) this.defaultValue = value;
		return this._max = value;
	}
	
	private var _min:Float;
	private function get_min():Float { return _min; }
	private function set_min(value:Float):Float
	{
		if (this.defaultValue < value) this.defaultValue = value;
		return this._min = value;
	}
	
	/**
	   
	   @param	propertyName
	   @param	name
	   @param	min
	   @param	max
	   @param	step
	   @param	precision
	   @param	sliderPercentWidth
	   @param	inputPercentWidth
	**/
	public function new(propertyName:String, name:String = null, min:Float = 0, max:Float = 100, step:Float = 1, precision:Int = 2, inputVariant:String = TextInputVariant.NUMERIC_MEDIUM) 
	{
		super(propertyName, name);
		this.min = min;
		this.max = max;
		this.step = step;
		this.precision = precision;
		this.inputVariant = inputVariant;
		this.defaultValue = 0.0;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var range:ExposedFloatRange = new ExposedFloatRange(this.propertyName, this.name, this._min, this._max, this.step, this.precision, this.inputVariant);
		super.clone_internal(range, copyValue);
		return range;
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