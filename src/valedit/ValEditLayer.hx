package valedit;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import openfl.errors.Error;
import openfl.events.EventDispatcher;
import valedit.utils.StringIndexedMap;
import valeditor.events.LayerEvent;

/**
 * ...
 * @author Matse
 */
class ValEditLayer extends EventDispatcher
{
	static private var _POOL:Array<ValEditLayer> = new Array<ValEditLayer>();
	
	static public function fromPool(?timeLine:ValEditTimeLine):ValEditLayer
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(timeLine);
		return new ValEditLayer(timeLine);
	}
	
	public var name(get, set):String;
	public var rootContainer(get, set):DisplayObjectContainer;
	#if starling
	public var rootContainerStarling(get, set):starling.display.DisplayObjectContainer;
	#end
	public var timeLine(default, null):ValEditTimeLine;
	public var valEditContainer(get, set):IValEditContainer;
	public var visible(get, set):Bool;
	public var x(get, set):Float;
	public var y(get, set):Float;
	
	private var _name:String;
	private function get_name():String { return this._name; }
	private function set_name(value:String):String
	{
		this._name = value;
		return value;
	}
	
	private var _rootContainer:DisplayObjectContainer;
	private function get_rootContainer():DisplayObjectContainer { return this._rootContainer; }
	private function set_rootContainer(value:DisplayObjectContainer):DisplayObjectContainer
	{
		if (this._rootContainer == value) return value;
		if (value != null)
		{
			if (this._container != null) value.addChild(this._container);
		}
		else if (this._rootContainer != null)
		{
			if (this._container != null) this._rootContainer.removeChild(this._container);
		}
		return this._rootContainer = value;
	}
	
	#if starling
	private var _rootContainerStarling:starling.display.DisplayObjectContainer;
	private function get_rootContainerStarling():starling.display.DisplayObjectContainer { return this._rootContainerStarling; }
	private function set_rootContainerStarling(value:starling.display.DisplayObjectContainer):starling.display.DisplayObjectContainer
	{
		if (this._rootContainerStarling == value) return value;
		if (value != null)
		{
			if (this._containerStarling != null) value.addChild(this._containerStarling);
		}
		else if (this._rootContainerStarling != null)
		{
			if (this._containerStarling != null) this._rootContainerStarling.removeChild(this._containerStarling);
		}
		return this._rootContainerStarling = value;
	}
	#end
	
	private var _valEditContainer:IValEditContainer;
	private function get_valEditContainer():IValEditContainer { return this._valEditContainer; }
	private function set_valEditContainer(value:IValEditContainer):IValEditContainer
	{
		return this._valEditContainer = value;
	}
	
	private var _visible:Bool = true;
	private function get_visible():Bool { return this._visible; }
	private function set_visible(value:Bool):Bool
	{
		if (this._visible == value) return value;
		if (this._container != null) this._container.visible = value;
		#if starling
		if (this._containerStarling != null) this._containerStarling.visible = value;
		#end
		return this._visible = value;
	}
	
	private var _x:Float = 0;
	private function get_x():Float { return this._x; }
	private function set_x(value:Float):Float
	{
		if (this._container != null) this._container.x = value;
		#if starling
		if (this._containerStarling != null) this._containerStarling.x = value;
		#end
		return this._x = value;
	}
	
	private var _y:Float = 0;
	private function get_y():Float { return this._y; }
	private function set_y(value:Float):Float
	{
		if (this._container != null) this._container.y = value;
		#if starling
		if (this._containerStarling != null) this._containerStarling.y = value;
		#end
		return this._y = value;
	}
	
	private var _objects:StringIndexedMap<ValEditObject> = new StringIndexedMap<ValEditObject>();
	
	private var _container:Sprite = new Sprite();
	#if starling
	private var _containerStarling:starling.display.Sprite = new starling.display.Sprite();
	#end

	public function new(?timeLine:ValEditTimeLine) 
	{
		super();
		if (timeLine == null) timeLine = ValEditTimeLine.fromPool();
		this.timeLine = timeLine;
		this.timeLine.activateFunction = this.activate;
		this.timeLine.deactivateFunction = this.deactivate;
	}
	
	public function clear():Void
	{
		this.name = null;
		this.rootContainer = null;
		#if starling
		this.rootContainerStarling = null;
		#end
		if (this.timeLine != null)
		{
			this.timeLine.pool();
			this.timeLine = null;
		}
		this.valEditContainer = null;
		this.visible = true;
		this.x = 0;
		this.y = 0;
		this._objects.clear();
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(timeLine:ValEditTimeLine):ValEditLayer
	{
		this.timeLine = timeLine;
		this.timeLine.activateFunction = this.activate;
		this.timeLine.deactivateFunction = this.deactivate;
		return this;
	}
	
	public function add(object:ValEditObject):Void
	{
		this.timeLine.add(object);
	}
	
	public function remove(object:ValEditObject):Void
	{
		this.timeLine.remove(object);
	}
	
	public function activate(object:ValEditObject):Void
	{
		if (object.isDisplayObject)
		{
			switch (object.displayObjectType)
			{
				case DisplayObjectType.OPENFL :
					if (this._container == null)
					{
						createContainer();
					}
					if (object.clss.addToDisplayCustom != null)
					{
						#if neko
						Reflect.callMethod(null, object.clss.addToDisplayCustom, [object.object, this._container]);
						#else
						object.clss.addToDisplayCustom(object.object, this._container);
						#end
					}
					else
					{
						this._container.addChild(object.object);
					}
				
				#if starling
				case DisplayObjectType.STARLING :
					if (this._containerStarling == null)
					{
						createContainerStarling();
					}
					if (object.clss.addToDisplayCustom != null)
					{
						#if neko
						Reflect.callMethod(null, object.clss.addToDisplayCustom, [object.object, this._containerStarling]);
						#else
						object.clss.addToDisplayCustom(object.object, this._containerStarling);
						#end
					}
					else
					{
						this._containerStarling.addChild(object.object);
					}
				#end
				
				default :
					throw new Error("ValEditContainer.add ::: unknown display object type " + object.displayObjectType);
			}
		}
		
		this._objects.set(object.id, object);
		
		LayerEvent.dispatch(this, LayerEvent.OBJECT_ADDED, this, object);
	}
	
	public function deactivate(object:ValEditObject):Void
	{
		if (object.isDisplayObject)
		{
			switch (object.displayObjectType)
			{
				case DisplayObjectType.OPENFL :
					if (object.clss.removeFromDisplayCustom != null)
					{
						#if neko
						Reflect.callMethod(null, object.clss.removeFromDisplayCustom, [object.object, this._container]);
						#else
						object.clss.removeFromDisplayCustom(object.object, this._container);
						#end
					}
					else
					{
						this._container.removeChild(object.object);
					}
				
				#if starling
				case DisplayObjectType.STARLING :
					if (object.clss.removeFromDisplayCustom != null)
					{
						#if neko
						Reflect.callMethod(null, object.clss.removeFromDisplayCustom, [object.object, this._containerStarling]);
						#else
						object.clss.removeFromDisplayCustom(object.object, this._containerStarling);
						#end
					}
					else
					{
						this._containerStarling.removeChild(object.object);
					}
				#end
				
				default :
					throw new Error("ValEditContainer.remove ::: unknown display object type " + object.displayObjectType);
			}
		}
		
		this._objects.remove(object.id);
		
		LayerEvent.dispatch(this, LayerEvent.OBJECT_REMOVED, this, object);
	}
	
	private function createContainer():Void
	{
		this._container = new Sprite();
		this._container.x = this._x;
		this._container.y = this._y;
		this._container.visible = this._visible;
		if (this._rootContainer != null) this._rootContainer.addChild(this._container);
	}
	
	#if starling
	private function createContainerStarling():Void
	{
		this._containerStarling = new starling.display.Sprite();
		this._containerStarling.x = this._x;
		this._containerStarling.y = this._y;
		this._containerStarling.visible = this._visible;
		if (this._rootContainerStarling != null) this._rootContainerStarling.addChild(this._containerStarling);
	}
	#end
	
}