package valedit.animation;

import juggler.animation.Tween;

/**
 * ...
 * @author Matse
 */
class FrameTween extends Tween 
{
	static private var _POOL:Array<FrameTween> = new Array<FrameTween>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(target:Dynamic, time:Float, transition:Dynamic = "linear"):FrameTween
	{
		if (_POOL.length != 0) return cast _POOL.pop().reset(target, time, transition);
		return new FrameTween(target, time, transition);
	}

	public function new(target:Dynamic, time:Float, transition:Dynamic="linear") 
	{
		super(target, time, transition);
	}
	
	public function setRatio(ratio:Float):Void
	{
		this.__progress = this.__transitionFunc(ratio);
		
		var numProperties:Int = this.__startValues.length;
		for (i in 0...numProperties)
		{
			if (this.__startValues[i] != this.__startValues[i]) // isNaN check - "isNaN" causes allocation!
			{
				this.__startValues[i] = Reflect.getProperty(this.__target, this.__properties[i]);
			}
			
			this.__updateFuncs[i](this.__properties[i], this.__startValues[i], this.__endValues[i]);
		}
	}
	
	override public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
}