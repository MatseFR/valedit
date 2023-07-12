package valedit.value;

import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedColor extends ExposedValue 
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
		this.defaultValue = 0xffffff;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String):ExposedColor
	{
		setNames(propertyName, name);
		return this;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var color:ExposedColor = fromPool(this.propertyName, this.name);
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