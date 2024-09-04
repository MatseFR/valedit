package valedit;

import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;

/**
 * ...
 * @author Matse
 */
class SpriteContainerOpenFL extends Sprite implements IContainer implements IContainerOpenFL
{
	static private var _POOL:Array<SpriteContainerOpenFL> = new Array<SpriteContainerOpenFL>();
	
	static public function fromPool():SpriteContainerOpenFL
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new SpriteContainerOpenFL();
	}
	
	public var container(get, never):DisplayObjectContainer;
	public var rootContainer(get, set):DisplayObjectContainer;
	
	private function get_container():DisplayObjectContainer { return this; }
	
	private var _rootContainer:DisplayObjectContainer;
	private function get_rootContainer():DisplayObjectContainer { return this._rootContainer; }
	private function set_rootContainer(value:DisplayObjectContainer):DisplayObjectContainer
	{
		if (value == this._rootContainer) return value;
		
		if (this._rootContainer != null)
		{
			this._rootContainer.removeChild(this);
		}
		
		if (value != null)
		{
			value.addChild(this);
		}
		return this._rootContainer = value;
	}
	
	private var _objectMap:Map<String, ValEditObject> = new Map<String, ValEditObject>();
	private var _objects:Array<ValEditObject> = new Array<ValEditObject>();
	
	public function new() 
	{
		super();
	}
	
	public function clear():Void
	{
		this.rootContainer = null;
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
		else if (object.isContainerOpenFL)
		{
			cast(object.object, IContainerOpenFL).rootContainer = this;
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
		else if (object.isContainerOpenFL)
		{
			cast(object.object, IContainerOpenFL).rootContainer = null;
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