package valedit;

/**
 * ...
 * @author Matse
 */
class ValEditFrame 
{
	static private var _POOL:Array<ValEditFrame> = new Array<ValEditFrame>();
	
	static public function fromPool():ValEditFrame
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new ValEditFrame();
	}
	
	public var hasTween(get, never):Bool;
	public var indexStart:Int;
	public var indexEnd:Int;
	public var isEmpty(get, never):Bool;
	public var isKeyFrame(default, null):Bool = false;
	
	private function get_hasTween():Bool { return false; }
	private function get_isEmpty():Bool { return true; }
	
	public function new() 
	{
		
	}
	
	public function clear():Void
	{
		
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	public function enter():Void
	{
		
	}
	
	public function exit():Void
	{
		
	}
	
}