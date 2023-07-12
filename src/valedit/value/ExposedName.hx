package valedit.value;

import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedName extends ExposedValue 
{
	static private var _POOL:Array<ExposedName> = new Array<ExposedName>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(name:String):ExposedName
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(name);
		return new ExposedName(name);
	}
	
	public function new(name:String) 
	{
		super(name);
		this._isRealValue = false;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(name:String):ExposedName
	{
		setNames(name, null);
		return this;
	}
	
	override public function applyToObject(object:Dynamic):Void 
	{
		// nothing
	}
	
	override public function readValue(dispatchEventIfChange:Bool = true):Void 
	{
		// nothing
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var name:ExposedName = fromPool(this.name);
		return name;
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		return null;
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		// nothing
	}
	
}