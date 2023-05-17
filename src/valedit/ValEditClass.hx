package valedit;
import feathers.data.ArrayCollection;
import feathers.data.TreeNode;
import flash.display.DisplayObjectContainer;
import haxe.ds.ObjectMap;

/**
 * ...
 * @author Matse
 */
class ValEditClass 
{
	public var canBeCreated(default, null):Bool;
	public var categories(default, null):Array<String> = new Array<String>();
	public var className(default, null):String;
	public var classReference(default, null):Class<Dynamic>;
	public var constructorCollection(default, null):ExposedCollection;
	public var instanceCount(default, null):Int = 0;
	public var sourceCollection(default, null):ExposedCollection;
	public var superClassNames(default, null):Array<String> = new Array<String>();
	
	private var _nameToObject:Map<String, Dynamic> = new Map<String, Dynamic>();
	private var _objectToName:ObjectMap<Dynamic, String> = new ObjectMap<Dynamic, String>();
	private var _objectNameIndex:Int = -1;
	
	private var _containers:Map<DisplayObjectContainer, ExposedCollection> = new Map<DisplayObjectContainer, ExposedCollection>();
	private var _pool:Array<ExposedCollection> = new Array<ExposedCollection>();
	
	private var _constructorContainers:Map<DisplayObjectContainer, ExposedCollection> = new Map<DisplayObjectContainer, ExposedCollection>();
	private var _constructorPool:Array<ExposedCollection> = new Array<ExposedCollection>();
	
	/**
	   
	**/
	public function new(classReference:Class<Dynamic>, className:String, sourceCollection:ExposedCollection, canBeCreated:Bool, ?constructorCollection:ExposedCollection) 
	{
		this.classReference = classReference;
		this.className = className;
		this.sourceCollection = sourceCollection;
		this.canBeCreated = canBeCreated;
		this.constructorCollection = constructorCollection;
	}
	
	/**
	   
	**/
	public function clear():Void
	{
		this.instanceCount = 0;
		
		this._nameToObject.clear();
		this._objectToName.clear();
		this._objectNameIndex = -1;
	}
	
	public function addCategory(category:String):Void
	{
		this.categories.push(category);
	}
	
	public function addSuperClassName(superClassName:String):Void
	{
		this.superClassNames.push(superClassName);
	}
	
	public function makeObjectName():String
	{
		var objName:String = null;
		while (true)
		{
			this._objectNameIndex++;
			objName = this.className + this._objectNameIndex;
			if (!this._nameToObject.exists(objName)) break;
		}
		return objName;
	}
	
	public function objectNameExists(name:String):Bool
	{
		return this._nameToObject.exists(name);
	}
	
	public function addObject(object:Dynamic, name:String = null):Void
	{
		if (name == null) name = makeObjectName();
		this._nameToObject.set(name, object);
		this._objectToName.set(object, name);
		this.instanceCount++;
	}
	
	public function getObjectByName(name:String):Dynamic
	{
		return this._nameToObject.get(name);
	}
	
	public function getObjectList(?objList:Array<Dynamic>):Array<Dynamic>
	{
		if (objList == null) objList = new Array<Dynamic>();
		
		for (obj in _nameToObject)
		{
			objList.push(obj);
		}
		
		return objList;
	}
	
	public function getObjectName(object:Dynamic):String
	{
		return this._objectToName.get(object);
	}
	
	public function hasObject(object:Dynamic):Bool
	{
		return this._objectToName.exists(object);
	}
	
	public function removeObject(object:Dynamic):Void
	{
		var name:String = this._objectToName.get(object);
		this._nameToObject.remove(name);
		this._objectToName.remove(object);
		this.instanceCount--;
	}
	
	public function removeObjectByName(name:String):Void
	{
		var object:Dynamic = this._nameToObject.get(name);
		this._nameToObject.remove(name);
		this._objectToName.remove(object);
		this.instanceCount--;
	}
	
	/**
	   
	   @param	container
	   @param	object
	   @param	parentValue
	**/
	public function addContainer(container:DisplayObjectContainer, object:Dynamic, parentValue:ExposedValue = null):ExposedCollection
	{
		var collection:ExposedCollection;
		if (this._pool.length != 0) 
		{
			collection = this._pool.pop();
		}
		else
		{
			collection = sourceCollection.clone();
			collection.buildUI();
		}
		
		this._containers[container] = collection;
		collection.parentValue = parentValue;
		collection.object = object;
		collection.uiContainer = container;
		
		return collection;
	}
	
	public function addConstructorContainer(container:DisplayObjectContainer):ExposedCollection
	{
		var collection:ExposedCollection;
		if (this._constructorPool.length != 0)
		{
			collection = this._constructorPool.pop();
		}
		else
		{
			collection = constructorCollection.clone();
			collection.buildUI();
		}
		
		this._constructorContainers[container] = collection;
		collection.uiContainer = container;
		
		return collection;
	}
	
	/**
	   
	   @param	container
	**/
	public function removeContainer(container:DisplayObjectContainer):Void
	{
		var collection:ExposedCollection = this._containers[container];
		if (collection != null)
		{
			this._containers.remove(container);
			collection.parentValue = null;
			collection.object = null;
			collection.uiContainer = null;
			this._pool.push(collection);
		}
		else
		{
			removeConstructorContainer(container);
		}
	}
	
	public function removeConstructorContainer(container:DisplayObjectContainer):Void
	{
		var collection:ExposedCollection = this._constructorContainers[container];
		if (collection != null)
		{
			this._constructorContainers.remove(container);
			collection.uiContainer = null;
			this._constructorPool.push(collection);
		}
	}
	
}