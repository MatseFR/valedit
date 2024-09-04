package valedit;

/**
 * @author Matse
 */
interface IContainer 
{
	public var x(get, set):Float;
	public var y(get, set):Float;
	
	function addObject(object:ValEditObject):Void;
	function getObject(objectID:String):ValEditObject;
	function removeObject(object:ValEditObject):Void;
	function removeObjectCompletely(object:ValEditObject):Void;
	function pool():Void;
	function fromJSONExport(json:Dynamic):Void;
}