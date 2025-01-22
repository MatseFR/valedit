package valedit.value;

import openfl.errors.Error;
import valedit.value.base.ExposedValue;
import valedit.value.base.ExposedValueTweenable;
import valedit.value.data.NumericMode;

/**
 * ...
 * @author Matse
 */
class ExposedFloat extends ExposedValueTweenable 
{
	static private var _POOL:Array<ExposedFloat> = new Array<ExposedFloat>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null#if valeditor, precision:Int = 2, numericMode:NumericMode = NumericMode.PositiveOrNegative#end):ExposedFloat
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name#if valeditor, precision, numericMode#end);
		return new ExposedFloat(propertyName, name#if valeditor, precision, numericMode#end);
	}
	
	#if valeditor
	public var inputVariant:String;
	public var liveTyping:Bool = false;
	public var numericMode:NumericMode;
	public var precision:Int;
	#end
	
	/**
	   
	   @param	propertyName
	   @param	name
	   @param	precision
	   @param	numericMode
	   @param	inputPercentWidth
	**/
	public function new(propertyName:String, name:String = null#if valeditor, precision:Int = 2, numericMode:NumericMode = NumericMode.PositiveOrNegative#end) 
	{
		super(propertyName, name);
		#if valeditor
		this.precision = precision;
		this.numericMode = numericMode;
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
			throw new Error("ExposedFloat.pool ::: already in pool");
		}
		#end
		clear();
		_POOL[_POOL.length] = this;
		this.isInPool = true;
	}
	
	private function setTo(propertyName:String, name:String#if valeditor, precision:Int, numericMode:NumericMode#end):ExposedFloat
	{
		setNames(propertyName, name);
		#if valeditor
		this.precision = precision;
		this.numericMode = numericMode;
		#end
		this.isInPool = false;
		return this;
	}
	
	public function clone(copyValue:Bool = false):ExposedValue 
	{
		var float:ExposedFloat = fromPool(this.propertyName, this.name#if valeditor, this.precision, this.numericMode#end);
		#if valeditor
		float.liveTyping = this.liveTyping;
		float.inputVariant = this.inputVariant;
		#end
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