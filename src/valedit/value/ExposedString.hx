package valedit.value;

import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedString extends ExposedValue 
{
	static private var _POOL:Array<ExposedString> = new Array<ExposedString>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null, maxChars:Int = 0, restrict:String = null, inputPercentWidth:Float = 100):ExposedString
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, maxChars, restrict, inputPercentWidth);
		return new ExposedString(propertyName, name, maxChars, restrict, inputPercentWidth);
	}
	
	/* 0 = unlimited */
	public var maxChars:Int = 0;
	public var restrict:String = null;
	public var inputPercentWidth:Float;
	
	/**
	   
	   @param	name
	   @param	maxChars
	   @param	restrict
	   @param	inputWidthPercent
	**/
	public function new(propertyName:String, name:String = null, maxChars:Int = 0, restrict:String = null, inputPercentWidth:Float = 100) 
	{
		super(propertyName, name);
		this.maxChars = maxChars;
		this.restrict = restrict;
		this.inputPercentWidth = inputPercentWidth;
		this.defaultValue = "";
	}
	
	override public function clear():Void 
	{
		super.clear();
		this.defaultValue = "";
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, maxChars:Int, restrict:String, inputPercentWidth:Float):ExposedString
	{
		setNames(propertyName, name);
		this.maxChars = maxChars;
		this.restrict = restrict;
		this.inputPercentWidth = inputPercentWidth;
		return this;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var string:ExposedString = new ExposedString(this.propertyName, this.name, this.maxChars, this.restrict, this.inputPercentWidth);
		super.clone_internal(string, copyValue);
		return string;
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