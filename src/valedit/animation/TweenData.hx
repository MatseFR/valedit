package valedit.animation;
import haxe.ds.ObjectMap;

/**
 * ...
 * @author Matse
 */
class TweenData 
{
	static private var _POOL:Array<TweenData> = new Array<TweenData>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool():TweenData
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new TweenData();
	}
	
	private var _objectToProperties:ObjectMap<Dynamic, TweenProperties> = new ObjectMap<Dynamic, TweenProperties>();
	private var _properties:Array<TweenProperties> = new Array<TweenProperties>();
	
	public function new() 
	{
		
	}
	
	public function clear():Void
	{
		this._objectToProperties.clear();
		for (properties in this._properties)
		{
			properties.pool();
		}
		this._properties.resize(0);
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	public function addObject(object:Dynamic):TweenProperties
	{
		var properties:TweenProperties = TweenProperties.fromPool();
		properties.object = object;
		this._objectToProperties.set(object, properties);
		//this._properties[this._properties.length] = properties;
		this._properties.unshift(properties);
		return properties;
	}
	
	public function hasObject(object:Dynamic):Bool
	{
		return this._objectToProperties.exists(object);
	}
	
	public function getPropertiesForObject(object:Dynamic):TweenProperties
	{
		return this._objectToProperties.get(object);
	}
	
	public function removeObject(object:Dynamic):TweenProperties
	{
		var properties:TweenProperties = this._objectToProperties.get(object);
		this._objectToProperties.remove(object);
		this._properties.remove(properties);
		return properties;
	}
	
	public function buildTweens(duration:Float, transition:String, tweens:Array<FrameTween> = null):Array<FrameTween>
	{
		if (tweens == null) tweens = new Array<FrameTween>();
		
		var tween:FrameTween;
		for (properties in this._properties)
		{
			if (properties.numProperties == 0 && properties.onUpdate == null) continue;
			tween = FrameTween.fromPool(properties.object, duration, transition);
			properties.applyToTween(tween);
			tweens[tweens.length] = tween;
		}
		
		return tweens;
	}
	
}