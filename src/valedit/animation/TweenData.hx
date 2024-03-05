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
	
	public var numObjects(get, never):Int;
	public var numProperties(get, never):Int;
	
	private function get_numObjects():Int { return this._properties.length; }
	private function get_numProperties():Int
	{
		var count:Int = 0;
		for (properties in this._properties)
		{
			count += properties.numProperties;
		}
		return count;
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
		this._properties[this._properties.length] = properties;
		return properties;
	}
	
	public function addProperties(properties:TweenProperties):Void
	{
		this._objectToProperties.set(properties.object, properties);
		this._properties[this._properties.length] = properties;
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
			if (properties.numProperties == 0 && properties.onUpdate == null) continue; // TODO : this is probably not needed anymore
			tween = FrameTween.fromPool(properties.object, duration, transition);
			properties.applyToTween(tween);
			tweens[tweens.length] = tween;
		}
		
		return tweens;
	}
	
}