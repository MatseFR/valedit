#if starling
package valedit;

import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import openfl.errors.Error;
import openfl.events.EventDispatcher;
import valedit.events.KeyFrameEvent;
import valedit.events.LayerEvent;

/**
 * ...
 * @author Matse
 */
class LayerOpenFLStarling extends EventDispatcher implements ITimeLineLayer implements ILayerOpenFL implements ILayerStarling
{
	static private var _POOL:Array<LayerOpenFLStarling> = new Array<LayerOpenFLStarling>();
	
	static public function fromPool():LayerOpenFLStarling
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new LayerOpenFLStarling();
	}
	
	public var allObjects(default, null):Array<ValEditObject> = new Array<ValEditObject>();
	public var name(get, set):String;
	public var rootContainer(get, set):DisplayObjectContainer;
	public var rootContainerStarling(get, set):starling.display.DisplayObjectContainer;
	public var timeLine(default, null):ValEditTimeLine;
	public var visible(get, set):Bool;
	
	private var _name:String;
	private function get_name():String { return this._name; }
	private function set_name(value:String):String
	{
		return this._name = value;
	}
	
	private var _rootContainer:DisplayObjectContainer;
	private function get_rootContainer():DisplayObjectContainer { return this._rootContainer; }
	private function set_rootContainer(value:DisplayObjectContainer):DisplayObjectContainer
	{
		if (this._rootContainer == value) return value;
		if (value != null)
		{
			value.addChildAt(this._displayContainer, 0);
		}
		else if (this._rootContainer != null)
		{
			this._rootContainer.removeChild(this._displayContainer);
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
			value.addChildAt(this._displayContainerStarling, 0);
		}
		else if (this._rootContainerStarling != null)
		{
			this._rootContainerStarling.removeChild(this._displayContainerStarling);
		}
		return this._rootContainerStarling = value;
	}
	
	private var _visible:Bool = true;
	private function get_visible():Bool { return this._visible; }
	private function set_visible(value:Bool):Bool
	{
		if (this._visible == value) return value;
		this._displayContainer.visible = this._displayContainerStarling.visible = value;
		return this._visible = value;
	}
	
	private var _displayContainer:Sprite = new Sprite();
	private var _displayContainerStarling:starling.display.Sprite = new starling.display.Sprite();

	public function new() 
	{
		super();
		
		this.timeLine = ValEditTimeLine.fromPool();
		this.timeLine.activateFunction = this.activate;
		this.timeLine.deactivateFunction = this.deactivate;
		this.timeLine.addEventListener(KeyFrameEvent.OBJECT_ADDED, onKeyFrameObjectAdded);
		this.timeLine.addEventListener(KeyFrameEvent.OBJECT_REMOVED, onKeyFrameObjectRemoved);
	}
	
	public function clear():Void
	{
		this.name = null;
		this.rootContainer = null;
		this.rootContainerStarling = null;
		this.allObjects.resize(0);
		this.visible = true;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	public function addObject(object:ValEditObject):Void
	{
		this.timeLine.addObject(object);
	}
	
	public function removeObject(object:ValEditObject):Void
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
				
				case DisplayObjectType.STARLING :
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
				
				default :
					throw new Error("ValEditContainer.add ::: unknown display object type " + object.displayObjectType);
			}
		}
		else if (object.isContainer)
		{
			if (object.isContainerOpenFL)
			{
				cast(object.object, IContainerOpenFL).rootContainer = this._displayContainer;
			}
			
			if (object.isContainerStarling)
			{
				cast(object.object, IContainerStarling).rootContainerStarling = this._displayContainerStarling;
			}
			
			if (object.isTimeLineContainer)
			{
				this.timeLine.addChild(cast(object.object, ITimeLineContainer).timeLine);
			}
		}
		
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
				
				default :
					throw new Error("ValEditContainer.remove ::: unknown display object type " + object.displayObjectType);
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
			
			if (object.isTimeLineContainer)
			{
				this.timeLine.removeChild(cast(object.object, ITimeLineContainer).timeLine);
			}
		}
		
		LayerEvent.dispatch(this, LayerEvent.OBJECT_DEACTIVATED, this, object);
	}
	
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
#end