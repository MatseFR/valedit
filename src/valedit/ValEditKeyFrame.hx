package valedit;
import juggler.animation.Transitions;
import openfl.events.EventDispatcher;
import valedit.animation.FrameTween;
import valedit.animation.TweenProperties;

/**
 * ...
 * @author Matse
 */
class ValEditKeyFrame extends EventDispatcher
{
	static private var _POOL:Array<ValEditKeyFrame> = new Array<ValEditKeyFrame>();
	
	static public function fromPool():ValEditKeyFrame
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new ValEditKeyFrame();
	}
	
	public var activateFunction:ValEditObject->Void;
	public var deactivateFunction:ValEditObject->Void;
	public var duration(get, never):Float;
	public var indexCurrent(get, set):Int;
	public var indexEnd:Int;
	public var indexStart:Int;
	public var isActive(default, null):Bool;
	public var isEmpty(get, never):Bool;
	public var objects:Array<ValEditObject> = new Array<ValEditObject>();
	public var timeLine:ValEditTimeLine;
	public var transition(get, set):String;// = Transitions.LINEAR;
	public var tween(get, set):Bool;
	
	private function get_duration():Float { return (this.indexEnd - this.indexStart + 1) / this.timeLine.frameRate; }
	
	private var _indexCurrent:Int = -1;
	private function get_indexCurrent():Int { return this._indexCurrent; }
	private function set_indexCurrent(value:Int):Int
	{
		if (this._indexCurrent == value) return value;
		if (this.isActive && this._tween) updateTweens();
		return this._indexCurrent = value;
	}
	
	private function get_isEmpty():Bool { return this.objects.length == 0; }
	
	private var _transition:String = Transitions.LINEAR;
	private function get_transition():String { return this._transition; }
	private function set_transition(value:String):String
	{
		if (this._transition == value) return value;
		for (tween in this._tweens)
		{
			tween.transition = value;
		}
		return this._transition = value;
	}
	
	private var _tween:Bool = false;
	private function get_tween():Bool { return this._tween; }
	private function set_tween(value:Bool):Bool
	{
		if (this._tween == value) return value;
		
		if (value)
		{
			buildTweens();
		}
		else
		{
			resetTweens();
			clearTweens();
		}
		return this._tween = value;
	}
	
	private var _tweenObjectMap:Map<ValEditObject, ValEditObject> = new Map<ValEditObject, ValEditObject>();
	private var _tweens:Array<FrameTween> = new Array<FrameTween>();
	
	public function new() 
	{
		super();
	}
	
	public function clear():Void
	{
		this.activateFunction = null;
		this.deactivateFunction = null;
		for (object in this.objects)
		{
			ValEdit.destroyObject(object);
		}
		this.objects.resize(0);
		this.timeLine = null;
		this._transition = Transitions.LINEAR;
		this.tween = false;
		this._indexCurrent = -1;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	public function add(object:ValEditObject):Void
	{
		this.objects[this.objects.length] = object;
		if (this.isActive)
		{
			activateFunction(object);
		}
	}
	
	public function remove(object:ValEditObject):Void
	{
		this.objects.remove(object);
		if (this.isActive)
		{
			deactivateFunction(object);
		}
	}
	
	public function enter():Void
	{
		for (object in this.objects)
		{
			activateFunction(object);
		}
		this.isActive = true;
	}
	
	public function exit():Void
	{
		for (object in this.objects)
		{
			deactivateFunction(object);
		}
		this.isActive = false;
		this._indexCurrent = -1;
	}
	
	private function buildTweens():Void
	{
		var nextFrame:ValEditKeyFrame = this.timeLine.getNextKeyFrame(this);
		if (nextFrame == null) return;
		var duration:Float = this.duration;
		var tween:FrameTween;
		var tweenProperties:TweenProperties;
		
		for (object in this.objects)
		{
			for (nextObject in nextFrame.objects)
			{
				if (this._tweenObjectMap.exists(nextObject)) continue;
				
				if (object.clss == nextObject.clss && object.template == nextObject.template)
				{
					this._tweenObjectMap.set(nextObject, nextObject);
					tweenProperties = object.collection.getTweenProperties(nextObject.collection);
					if (tweenProperties != null)
					{
						tween = FrameTween.fromPool(object.object, duration, this._transition);
						tweenProperties.applyToTween(tween);
						tweenProperties.pool();
						this._tweens[this._tweens.length] = tween;
					}
					break;
				}
			}
		}
		
		this._tweenObjectMap.clear();
	}
	
	private function clearTweens():Void
	{
		for (twn in this._tweens)
		{
			twn.pool();
		}
		this._tweens.resize(0);
	}
	
	private function rebuildTweens():Void
	{
		if (!this._tween) return;
		resetTweens();
		clearTweens();
		buildTweens();
	}
	
	private function updateTweens():Void
	{
		var ratio:Float = (this._indexCurrent - this.indexStart) / (this.indexEnd - this.indexStart + 1);
		for (tween in this._tweens)
		{
			tween.setRatio(ratio);
		}
	}
	
	private function resetTweens():Void
	{
		for (tween in this._tweens)
		{
			tween.setRatio(0);
		}
	}
	
}