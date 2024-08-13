package valedit;

/**
 * @author Matse
 */
interface IValEditContainer 
{
	public var cameraX(get, set):Float;
	public var cameraY(get, set):Float;
	public var x(get, set):Float;
	public var y(get, set):Float;
	
	function addObject(object:ValEditObject):Void;
	function getObject(objectID:String):ValEditObject;
	function pool():Void;
	function removeObject(object:ValEditObject):Void;
	function removeObjectCompletely(object:ValEditObject):Void;
}