package valedit.value;

import ui.feathers.variant.TextInputVariant;
import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedIntRange extends ExposedValue 
{
	public var max(get, set):Int;
	public var min(get, set):Int;
	public var step:Int = 1;
	public var inputVariant:String;
	
	private var _max:Int;
	private function get_max():Int { return _max; }
	private function set_max(value:Int):Int
	{
		if (this.defaultValue > value) this.defaultValue = value;
		return this._max = value;
	}
	
	private var _min:Int;
	private function get_min():Int { return _min; }
	private function set_min(value:Int):Int
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
	   @param	sliderPercentWidth
	   @param	inputPercentWidth
	**/
	public function new(propertyName:String, name:String = null, min:Int = 0, max:Int = 100, step:Int = 1, inputVariant:String = TextInputVariant.NUMERIC_MEDIUM) 
	{
		super(propertyName, name);
		this.min = min;
		this.max = max;
		this.step = step;
		this.inputVariant = inputVariant;
		this.defaultValue = 0;
	}
	
	override public function clone():ExposedValue 
	{
		var range:ExposedIntRange = new ExposedIntRange(this.propertyName, this.name, this.min, this.max, this.step, this.inputVariant);
		super.clone_internal(range);
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