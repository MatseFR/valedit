package valedit;
import openfl.display.DisplayObjectContainer;

/**
 * @author Matse
 */
interface IContainerOpenFL 
{
	public var container(get, never):DisplayObjectContainer;
	public var rootContainer(get, set):DisplayObjectContainer;
}