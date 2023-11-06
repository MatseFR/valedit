package valedit.animation;
import haxe.Constraints.Function;
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
	public var object:Dynamic;
	public var onUpdate:Function;
	public var onUpdateArgs:Array<Dynamic>;
	public var startValues(default, null):Array<Float> = new Array<Float>();
	public var targetValues(default, null):Array<Float> = new Array<Float>();
	
	private function get_numProperties():Int { return this.names.length; }
	
	public function new() 
	{
		
	}
	
	public function clear():Void
	{
		this.names.resize(0);
		this.object = null;
		this.onUpdate = null;
		this.onUpdateArgs = null;
		this.startValues.resize(0);
		this.targetValues.resize(0);
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	public function addProperty(name:String, startValue:Float, targetValue:Float):Void
	{
		this.names[this.names.length] = name;
		this.startValues[this.startValues.length] = startValue;
		this.targetValues[this.targetValues.length] = targetValue;
	}
	
	public function applyToTween(tween:Tween):Void
	{
		var count:Int = this.names.length;
		for (i in 0...count)
		{
			tween.animateStartEnd(this.names[i], this.startValues[i], this.targetValues[i]);
		}
		tween.onUpdate = this.onUpdate;
		tween.onUpdateArgs = this.onUpdateArgs;
	}
	
}