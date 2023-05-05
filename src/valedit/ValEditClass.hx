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
		this.classReference = null;
		this.sourceCollection = null;
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
	}
	
}