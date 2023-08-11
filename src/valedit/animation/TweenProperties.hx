package valedit.animation;
import juggler.animation.Tween;

/**
 * ...
 * @author Matse
 */
class TweenProperties 
{
	static private var _POOL:Array<TweenProperties> = new Array<TweenProperties>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool():TweenProperties
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new TweenProperties();
	}
	
	public var names(default, null):Array<String> = new Array<String>();
	public var numProperties(get, never):Int;
	public var values(default, null):Array<Float> = new Array<Float>();
	
	private function get_numProperties():Int { return this.names.length; }
	
	public function new() 
	{
		
	}
	
	public function clear():Void
	{
		this.names.resize(0);
		this.values.resize(0);
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	public function addProperty(name:String, value:Float):Void
	{
		this.names[this.names.length] = name;
		this.values[this.values.length] = value;
	}
	
	public function applyToTween(tween:Tween):Void
	{
		var count:Int = this.names.length;
		for (i in 0...count)
		{
			tween.animate(this.names[i], this.values[i]);
		}
	}
	
}