package valedit.value;

import valedit.value.base.ExposedValue;
import valedit.value.base.ExposedValueTweenable;
import valedit.value.data.NumericMode;

/**
 * ...
 * @author Matse
 */
class ExposedInt extends ExposedValueTweenable 
{
	static private var _POOL:Array<ExposedInt> = new Array<ExposedInt>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null#if valeditor, numericMode:NumericMode = NumericMode.PositiveOrNegative#end):ExposedInt
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name#if valeditor, numericMode#end);
		return new ExposedInt(propertyName, name#if valeditor, numericMode#end);
	}
	
	#if valeditor
	public var inputVariant:String;
	public var liveTyping:Bool = true;
	public var numericMode:NumericMode;
	#end
	
	/**
	   
	   @param	propertyName
	   @param	name
	   @param	numericMode
	   @param	inputPercentWidth
	**/
	public function new(propertyName:String, name:String = null#if valeditor, numericMode:NumericMode = NumericMode.PositiveOrNegative#end) 
	{
		super(propertyName, name);
		#if valeditor
		this.numericMode = numericMode;
		#end
		this.defaultValue = 0;
	}
	
	override public function clear():Void 
	{
		super.clear();
		this.defaultValue = 0;
		#if valeditor
		this.inputVariant = null;
		this.liveTyping = true;
		#end
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, numericMode:NumericMode):ExposedInt
	{
		setNames(propertyName, name);
		#if valeditor
		this.numericMode = numericMode;
		#end
		return this;
	}
	
	public function clone(copyValue:Bool = false):ExposedValue 
	{
		var int:ExposedInt = fromPool(this.propertyName, this.name#if valeditor, this.numericMode#end);
		#if valeditor
		int.inputVariant = this.inputVariant;
		int.liveTyping = this.liveTyping;
		#end
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