package valedit;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import openfl.errors.Error;
import openfl.events.EventDispatcher;
import valeditor.events.KeyFrameEvent;
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
	
	public var allObjects(default, null):Array<ValEditObject> = new Array<ValEditObject>();
	public var container(get, set):IValEditTimeLineContainer;
	public var locked(get, set):Bool;
	public var name(get, set):String;
	public var rootContainer(get, set):DisplayObjectContainer;
	#if starling
	public var rootContainerStarling(get, set):starling.display.DisplayObjectContainer;
	#end
	public var timeLine(default, null):ValEditTimeLine;
	public var visible(get, set):Bool;
	public var x(get, set):Float;
	public var y(get, set):Float;
	
	private var _container:IValEditTimeLineContainer;
	private function get_container():IValEditTimeLineContainer { return this._container; }
	private function set_container(value:IValEditTimeLineContainer):IValEditTimeLineContainer
	{
		return this._container = value;
	}
	
	private var _locked:Bool = false;
	private function get_locked():Bool { return this._locked; }
	private function set_locked(value:Bool):Bool
	{
		if (this._locked == value) return value;
		if (this._displayContainer != null) this._displayContainer.mouseEnabled = !value;
		#if starling
		if (this._displayContainerStarling != null) this._displayContainerStarling.touchable = !value;
		#end
		return this._locked = value;
	}
	
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
			if (this._displayContainer != null)
			{
				value.addChildAt(this._displayContainer, 0);
			}
		}
		else if (this._rootContainer != null)
		{
			if (this._displayContainer != null)
			{
				this._rootContainer.removeChild(this._displayContainer);
			}
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
			if (this._displayContainerStarling != null)
			{
				value.addChildAt(this._displayContainerStarling, 0);
			}
		}
		else if (this._rootContainerStarling != null)
		{
			if (this._displayContainerStarling != null)
			{
				this._rootContainerStarling.removeChild(this._displayContainerStarling);
			}
		}
		return this._rootContainerStarling = value;
	}
	#end
	
	private var _visible:Bool = true;
	private function get_visible():Bool { return this._visible; }
	private function set_visible(value:Bool):Bool
	{
		if (this._visible == value) return value;
		if (this._displayContainer != null) this._displayContainer.visible = value;
		#if starling
		if (this._displayContainerStarling != null) this._displayContainerStarling.visible = value;
		#end
		return this._visible = value;
	}
	
	private var _x:Float = 0;
	private function get_x():Float { return this._x; }
	private function set_x(value:Float):Float
	{
		if (this._displayContainer != null) this._displayContainer.x = value;
		#if starling
		if (this._displayContainerStarling != null) this._displayContainerStarling.x = value;
		#end
		return this._x = value;
	}
	
	private var _y:Float = 0;
	private function get_y():Float { return this._y; }
	private function set_y(value:Float):Float
	{
		if (this._displayContainer != null) this._displayContainer.y = value;
		#if starling
		if (this._displayContainerStarling != null) this._displayContainerStarling.y = value;
		#end
		return this._y = value;
	}
	
	private var _clearContainers:Bool = true;
	private var _displayContainer:Sprite = new Sprite();
	#if starling
	private var _displayContainerStarling:starling.display.Sprite = new starling.display.Sprite();
	#end

	public function new(?timeLine:ValEditTimeLine) 
	{
		super();
		if (timeLine == null) timeLine = ValEditTimeLine.fromPool();
		this.timeLine = timeLine;
		this.timeLine.activateFunction = this.activate;
		this.timeLine.deactivateFunction = this.deactivate;
		this.timeLine.addEventListener(KeyFrameEvent.OBJECT_ADDED, onKeyFrameObjectAdded);
		this.timeLine.addEventListener(KeyFrameEvent.OBJECT_REMOVED, onKeyFrameObjectRemoved);
	}
	
	public function clear():Void
	{
		this.name = null;
		if (this._clearContainers && this._displayContainer != null)
		{
			clearDisplayContainer();
		}
		#if starling
		if (this._clearContainers && this._displayContainerStarling != null)
		{
			clearDisplayContainerStarling();
		}
		#end
		this.rootContainer = null;
		#if starling
		this.rootContainerStarling = null;
		#end
		if (this.timeLine != null)
		{
			this.timeLine.removeEventListener(KeyFrameEvent.OBJECT_ADDED, onKeyFrameObjectAdded);
			this.timeLine.removeEventListener(KeyFrameEvent.OBJECT_REMOVED, onKeyFrameObjectRemoved);
			this.timeLine.pool();
			this.timeLine = null;
		}
		this.allObjects.resize(0);
		this.container = null;
		this.locked = false;
		this.visible = true;
		this.x = 0;
		this.y = 0;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(timeLine:ValEditTimeLine):ValEditLayer
	{
		if (timeLine == null) timeLine = ValEditTimeLine.fromPool();
		this.timeLine = timeLine;
		this.timeLine.activateFunction = this.activate;
		this.timeLine.deactivateFunction = this.deactivate;
		this.timeLine.addEventListener(KeyFrameEvent.OBJECT_ADDED, onKeyFrameObjectAdded);
		this.timeLine.addEventListener(KeyFrameEvent.OBJECT_REMOVED, onKeyFrameObjectRemoved);
		return this;
	}
	
	public function add(object:ValEditObject):Void
	{
		this.timeLine.addObject(object);
	}
	
	public function remove(object:ValEditObject):Void
	{
		this.timeLine.removeObject(object);
	}
	
	public function activate(object:ValEditObject):Void
	{
		if (object.isDisplayObject)
		{
			switch (object.displayObjectType)
			{
				case DisplayObjectType.OPENFL :
					if (this._displayContainer == null)
					{
						createDisplayContainer();
					}
					if (object.clss.addToDisplayFunction != null)
					{
						#if neko
						Reflect.callMethod(null, object.clss.addToDisplayFunction, [object.object, this._displayContainer]);
						#else
						object.clss.addToDisplayFunction(object.object, this._displayContainer);
						#end
					}
					else
					{
						this._displayContainer.addChild(object.object);
					}
				
				#if starling
				case DisplayObjectType.STARLING :
					if (this._displayContainerStarling == null)
					{
						createDisplayContainerStarling();
					}
					if (object.clss.addToDisplayFunction != null)
					{
						#if neko
						Reflect.callMethod(null, object.clss.addToDisplayFunction, [object.object, this._displayContainerStarling]);
						#else
						object.clss.addToDisplayFunction(object.object, this._displayContainerStarling);
						#end
					}
					else
					{
						this._displayContainerStarling.addChild(object.object);
					}
				#end
				
				case DisplayObjectType.MIXED :
					if (this._displayContainer == null)
					{
						createDisplayContainer();
					}
					
					cast(object.object, IValEditContainer).rootContainer = this._displayContainer;
					
					#if starling
					if (this._displayContainerStarling == null)
					{
						createDisplayContainerStarling();
					}
					
					cast(object.object, IValEditContainer).rootContainerStarling = this._displayContainerStarling;
					#end
					
					if (Std.isOfType(object.object, IValEditTimeLineContainer))
					{
						this.timeLine.addChild(cast(object.object, IValEditTimeLineContainer).timeLine);
					}
				
				default :
					throw new Error("ValEditContainer.add ::: unknown display object type " + object.displayObjectType);
			}
		}
		
		//this._activeObjects.set(object.id, object);
		
		LayerEvent.dispatch(this, LayerEvent.OBJECT_ACTIVATED, this, object);
	}
	
	public function deactivate(object:ValEditObject):Void
	{
		if (object.isDisplayObject)
		{
			switch (object.displayObjectType)
			{
				case DisplayObjectType.OPENFL :
					if (object.clss.removeFromDisplayFunction != null)
					{
						#if neko
						Reflect.callMethod(null, object.clss.removeFromDisplayFunction, [object.object, this._displayContainer]);
						#else
						object.clss.removeFromDisplayFunction(object.object, this._displayContainer);
						#end
					}
					else
					{
						this._displayContainer.removeChild(object.object);
					}
				
				#if starling
				case DisplayObjectType.STARLING :
					if (object.clss.removeFromDisplayFunction != null)
					{
						#if neko
						Reflect.callMethod(null, object.clss.removeFromDisplayFunction, [object.object, this._displayContainerStarling]);
						#else
						object.clss.removeFromDisplayFunction(object.object, this._displayContainerStarling);
						#end
					}
					else
					{
						this._displayContainerStarling.removeChild(object.object);
					}
				#end
				
				case DisplayObjectType.MIXED :
					cast(object.object, IValEditContainer).rootContainer = null;
					#if starling
					cast(object.object, IValEditContainer).rootContainerStarling = null;
					#end
					
					if (Std.isOfType(object.object, IValEditTimeLineContainer))
					{
						this.timeLine.removeChild(cast(object.object, IValEditTimeLineContainer).timeLine);
					}
				
				default :
					throw new Error("ValEditContainer.remove ::: unknown display object type " + object.displayObjectType);
			}
		}
		
		//this._activeObjects.remove(object.id);
		
		LayerEvent.dispatch(this, LayerEvent.OBJECT_DEACTIVATED, this, object);
	}
	
	private function createDisplayContainer():Void
	{
		this._displayContainer = new Sprite();
		this._displayContainer.x = this._x;
		this._displayContainer.y = this._y;
		this._displayContainer.mouseEnabled = !this._locked;
		this._displayContainer.visible = this._visible;
		
		addDisplayContainer();
	}
	
	private function addDisplayContainer():Void
	{
		if (this._rootContainer != null)
		{
			this._rootContainer.addChildAt(this._displayContainer, 0);
		}
	}
	
	private function clearDisplayContainer():Void
	{
		if (this._rootContainer != null)
		{
			this._rootContainer.removeChild(this._displayContainer);
		}
		this._displayContainer = null;
	}
	
	#if starling
	private function createDisplayContainerStarling():Void
	{
		this._displayContainerStarling = new starling.display.Sprite();
		this._displayContainerStarling.x = this._x;
		this._displayContainerStarling.y = this._y;
		this._displayContainerStarling.touchable = !this._locked;
		this._displayContainerStarling.visible = this._visible;
		
		addDisplayContainerStarling();
	}
	
	private function addDisplayContainerStarling():Void
	{
		if (this._rootContainerStarling != null)
		{
			this._rootContainerStarling.addChildAt(this._displayContainerStarling, 0);
		}
	}
	
	private function clearDisplayContainerStarling():Void
	{
		if (this._rootContainerStarling != null)
		{
			this._rootContainerStarling.removeChild(this._displayContainerStarling);
		}
		this._displayContainerStarling.dispose();
		this._displayContainerStarling = null;
	}
	#end
	
	private function onKeyFrameObjectAdded(evt:KeyFrameEvent):Void
	{
		if (evt.object.numKeyFrames == 1)
		{
			this.allObjects[this.allObjects.length] = evt.object;
		}
		dispatchEvent(evt);
	}
	
	private function onKeyFrameObjectRemoved(evt:KeyFrameEvent):Void
	{
		if (evt.object.numKeyFrames == 0)
		{
			this.allObjects.remove(evt.object);
		}
		dispatchEvent(evt);
	}
	
}