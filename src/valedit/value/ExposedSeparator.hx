package valedit.value;

import valedit.value.base.ExposedNotValue;
import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedSeparator extends ExposedNotValue 
{
	static private var _POOL:Array<ExposedSeparator> = new Array<ExposedSeparator>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(name:String = ""):ExposedSeparator
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(name);
		return new ExposedSeparator(name);
	}
	
	public function new(name:String="") 
	{
		super(name);
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(name:String):ExposedSeparator
	{
		setNames(name, null);
		return this;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var separator:ExposedSeparator = new ExposedSeparator(this.name);
		return separator;
	}
	
}