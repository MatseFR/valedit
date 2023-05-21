package valedit.events;

import openfl.events.Event;
import openfl.events.EventType;
#if !flash
#if (openfl >= "9.1.0")
import openfl.utils.ObjectPool;
#else
import openfl._internal.utils.ObjectPool;
#end
#end
import openfl.events.IEventDispatcher;

/**
 * ...
 * @author Matse
 */
class ValueEvent extends Event 
{
	inline static public var EDITABLE_CHANGE:EventType<ValueEvent> = "editable_change";
	inline static public var OBJECT_CHANGE:EventType<ValueEvent> = "object_change";
	
	#if !flash
	static private var _pool:ObjectPool<ValueEvent> = new ObjectPool<ValueEvent>(() -> return new ValueEvent(null, false, false), (event) -> {
		event.target = null;
		event.currentTarget = null;
		event.__preventDefault = false;
		event.__isCanceled = false;
		event.__isCanceledNow = false;
	});
	#end
	
	static public function dispatch(dispatcher:IEventDispatcher, type:String, bubbles:Bool = false, cancelable:Bool = false):Bool
	{
		#if flash
		var event:ValueEvent = new ValueEvent(type, bubbles, cancelable);
		return dispatcher.dispatchEvent(event);
		#else
		var event:ValueEvent = _pool.get();
		event.type = type;
		event.bubbles = bubbles;
		event.cancelable = cancelable;
		var result:Bool = dispatcher.dispatchEvent(event);
		_pool.release(event);
		return result;
		#end
	}

	public function new(type:String, bubbles:Bool=false, cancelable:Bool=false) 
	{
		super(type, bubbles, cancelable);
	}
	
	override public function clone():Event 
	{
		return new ValueEvent(this.type, this.bubbles, this.cancelable);
	}
	
}