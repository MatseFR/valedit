package valedit;
#if starling
import openfl.display.BlendMode;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import openfl.events.EventDispatcher;
import starling.utils.MathUtil;

/**
 * ...
 * @author Matse
 */
class SpriteContainerOpenFLStarling extends EventDispatcher implements IContainer implements IContainerOpenFL implements IContainerStarling
{
	static private var _POOL:Array<SpriteContainerOpenFLStarling> = new Array<SpriteContainerOpenFLStarling>();
	
	static public function fromPool():SpriteContainerOpenFLStarling
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new SpriteContainerOpenFLStarling();
	}
	
	public var alpha(get, set):Float;
	public var blendMode(get, set):BlendMode;
	public var blendModeStarling(get, set):String;
	public var container(get, never):DisplayObjectContainer;
	public var containerStarling(get, never):starling.display.DisplayObjectContainer;
	public var height(get, set):Float;
	public var rootContainer(get, set):DisplayObjectContainer;
	public var rootContainerStarling(get, set):starling.display.DisplayObjectContainer;
	public var rotation(get, set):Float;
	public var scaleX(get, set):Float;
	public var scaleY(get, set):Float;
	public var width(get, set):Float;
	public var x(get, set):Float;
	public var y(get, set):Float;
	
	private function get_alpha():Float { return this._container.alpha; }
	private function set_alpha(value:Float):Float
	{
		return this._container.alpha = this._containerStarling.alpha = value;
	}
	
	private function get_blendMode():BlendMode { return this._container.blendMode; }
	private function set_blendMode(value:BlendMode):BlendMode
	{
		return this._container.blendMode = value;
	}
	
	private function get_blendModeStarling():String { return this._containerStarling.blendMode; }
	private function set_blendModeStarling(value:String):String
	{
		return this._containerStarling.blendMode = value;
	}
	
	private var _container:Sprite = new Sprite();
	private function get_container():Sprite { return this._container; }
	
	private var _containerStarling:starling.display.Sprite = new starling.display.Sprite();
	private function get_containerStarling():starling.display.Sprite { return this._containerStarling; }
	
	private function get_height():Float { return Math.max(this._container.height, this._containerStarling.height); }
	private function set_height(value:Float):Float
	{
		var h:Float = this.height / this.scaleY;
		if (h == 0.0) return h;
		this.scaleY = value / h;
		return value;
	}
	
	private var _rootContainer:DisplayObjectContainer;
	private function get_rootContainer():DisplayObjectContainer { return this._rootContainer; }
	private function set_rootContainer(value:DisplayObjectContainer):DisplayObjectContainer
	{
		if (this._rootContainer == value) return value;
		
		if (value != null)
		{
			value.addChild(this._container);
		}
		else if (this._rootContainer != null)
		{
			this._rootContainer.removeChild(this._container);
		}
		
		return this._rootContainer = value;
	}
	
	private var _rootContainerStarling:starling.display.DisplayObjectContainer;
	private function get_rootContainerStarling():starling.display.DisplayObjectContainer { return this._rootContainerStarling; }
	private function set_rootContainerStarling(value:starling.display.DisplayObjectContainer):starling.display.DisplayObjectContainer
	{
		if (this._rootContainerStarling == value) return value;
		
		if (value != null)
		{
			value.addChild(this._containerStarling);
		}
		else
		{
			this._containerStarling.removeFromParent();
		}
		
		return this._rootContainerStarling = value;
	}
	
	private function get_rotation():Float { return this._container.rotation; }
	private function set_rotation(value:Float):Float
	{
		this._containerStarling.rotation = MathUtil.deg2rad(value);
		return this._container.rotation = value;
	}
	
	private function get_scaleX():Float { return this._container.scaleX; }
	private function set_scaleX(value:Float):Float
	{
		return this._container.scaleX = this._containerStarling.scaleX = value;
	}
	
	private function get_scaleY():Float { return this._container.scaleY; }
	private function set_scaleY(value:Float):Float
	{
		return this._container.scaleY = this._containerStarling.scaleY = value;
	}
	
	private function get_visible():Bool { return this._container.visible; }
	private function set_visible(value:Bool):Bool
	{
		return this._container.visible = this._containerStarling.visible = value;
	}
	
	private function get_width():Float { return Math.max(this._container.width, this._containerStarling.width); }
	private function set_width(value:Float):Float
	{
		var w:Float = this.width / this.scaleX;
		if (w == 0.0) return w;
		this.scaleX = value / w;
		return value;
	}
	
	private function get_x():Float { return this._container.x; }
	private function set_x(value:Float):Float
	{
		return this._container.x = this._containerStarling.x = value;
	}
	
	private function get_y():Float { return this._container.y; }
	private function set_y(value:Float):Float
	{
		return this._container.y = this._containerStarling.y = value;
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
		this.rootContainerStarling = null;
		this._container.removeChildren();
		this._containerStarling.removeChildren();
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
			if (object.displayObjectType == DisplayObjectType.OPENFL)
			{
				this._container.addChild(cast object.object);
			}
			else
			{
				this._containerStarling.addChild(cast object.object);
			}
		}
		else if (object.isContainer)
		{
			if (object.isContainerOpenFL)
			{
				cast(object.object, IContainerOpenFL).rootContainer = this._container;
			}
			
			if (object.isContainerStarling)
			{
				cast(object.object, IContainerStarling).rootContainerStarling = this._containerStarling;
			}
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
			if (object.displayObjectType == DisplayObjectType.OPENFL)
			{
				this._container.removeChild(cast object.object);
			}
			else
			{
				this._containerStarling.removeChild(cast object.object);
			}
		}
		else if (object.isContainer)
		{
			if (object.isContainerOpenFL)
			{
				cast(object.object, IContainerOpenFL).rootContainer = null;
			}
			
			if (object.isContainerStarling)
			{
				cast(object.object, IContainerStarling).rootContainerStarling = null;
			}
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