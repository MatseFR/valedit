package valedit;
import openfl.display.DisplayObjectContainer;

/**
 * @author Matse
 */
interface IValEditOpenFLContainer 
{
	public var container(get, never):DisplayObjectContainer;
	public var rootContainer(get, set):DisplayObjectContainer;
}