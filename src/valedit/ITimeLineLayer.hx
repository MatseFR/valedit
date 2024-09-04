package valedit;
import openfl.events.IEventDispatcher;

/**
 * @author Matse
 */
interface ITimeLineLayer extends IEventDispatcher
{
	public var allObjects(default, null):Array<ValEditObject>;
	public var name(get, set):String;
	public var timeLine(default, null):ValEditTimeLine;
	public var visible(get, set):Bool;
	
	function clear():Void;
	function pool():Void;
	function addObject(object:ValEditObject):Void;
	function removeObject(object:ValEditObject):Void;
}