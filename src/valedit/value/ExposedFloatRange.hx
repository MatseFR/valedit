package valedit.value;

import openfl.errors.Error;
import valedit.value.base.ExposedValue;
import valedit.value.base.ExposedValueTweenable;

/**
 * ...
 * @author Matse
 */
class ExposedFloatRange extends ExposedValueTweenable 
{
	static private var _POOL:Array<ExposedFloatRange> = new Array<ExposedFloatRange>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null, min:Float = 0, max:Float = 100#if valeditor, step:Float = 1, precision:Int = 2#end):ExposedFloatRange
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, min, max#if valeditor, step, precision#end);
		return new ExposedFloatRange(propertyName, name, min, max#if valeditor, step, precision#end);
	}
	
	#if valeditor
	public var inputVariant:String;
	public var liveTyping:Bool = false;
	#end
	public var max(get, set):Float;
	public var min(get, set):Float;
	#if valeditor
	public var precision:Int;
	public var step:Float = 1.0;
	#end
	
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
	public function new(propertyName:String, name:String = null, min:Float = 0, max:Float = 100#if valeditor, step:Float = 1, precision:Int = 2#end) 
	{
		super(propertyName, name);
		this.min = min;
		this.max = max;
		#if valeditor
		this.step = step;
		this.precision = precision;
		#end
		
		this.defaultValue = 0.0;
	}
	
	override public function clear():Void 
	{
		super.clear();
		this.defaultValue = 0.0;
		#if valeditor
		this.inputVariant = null;
		this.liveTyping = false;
		#end
	}
	
	public function pool():Void
	{
		#if debug
		if (this.isInPool)
		{
			throw new Error("ExposedFloatRange.pool ::: already in pool");
		}
		#end
		clear();
		_POOL[_POOL.length] = this;
		this.isInPool = true;
	}
	
	private function setTo(propertyName:String, name:String, min:Float, max:Float#if valeditor, step:Float, precision:Int#end):ExposedFloatRange
	{
		setNames(propertyName, name);
		this.min = min;
		this.max = max;
		#if valeditor
		this.step = step;
		this.precision = precision;
		#end
		this.isInPool = false;
		return this;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var range:ExposedFloatRange = fromPool(this.propertyName, this.name, this._min, this._max#if valeditor, this.step, this.precision#end);
		#if valeditor
		range.liveTyping = this.liveTyping;
		range.inputVariant = this.inputVariant;
		#end
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