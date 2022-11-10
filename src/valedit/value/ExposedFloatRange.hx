package valedit.value;

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
	
	private var _max:Float;
	private function get_max():Float { return _max; }
	private function set_max(value:Float):Float
	{
		if (this.defaultValue > value) this.defaultValue = value;
		return _max = value;
	}
	
	private var _min:Float;
	private function get_min():Float { return _min; }
	private function set_min(value:Float):Float
	{
		if (this.defaultValue < value) this.defaultValue = value;
		return _min = value;
	}
	
	/**
	   
	   @param	name
	   @param	min
	   @param	max
	   @param	step
	   @param	precision
	**/
	public function new(name:String, min:Float = 0, max:Float = 100, step:Float = 1, precision:Int = 2) 
	{
		super(name);
		this.min = min;
		this.max = max;
		this.step = step;
		this.precision = precision;
		this.defaultValue = 0.0;
	}
	
	override public function clone():ExposedValue 
	{
		var range:ExposedFloatRange = new ExposedFloatRange(this.name);
		range.max = _max;
		range.min = _min;
		range.precision = precision;
		range.step = step;
		super.clone_internal(range);
		return range;
	}
	
}