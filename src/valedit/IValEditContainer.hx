package valedit;

/**
 * @author Matse
 */
interface IValEditContainer 
{
	public var currentLayer(get, set):ValEditLayer;
	
	function add(object:ValEditObject):Void;
	function remove(object:ValEditObject):Void;
}