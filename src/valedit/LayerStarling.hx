#if starling
package valedit;
import openfl.events.EventDispatcher;
import valedit.events.LayerEvent;
import valedit.events.KeyFrameEvent;

import starling.display.DisplayObjectContainer;
import starling.display.Sprite;

/**
 * ...
 * @author Matse
 */
class LayerStarling extends EventDispatcher implements ITimeLineLayer implements ILayerStarling
{
	static private var _POOL:Array<LayerStarling> = new Array<LayerStarling>();
	
	static public function fromPool():LayerStarling
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new LayerStarling();
	}
	
	public var allObjects(default, null):Array<ValEditObject> = new Array<ValEditObject>();
	public var name(get, set):String;
	public var rootContainerStarling(get, set):DisplayObjectContainer;
	public var timeLine(default, null):ValEditTimeLine;
	public var visible(get, set):Bool;
	
	private function get_name():String { return this._displayContainer.name; }
	private function set_name(value:String):String
	{
		return this._displayContainer.name = value;
	}
	
	private var _rootContainerStarling:DisplayObjectContainer;
	private function get_rootContainerStarling():DisplayObjectContainer { return this._rootContainerStarling; }
	private function set_rootContainerStarling(value:DisplayObjectContainer):DisplayObjectContainer
	{
		if (this._rootContainerStarling == value) return value;
		if (value != null)
		{
			value.addChildAt(this._displayContainer, 0);
		}
		else if (this._rootContainerStarling != null)
		{
			this._rootContainerStarling.removeChild(this._displayContainer);
		}
		return this._rootContainerStarling = value;
	}
	
	private function get_visible():Bool { return this._displayContainer.visible; }
	private function set_visible(value:Bool):Bool
	{
		return this._displayContainer.visible = value;
	}
	
	private var _displayContainer:Sprite = new Sprite();
	
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
		}
		else if (object.isContainer)
		{
			cast(object.object, IContainerStarling).rootContainerStarling = this._displayContainer;
			
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
		}
		else if (object.isContainer)
		{
			cast(object.object, IContainerStarling).rootContainerStarling = null;
			
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