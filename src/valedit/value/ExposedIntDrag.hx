package valedit.value;

import openfl.errors.Error;
import valedit.value.base.ExposedValue;
import valedit.value.base.ExposedValueTweenable;

/**
 * ...
 * @author Matse
 */
class ExposedIntDrag extends ExposedValueTweenable 
{
	static private var _POOL:Array<ExposedIntDrag> = new Array<ExposedIntDrag>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null#if valeditor, minimum:Null<Float> = null, maximum:Null<Float> = null, dragScaleFactor:Float = 1, step:Int = 1#end):ExposedIntDrag
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name#if valeditor, minimum, maximum, dragScaleFactor, step#end);
		return new ExposedIntDrag(propertyName, name#if valeditor, minimum, maximum, dragScaleFactor, step#end);
	}
	
	#if valeditor
	public var dragScaleFactor:Float;
	public var liveDragging:Bool = true;
	public var liveTyping:Bool = false;
	public var maximum:Float;
	public var minimum:Float;
	public var step:Int;
	#end
	
	public function new(propertyName:String, name:String = null#if valeditor, minimum:Null<Float> = null, maximum:Null<Float> = null, dragScaleFactor:Float = 1, step:Int = 1#end)
	{
		super(propertyName, name);
		#if valeditor
		if (minimum == null) minimum = Math.NEGATIVE_INFINITY;
		if (maximum == null) maximum = Math.POSITIVE_INFINITY;
		this.minimum = minimum;
		this.maximum = maximum;
		this.dragScaleFactor = dragScaleFactor;
		this.step = step;
		#end
		this.defaultValue = 0;
	}
	
	override public function clear():Void 
	{
		super.clear();
		#if valeditor
		this.liveDragging = true;
		this.liveTyping = false;
		#end
		this.defaultValue = 0;
	}
	
	public function pool():Void
	{
		#if debug
		if (this.isInPool)
		{
			throw new Error("ExposedIntDrag.pool ::: already in pool");
		}
		#end
		clear();
		_POOL[_POOL.length] = this;
		this.isInPool = true;
	}
	
	private function setTo(propertyName:String, name:String#if valeditor, minimum:Null<Float>, maximum:Null<Float>, dragScaleFactor:Float, step:Int#end):ExposedIntDrag
	{
		setNames(propertyName, name);
		#if valeditor
		if (minimum == null) minimum = Math.NEGATIVE_INFINITY;
		if (maximum == null) maximum = Math.POSITIVE_INFINITY;
		this.minimum = minimum;
		this.maximum = maximum;
		this.dragScaleFactor = dragScaleFactor;
		this.step = step;
		#end
		this.isInPool = false;
		return this;
	}
	
	public function clone(copyValue:Bool = false):ExposedValue 
	{
		var int:ExposedIntDrag = fromPool(this.propertyName, this.name, this.minimum, this.maximum, this.dragScaleFactor, this.step);
		#if valeditor
		int.liveDragging = this.liveDragging;
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