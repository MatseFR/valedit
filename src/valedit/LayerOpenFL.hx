package valedit;

import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import valedit.events.KeyFrameEvent;
import valedit.events.LayerEvent;

/**
 * ...
 * @author Matse
 */
class LayerOpenFL extends Sprite implements ITimeLineLayer implements ILayerOpenFL
{
	static private var _POOL:Array<LayerOpenFL> = new Array<LayerOpenFL>();
	
	static public function fromPool():LayerOpenFL
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new LayerOpenFL();
	}
	
	public var allObjects(default, null):Array<ValEditObject> = new Array<ValEditObject>();
	public var rootContainer(get, set):DisplayObjectContainer;
	public var timeLine(default, null):ValEditTimeLine;
	
	private var _rootContainer:DisplayObjectContainer;
	private function get_rootContainer():DisplayObjectContainer { return this._rootContainer; }
	private function set_rootContainer(value:DisplayObjectContainer):DisplayObjectContainer
	{
		if (this._rootContainer == value) return value;
		if (value != null)
		{
			value.addChildAt(this, 0);
		}
		else if (this._rootContainer != null)
		{
			this._rootContainer.removeChild(this);
		}
		return this._rootContainer = value;
	}
	
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
				Reflect.callMethod(null, object.clss.addToDisplayFunction, [object.object, this]);
				#else
				object.clss.addToDisplayFunction(object.object, this);
				#end
			}
			else
			{
				addChild(object.object);
			}
		}
		else if (object.isContainer)
		{
			cast(object.object, IContainerOpenFL).rootContainer = this;
			
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
				Reflect.callMethod(null, object.clss.removeFromDisplayFunction, [object.object, this]);
				#else
				object.clss.removeFromDisplayFunction(object.object, this);
				#end
			}
			else
			{
				removeChild(object.object);
			}
		}
		else if (object.isContainer)
		{
			cast(object.object, IContainerOpenFL).rootContainer = null;
			
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