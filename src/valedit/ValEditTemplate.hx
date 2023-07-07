package valedit;
import openfl.events.EventDispatcher;

/**
 * ...
 * @author Matse
 */
class ValEditTemplate extends EventDispatcher
{
	static private var _POOL:Array<ValEditTemplate> = new Array<ValEditTemplate>();
	
	static public function fromPool(clss:ValEditClass, ?id:String, ?object:Dynamic, ?collection:ExposedCollection,
									?constructorCollection:ExposedCollection):ValEditTemplate
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(clss, id, object, collection, constructorCollection);
		return new ValEditTemplate(clss, id, object, collection, constructorCollection);
	}
	
	public var className:String;
	public var clss:ValEditClass;
	public var collection:ExposedCollection;
	public var constructorCollection:ExposedCollection;
	public var id(get, set):String;
	public var numInstances(default, null):Int = 0;
	public var object:Dynamic;
	
	private var _id:String;
	private function get_id():String { return this._id; }
	private function set_id(value:String):String
	{
		return this._id = value;
	}
	
	private var _instances:Array<ValEditObject> = new Array<ValEditObject>();
	
	public function new(clss:ValEditClass, ?id:String, ?object:Dynamic, ?collection:ExposedCollection, ?constructorCollection:ExposedCollection) 
	{
		super();
		setTo(clss, id, object, collection, constructorCollection);
	}
	
	public function clear():Void
	{
		this.clss = null;
		this.collection = null;
		this.constructorCollection = null;
		this.numInstances = 0;
		this.object = null;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(clss:ValEditClass, id:String, object:Dynamic, collection:ExposedCollection,
						   constructorCollection:ExposedCollection):ValEditTemplate
	{
		this.clss = clss;
		this.className = clss.className;
		this.id = id;
		this.object = object;
		this.collection = collection;
		this.constructorCollection = constructorCollection;
		
		return this;
	}
	
	public function addInstance(instance:ValEditObject):Void
	{
		instance.template = this;
		this._instances.push(instance);
		this.numInstances++;
	}
	
	public function removeInstance(instance:ValEditObject):Void
	{
		this._instances.remove(instance);
		this.numInstances--;
	}
	
	public function getConstructorValues(?values:Array<Dynamic>):Array<Dynamic>
	{
		if (values == null) values = [];
		if (this.constructorCollection != null)
		{
			this.constructorCollection.toValueArray(values);
		}
		return values;
	}
	
}