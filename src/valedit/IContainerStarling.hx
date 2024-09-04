package valedit;
import starling.display.DisplayObjectContainer;

/**
 * @author Matse
 */
interface IContainerStarling 
{
	public var containerStarling(get, never):DisplayObjectContainer;
	public var rootContainerStarling(get, set):DisplayObjectContainer;
}