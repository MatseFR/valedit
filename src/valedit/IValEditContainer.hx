package valedit;
import juggler.animation.Juggler;
import openfl.display.DisplayObjectContainer;

/**
 * @author Matse
 */
interface IValEditContainer 
{
	public var cameraX(get, set):Float;
	public var cameraY(get, set):Float;
	public var currentLayer(get, set):ValEditLayer;
	public var frameIndex(get, set):Int;
	public var isPlaying(get, never):Bool;
	public var juggler(get, set):Juggler;
	public var lastFrameIndex(get, never):Int;
	public var rootContainer(get, set):DisplayObjectContainer;
	#if starling
	public var rootContainerStarling(get, set):starling.display.DisplayObjectContainer;
	#end
	public var timeLine(default, null):ValEditTimeLine;
	public var x(get, set):Float;
	public var y(get, set):Float;
	
	function add(object:ValEditObject):Void;
	function play():Void;
	function pool():Void;
	function remove(object:ValEditObject):Void;
	function stop():Void;
}