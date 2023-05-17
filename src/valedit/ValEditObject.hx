package valedit;

/**
 * ...
 * @author Matse
 */
class ValEditObject 
{
	public var className:String;
	public var name:String;
	public var object:Dynamic;
	
	public function new(?name:String, ?object:Dynamic, ?className:String) 
	{
		this.name = name;
		this.object = object;
		this.className = className;
	}
	
}