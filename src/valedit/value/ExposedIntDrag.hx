package valedit.value;

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
	
	static public function fromPool(propertyName:String, name:String = null, minimum:Null<Float> = null, maximum:Null<Float> = null,
									dragScaleFactor:Float = 1, step:Int = 1, liveDragging:Bool = true, liveTyping:Bool = true):ExposedIntDrag
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, minimum, maximum, dragScaleFactor, step, liveDragging, liveTyping);
		return new ExposedIntDrag(propertyName, name, minimum, maximum, dragScaleFactor, step, liveDragging, liveTyping);
	}
	
	public var dragScaleFactor:Float;
	public var liveDragging:Bool;
	public var liveTyping:Bool;
	public var maximum:Float;
	public var minimum:Float;
	public var step:Int;
	
	public function new(propertyName:String, name:String = null, minimum:Null<Float> = null, maximum:Null<Float> = null,
						dragScaleFactor:Float = 1, step:Int = 1, liveDragging:Bool = true, liveTyping:Bool = true)
	{
		super(propertyName, name);
		
		if (minimum == null) minimum = Math.NEGATIVE_INFINITY;
		if (maximum == null) maximum = Math.POSITIVE_INFINITY;
		this.minimum = minimum;
		this.maximum = maximum;
		this.dragScaleFactor = dragScaleFactor;
		this.step = step;
		this.liveDragging = liveDragging;
		this.liveTyping = liveTyping;
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
	
	private function setTo(propertyName:String, name:String, minimum:Null<Float>, maximum:Null<Float>, dragScaleFactor:Float,
						   step:Int, liveDragging:Bool, liveTyping:Bool):ExposedIntDrag
	{
		setNames(propertyName, name);
		if (minimum == null) minimum = Math.NEGATIVE_INFINITY;
		if (maximum == null) maximum = Math.POSITIVE_INFINITY;
		this.minimum = minimum;
		this.maximum = maximum;
		this.dragScaleFactor = dragScaleFactor;
		this.step = step;
		this.liveDragging = liveDragging;
		this.liveTyping = liveTyping;
		return this;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var int:ExposedIntDrag = fromPool(this.propertyName, this.name, this.minimum, this.maximum,
										  this.dragScaleFactor, this.step, this.liveDragging, this.liveTyping);
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