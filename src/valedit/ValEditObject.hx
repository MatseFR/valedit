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
	/** non-proxy object */
	public var realObject:Dynamic;
	public var template:ValEditTemplate;
	
	public function new(?name:String, ?object:Dynamic, ?className:String) 
	{
		this.name = name;
		this.object = object;
		this.className = className;
	}
	
}