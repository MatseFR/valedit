package valedit;
import openfl.display.BlendMode;
import openfl.display.DisplayObjectContainer;

/**
 * @author Matse
 */
interface IValEditContainer 
{
	public var alpha(get, set):Float;
	public var blendMode(get, set):BlendMode;
	#if starling
	public var blendModeStarling(get, set):String;
	#end
	public var cameraX(get, set):Float;
	public var cameraY(get, set):Float;
	public var container(get, never):DisplayObjectContainer;
	#if starling
	public var containerStarling(get, never):starling.display.DisplayObjectContainer;
	#end
	public var rootContainer(get, set):DisplayObjectContainer;
	#if starling
	public var rootContainerStarling(get, set):starling.display.DisplayObjectContainer;
	#end
	public var rotation(get, set):Float;
	public var scaleX(get, set):Float;
	public var scaleY(get, set):Float;
	public var visible(get, set):Bool;
	public var x(get, set):Float;
	public var y(get, set):Float;
	
	function addObject(object:ValEditObject):Void;
	function getObject(objectID:String):ValEditObject;
	function pool():Void;
	function removeObject(object:ValEditObject):Void;
}