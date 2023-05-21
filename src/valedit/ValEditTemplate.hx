package valedit;

/**
 * ...
 * @author Matse
 */
class ValEditTemplate 
{
	public var className:String;
	public var collection:ExposedCollection;
	public var constructorCollection:ExposedCollection;
	public var name:String;
	public var numInstances(default, null):Int;
	public var object:Dynamic;
	
	private var _instances:Array<ValEditObject> = new Array<ValEditObject>();
	
	public function new(?name:String, ?object:Dynamic, ?className:String, ?collection:ExposedCollection, ?constructorCollection:ExposedCollection) 
	{
		this.name = name;
		this.object = object;
		this.className = className;
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