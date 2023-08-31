package valedit.events;

import openfl.events.Event;
import openfl.events.IEventDispatcher;
import valeditor.events.DefaultEvent;

/**
 * ...
 * @author Matse
 */
class PlayEvent extends Event 
{
	inline static public var PLAY:String = "play";
	inline static public var STOP:String = "stop";
	
	#if !flash
	static private var _POOL:Array<PlayEvent> = new Array<PlayEvent>();
	
	static private function fromPool(type:String, bubbles:Bool, cancelable:Bool):PlayEvent
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(type, bubbles, cancelable);
		return new PlayEvent(type, bubbles, cancelable);
	}
	#end
	
	static public function dispatch(dispatcher:IEventDispatcher, type:String, 
									bubbles:Bool = false, cancelable:Bool = false):Bool
	{
		#if flash
		return dispatcher.dispatchEvent(new PlayEvent(type, bubbles, cancelable));
		#else
		var event:PlayEvent = fromPool(type, bubbles, cancelable);
		var result:Bool = dispatcher.dispatchEvent(event);
		event.pool();
		return result;
		#end
	}
	
	public function new(type:String, bubbles:Bool=false, cancelable:Bool=false) 
	{
		super(type, bubbles, cancelable);
	}
	
	override public function clone():Event 
	{
		#if flash
		return new PlayEvent(this.type, this.bubbles, this.cancelable);
		#else
		return fromPool(this.type, this.bubbles, this.cancelable);
		#end
	}
	
	#if !flash
	public function pool():Void
	{
		this.target = null;
		this.currentTarget = null;
		this.__preventDefault = false;
		this.__isCanceled = false;
		this.__isCanceledNow = false;
		_POOL[_POOL.length] = this;
	}
	
	public function setTo(type:String, bubbles:Bool = false, cancelable:Bool = false):DefaultEvent
	{
		this.type = type;
		this.bubbles = bubbles;
		this.cancelable = cancelable;
		return this;
	}
	#end
	
}