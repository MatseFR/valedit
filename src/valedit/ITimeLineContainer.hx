package valedit;
import juggler.animation.Juggler;

/**
 * @author Matse
 */
interface ITimeLineContainer
{
	public var currentLayer(get, set):ITimeLineLayer;
	public var frameIndex(get, set):Int;
	public var frameRate(get, set):Float;
	public var isPlaying(get, never):Bool;
	public var juggler(get, set):Juggler;
	public var lastFrameIndex(get, never):Int;
	public var timeLine(default, null):ValEditTimeLine;
	
	function play():Void;
	function stop():Void;
	function createLayer():ITimeLineLayer;
}