package valedit.value;

import openfl.errors.Error;
import valedit.value.base.ExposedValue;
import valedit.value.base.ExposedValueTweenable;

/**
 * ...
 * @author Matse
 */
class ExposedColor extends ExposedValueTweenable 
{
	static private var _POOL:Array<ExposedColor> = new Array<ExposedColor>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null):ExposedColor
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name);
		return new ExposedColor(propertyName, name);
	}
	
	#if valeditor
	public var liveDragging:Bool = true;
	public var liveTyping:Bool = true;
	#end
	
	/**
	   
	   @param	propertyName
	   @param	name
	**/
	public function new(propertyName:String, name:String = null) 
	{
		super(propertyName, name);
		this.defaultValue = 0xffffff;
	}
	
	override public function clear():Void 
	{
		super.clear();
		#if valeditor
		this.liveDragging = true;
		this.liveTyping = true;
		#end
		this.defaultValue = 0xffffff;
	}
	
	public function pool():Void
	{
		#if debug
		if (this.isInPool)
		{
			throw new Error("ExposedColor.pool ::: already in pool");
		}
		#end
		clear();
		_POOL[_POOL.length] = this;
		this.isInPool = true;
	}
	
	private function setTo(propertyName:String, name:String):ExposedColor
	{
		setNames(propertyName, name);
		this.isInPool = false;
		return this;
	}
	
	public function clone(copyValue:Bool = false):ExposedValue 
	{
		var color:ExposedColor = fromPool(this.propertyName, this.name);
		#if valeditor
		color.liveDragging = this.liveDragging;
		color.liveTyping = this.liveTyping;
		#end
		super.clone_internal(color, copyValue);
		return color;
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