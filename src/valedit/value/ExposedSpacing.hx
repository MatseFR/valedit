package valedit.value;

import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedSpacing extends ExposedValue 
{
	static private var _POOL:Array<ExposedSpacing> = new Array<ExposedSpacing>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(name:String = ""):ExposedSpacing
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(name);
		return new ExposedSpacing(name);
	}
	
	public function new(name:String = "") 
	{
		super(name);
		this._isRealValue = false;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(name:String):ExposedSpacing
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
		var space:ExposedSpacing = new ExposedSpacing(this.name);
		return space;
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