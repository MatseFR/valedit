package valedit.value;

import valeditor.ui.feathers.variant.TextInputVariant;
import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedIntRange extends ExposedValue 
{
	static private var _POOL:Array<ExposedIntRange> = new Array<ExposedIntRange>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null, min:Int = 0, max:Int = 100,
									step:Int = 1, inputVariant:String = TextInputVariant.NUMERIC_MEDIUM):ExposedIntRange
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, min, max, step, inputVariant);
		return new ExposedIntRange(propertyName, name, min, max, step, inputVariant);
	}
	
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
	
	override public function clear():Void 
	{
		super.clear();
		this.defaultValue = 0;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, min:Int, max:Int, step:Int, inputVariant:String):ExposedIntRange
	{
		setNames(propertyName, name);
		this.min = min;
		this.max = max;
		this.step = step;
		this.inputVariant = inputVariant;
		return this;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var range:ExposedIntRange = fromPool(this.propertyName, this.name, this.min, this.max, this.step, this.inputVariant);
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