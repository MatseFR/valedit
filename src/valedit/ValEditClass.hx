package valedit;
import flash.display.DisplayObjectContainer;

/**
 * ...
 * @author Matse
 */
class ValEditClass 
{
	public var classReference:Class<Dynamic>;
	public var name:String;
	public var sourceCollection:ExposedCollection;
	
	private var _containers:Map<DisplayObjectContainer, ExposedCollection> = new Map<DisplayObjectContainer, ExposedCollection>();
	private var _pool:Array<ExposedCollection> = new Array<ExposedCollection>();
	
	/**
	   
	**/
	public function new() 
	{
		
	}
	
	/**
	   
	**/
	public function clear():Void
	{
		classReference = null;
		sourceCollection = null;
	}
	
	/**
	   
	   @param	container
	   @param	object
	   @param	parentValue
	**/
	public function addContainer(container:DisplayObjectContainer, object:Dynamic, parentValue:ExposedValue = null):Void
	{
		var collection:ExposedCollection;
		if (_pool.length != 0) 
		{
			collection = _pool.pop();
		}
		else
		{
			collection = sourceCollection.clone();
			collection.buildUI();
		}
		
		_containers[container] = collection;
		collection.parentValue = parentValue;
		collection.object = object;
		collection.uiContainer = container;
	}
	
	/**
	   
	   @param	container
	**/
	public function removeContainer(container:DisplayObjectContainer):Void
	{
		var collection:ExposedCollection = _containers[container];
		if (collection != null)
		{
			_containers.remove(container);
			collection.parentValue = null;
			collection.object = null;
			collection.uiContainer = null;
			_pool.push(collection);
		}
	}
	
}