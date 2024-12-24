package valedit;
#if starling
import starling.display.DisplayObjectContainer;
import starling.display.Sprite3D;

/**
 * ...
 * @author Matse
 */
class SpriteContainerStarling3D extends Sprite3D implements IContainer implements IContainerStarling
{
	static private var _POOL:Array<SpriteContainerStarling3D> = new Array<SpriteContainerStarling3D>();
	
	static public function fromPool():SpriteContainerStarling3D
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new SpriteContainerStarling3D();
	}
	
	public var containerStarling(get, never):DisplayObjectContainer;
	public var rootContainerStarling(get, set):DisplayObjectContainer;
	
	private function get_containerStarling():DisplayObjectContainer { return this; }
	
	private var _rootContainerStarling:DisplayObjectContainer;
	private function get_rootContainerStarling():DisplayObjectContainer { return this._rootContainerStarling; }
	private function set_rootContainerStarling(value:DisplayObjectContainer):DisplayObjectContainer
	{
		if (value == this._rootContainerStarling) return value;
		
		if (this._rootContainerStarling != null)
		{
			this._rootContainerStarling.removeChild(this);
		}
		
		if (value != null)
		{
			value.addChild(this);
		}
		return this._rootContainerStarling = value;
	}
	
	private var _objectMap:Map<String, ValEditObject> = new Map<String, ValEditObject>();
	private var _objects:Array<ValEditObject> = new Array<ValEditObject>();
	
	public function new() 
	{
		super();
	}
	
	public function clear():Void
	{
		this.rootContainerStarling = null;
		removeChildren();
		for (object in this._objects)
		{
			ValEdit.destroyObject(object);
		}
		this._objectMap.clear();
		this._objects.resize(0);
		
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	public function addObject(object:ValEditObject):Void
	{
		this._objectMap.set(object.objectID, object);
		this._objects[this._objects.length] = object;
		
		if (object.isDisplayObject)
		{
			addChild(cast object.object);
		}
		else if (object.isContainerStarling)
		{
			cast(object.object, IContainerStarling).rootContainerStarling = this;
		}
		
		object.container = this;
	}
	
	public function getObject(objectID:String):ValEditObject
	{
		return this._objectMap.get(objectID);
	}
	
	public function removeObject(object:ValEditObject):Void
	{
		this._objectMap.remove(object.objectID);
		this._objects.remove(object);
		
		if (object.isDisplayObject)
		{
			removeChild(cast object.object);
		}
		else if (object.isContainerStarling)
		{
			cast(object.object, IContainerStarling).rootContainerStarling = null;
		}
		
		object.container = null;
	}
	
	public function removeObjectCompletely(object:ValEditObject):Void
	{
		removeObject(object);
	}
	
	public function fromJSONExport(json:Dynamic):Void
	{
		var object:ValEditObject;
		var objects:Array<Dynamic> = json.objects;
		for (data in objects)
		{
			if (data.templateID != null)
			{
				object = ValEdit.getTemplate(data.templateID).getInstance(data.id);
			}
			else
			{
				object = ValEdit.getValEditClassByClassName(data.clss).getObjectByID(data.id);
			}
			object.currentCollection.apply();
			addObject(object);
		}
	}
	
}
#end