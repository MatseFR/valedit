package valedit;

/**
 * ...
 * @author Matse
 */
class ValEditInstance 
{
	static private var _POOL:Array<ValEditInstance> = new Array<ValEditInstance>();
	
	static public function fromPool(object:ValEditObject, collection:ExposedCollection):ValEditInstance
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(object, collection);
		return new ValEditInstance(object, collection);
	}
	
	public var collection:ExposedCollection;
	public var object:ValEditObject;

	public function new(object:ValEditObject, collection:ExposedCollection) 
	{
		this.object = object;
		this.collection = collection;
	}
	
	public function clear():Void
	{
		this.object = null;
		this.collection.pool();
		this.collection = null;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(object:ValEditObject, collection:ExposedCollection):ValEditInstance
	{
		this.object = object;
		this.collection = collection;
		return this;
	}
	
	public function activate():Void
	{
		this.collection.applyToObject(this.object.object);
	}
	
	public function deactivate():Void
	{
		
	}
	
}