package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedIntDrag extends ExposedValue 
{
	public var dragScaleFactor:Float;
	public var liveDragging:Bool;
	public var maximum:Float;
	public var minimum:Float;
	public var step:Int;
	
	public function new(propertyName:String, name:String = null, minimum:Null<Float> = null, maximum:Null<Float> = null,
						dragScaleFactor:Float = 1, step:Int = 1, liveDragging:Bool = true)
	{
		super(propertyName, name);
		
		if (minimum == null) minimum = Math.NEGATIVE_INFINITY;
		if (maximum == null) maximum = Math.POSITIVE_INFINITY;
		
		this.minimum = minimum;
		this.maximum = maximum;
		this.dragScaleFactor = dragScaleFactor;
		this.step = step;
		this.liveDragging = liveDragging;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var int:ExposedIntDrag = new ExposedIntDrag(this.propertyName, this.name, this.minimum, this.maximum,
													this.dragScaleFactor, this.step, this.liveDragging);
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