package valedit.events;

import openfl.events.Event;
import openfl.events.EventType;
import openfl.events.IEventDispatcher;
import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ValueEvent extends Event 
{
	/** dispatched when the value's isReadOnly property changes */
	inline static public var ACCESS_CHANGE:EventType<ValueEvent> = "access_change";
	/** dispatched when the value's isEditable property changes */
	inline static public var EDITABLE_CHANGE:EventType<ValueEvent> = "editable_change";
	inline static public var OBJECT_CHANGE:EventType<ValueEvent> = "object_change";
	inline static public var PROPERTY_CHANGE:EventType<ValueEvent> = "property_change";
	inline static public var VALUE_CHANGE:EventType<ValueEvent> = "value_change";
	
	#if !flash
	private static var _POOL:Array<ValueEvent> = new Array<ValueEvent>();
	
	private static function fromPool(type:String, value:ExposedValue, bubbles:Bool, cancelable:Bool):ValueEvent
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(type, value, bubbles, cancelable);
		return new ValueEvent(type, value, bubbles, cancelable);
	}
	#end
	
	static public function dispatch(dispatcher:IEventDispatcher, type:String, value:ExposedValue, bubbles:Bool = false, cancelable:Bool = false):Bool
	{
		#if flash
		return dispatcher.dispatchEvent(new ValueEvent(type, value, bubbles, cancelable));
		#else
		var event:ValueEvent = fromPool(type, value, bubbles, cancelable);
		var result:Bool = dispatcher.dispatchEvent(event);
		event.pool();
		return result;
		#end
	}
	
	public var value:ExposedValue;
	
	public function new(type:String, value:ExposedValue, bubbles:Bool=false, cancelable:Bool=false) 
	{
		super(type, bubbles, cancelable);
		this.value = value;
	}
	
	override public function clone():Event 
	{
		#if flash
		return new ValueEvent(this.type, this.value, this.bubbles, this.cancelable);
		#else
		return fromPool(this.type, this.value, this.bubbles, this.cancelable);
		#end
	}
	
	#if !flash
	public function pool():Void
	{
		this.value = null;
		this.target = null;
		this.currentTarget = null;
		this.__preventDefault = false;
		this.__isCanceled = false;
		this.__isCanceledNow = false;
		_POOL[_POOL.length] = this;
	}
	
	public function setTo(type:String, value:ExposedValue, bubbles:Bool = false, cancelable:Bool = false):ValueEvent
	{
		this.type = type;
		this.value = value;
		this.bubbles = bubbles;
		this.cancelable = cancelable;
		return this;
	}
	#end
	
}