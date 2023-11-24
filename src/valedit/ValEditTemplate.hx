package valedit;
import openfl.errors.Error;
import openfl.events.EventDispatcher;

/**
 * ...
 * @author Matse
 */
class ValEditTemplate extends EventDispatcher
{
	static private var _POOL:Array<ValEditTemplate> = new Array<ValEditTemplate>();
	
	static public function fromPool(clss:ValEditClass, ?id:String, ?collection:ExposedCollection,
									?constructorCollection:ExposedCollection):ValEditTemplate
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(clss, id, collection, constructorCollection);
		return new ValEditTemplate(clss, id, collection, constructorCollection);
	}
	
	public var clss:ValEditClass;
	public var collection:ExposedCollection;
	public var constructorCollection:ExposedCollection;
	public var id(get, set):String;
	public var instances(get, never):Array<ValEditObject>;
	public var numInstances(default, null):Int = 0;
	public var object(get, set):ValEditObject;
	
	private var _id:String;
	private function get_id():String { return this._id; }
	private function set_id(value:String):String
	{
		return this._id = value;
	}
	
	private var _instances:Array<ValEditObject> = new Array<ValEditObject>();
	private function get_instances():Array<ValEditObject> { return this._instances; }
	
	private var _object:ValEditObject;
	private function get_object():ValEditObject { return this._object; }
	private function set_object(value:ValEditObject):ValEditObject
	{
		return this._object = value;
	}
	
	private var _instanceMap:Map<String, ValEditObject> = new Map<String, ValEditObject>();
	
	public function new(clss:ValEditClass, ?id:String, ?collection:ExposedCollection, ?constructorCollection:ExposedCollection) 
	{
		super();
		setTo(clss, id, collection, constructorCollection);
	}
	
	public function clear():Void
	{
		this.clss = null;
		this.collection = null;
		this.constructorCollection = null;
		
		if (this.object != null)
		{
			ValEdit.destroyObject(this.object);
			this.object = null;
		}
		
		for (instance in this._instances)
		{
			ValEdit.destroyObject(instance);
		}
		this._instances.resize(0);
		this._instanceMap.clear();
		
		// DEBUG
		if (this.numInstances != 0)
		{
			throw new Error("ValEditTemplate ::: non-zero numInstances after clear");
		}
		//\DEBUG
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	public function canBeDestroyed():Bool
	{
		return this.numInstances == 0;
	}
	
	private function setTo(clss:ValEditClass, id:String, collection:ExposedCollection,
						   constructorCollection:ExposedCollection):ValEditTemplate
	{
		this.clss = clss;
		this.id = id;
		this.collection = collection;
		this.constructorCollection = constructorCollection;
		
		return this;
	}
	
	public function addInstance(instance:ValEditObject):Void
	{
		instance.template = this;
		this._instances[this._instances.length] = instance;
		this._instanceMap.set(instance.id, instance);
		this.numInstances++;
	}
	
	public function getInstance(id:String):ValEditObject
	{
		return this._instanceMap.get(id);
	}
	
	public function removeInstance(instance:ValEditObject):Void
	{
		instance.template = null;
		if (this._instances.remove(instance))
		{
			this.numInstances--;
		}
		this._instanceMap.remove(instance.id);
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
	
	public function loadComplete():Void
	{
		for (instance in this._instances)
		{
			instance.loadComplete();
		}
	}
	
}