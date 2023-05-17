package valedit;

/**
 * ...
 * @author Matse
 */
class ValEditTemplate 
{
	public var className:String;
	public var name:String;
	public var collection:ExposedCollection;
	
	public var numInstances(get, never):Int;
	private function get_numInstances():Int { return this._instances.length; }
	
	private var _instances:Array<ValEditObject> = new Array<ValEditObject>();
	
	public function new(?name:String, ?className:String, ?collection:ExposedCollection) 
	{
		this.name = name;
		this.className = className;
		this.collection = collection;
	}
	
	public function addInstance(instance:ValEditObject):Void
	{
		this._instances.push(instance);
	}
	
	public function removeInstance(instance:ValEditObject):Void
	{
		this._instances.remove(instance);
	}
	
}