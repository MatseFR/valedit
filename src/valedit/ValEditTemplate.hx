package valedit;

/**
 * ...
 * @author Matse
 */
class ValEditTemplate 
{
	public var className:String;
	public var clss:ValEditClass;
	public var collection:ExposedCollection;
	public var constructorCollection:ExposedCollection;
	public var id:String;
	public var numInstances(default, null):Int;
	public var object:Dynamic;
	
	private var _instances:Array<ValEditObject> = new Array<ValEditObject>();
	
	public function new(clss:ValEditClass, ?id:String, ?object:Dynamic, ?collection:ExposedCollection, ?constructorCollection:ExposedCollection) 
	{
		this.clss = clss;
		this.className = clss.className;
		this.id = id;
		this.object = object;
		this.collection = collection;
		this.constructorCollection = constructorCollection;
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