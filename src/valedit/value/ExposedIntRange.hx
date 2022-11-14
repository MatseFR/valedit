package valedit.value;

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
	public var sliderPercentWidth:Float;
	public var inputPercentWidth:Float;
	
	private var _max:Int;
	private function get_max():Int { return _max; }
	private function set_max(value:Int):Int
	{
		if (this.defaultValue > value) this.defaultValue = value;
		return _max = value;
	}
	
	private var _min:Int;
	private function get_min():Int { return _min; }
	private function set_min(value:Int):Int
	{
		if (this.defaultValue < value) this.defaultValue = value;
		return _min = value;
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
	public function new(propertyName:String, name:String = null, min:Int = 0, max:Int = 100, step:Int = 1, sliderPercentWidth:Float = 60, inputPercentWidth:Float = 40) 
	{
		super(propertyName, name);
		this.min = min;
		this.max = max;
		this.step = step;
		this.sliderPercentWidth = sliderPercentWidth;
		this.inputPercentWidth = inputPercentWidth;
		this.defaultValue = 0;
	}
	
	override public function clone():ExposedValue 
	{
		var range:ExposedIntRange = new ExposedIntRange(this.propertyName, this.name, min, max, step, sliderPercentWidth, inputPercentWidth);
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