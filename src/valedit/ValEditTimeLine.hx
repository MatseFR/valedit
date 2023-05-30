package valedit;

/**
 * ...
 * @author Matse
 */
class ValEditTimeLine 
{
	public var numFrames(get, set):Int;
	private var _numFrames:Int = 1;
	private function get_numFrames():Int { return this._numFrames; }
	private function set_numFrames(value:Int):Int
	{
		return this._numFrames;
	}
	
	public function new() 
	{
		
	}
	
}