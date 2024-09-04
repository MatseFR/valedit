package valedit;

import haxe.ds.ObjectMap;
import juggler.animation.Juggler;
import openfl.events.EventDispatcher;
import starling.display.BlendMode;
import starling.display.DisplayObjectContainer;
import starling.display.Sprite;
import valedit.events.KeyFrameEvent;
import valedit.events.LayerEvent;
import valedit.events.PlayEvent;

/**
 * ...
 * @author Matse
 */
class TimeLineContainerStarling extends EventDispatcher implements IContainer implements ITimeLineContainer implements IContainerStarling
{
	static private var _POOL:Array<TimeLineContainerStarling> = new Array<TimeLineContainerStarling>();
	
	static public function fromPool():TimeLineContainerStarling
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new TimeLineContainerStarling();
	}
	
	public var alpha(get, set):Float;
	public var autoPlay:Bool = true;
	public var blendMode(get, set):String;
	public var containerStarling(get, never):DisplayObjectContainer;
	public var currentLayer(get, set):ITimeLineLayer;
	public var frameIndex(get, set):Int;
	public var frameRate(get, set):Float;
	public var isPlaying(get, never):Bool;
	public var isReverse(get, never):Bool;
	public var juggler(get, set):Juggler;
	public var lastFrameIndex(get, never):Int;
	public var loop(get, set):Bool;
	public var numFrames(get, set):Int;
	public var numLayers(get, never):Int;
	public var numLoops(get, set):Int;
	/** reverse animation on every odd loop */
	public var reverse(get, set):Bool;
	public var rootContainerStarling(get, set):DisplayObjectContainer;
	public var rotation(get, set):Float;
	public var scaleX(get, set):Float;
	public var scaleY(get, set):Float;
	public var skewX(get, set):Float;
	public var skewY(get, set):Float;
	public var timeLine(default, null):ValEditTimeLine;
	public var visible(get, set):Bool;
	public var x(get, set):Float;
	public var y(get, set):Float;
	
	private function get_alpha():Float { return this._displayContainer.alpha; }
	private function set_alpha(value:Float):Float
	{
		return this._displayContainer.alpha = value;
	}
	
	private function get_blendMode():String { return this._displayContainer.blendMode; }
	private function set_blendMode(value:String):String
	{
		return this._displayContainer.blendMode = value;
	}
	
	private function get_containerStarling():DisplayObjectContainer { return this._displayContainer; }
	
	private var _currentLayer:ITimeLineLayer;
	private function get_currentLayer():ITimeLineLayer { return this._currentLayer; }
	private function set_currentLayer(value:ITimeLineLayer):ITimeLineLayer
	{
		return this._currentLayer = value;
	}
	
	private function get_frameIndex():Int { return this.timeLine.frameIndex; }
	private function set_frameIndex(value:Int):Int
	{
		return this.timeLine.frameIndex = value;
	}
	
	private function get_frameRate():Float { return this.timeLine.frameRate; }
	private function set_frameRate(value:Float):Float
	{
		return this.timeLine.frameRate = value;
	}
	
	private function get_isPlaying():Bool { return this.timeLine.isPlaying; }
	
	private function get_isReverse():Bool { return this.timeLine.isReverse; }
	
	private function get_juggler():Juggler { return this.timeLine.juggler; }
	private function set_juggler(value:Juggler):Juggler
	{
		return this.timeLine.juggler = value;
	}
	
	private function get_lastFrameIndex():Int { return this.timeLine.lastFrameIndex; }
	
	private function get_loop():Bool { return this.timeLine.loop; }
	private function set_loop(value:Bool):Bool
	{
		return this.timeLine.loop = value;
	}
	
	private function get_numFrames():Int { return this.timeLine.numFrames; }
	private function set_numFrames(value:Int):Int
	{
		return this.timeLine.numFrames = value;
	}
	
	private function get_numLayers():Int { return this._layers.length; }
	
	private function get_numLoops():Int { return this.timeLine.numLoops; }
	private function set_numLoops(value:Int):Int
	{
		return this.timeLine.numLoops = value;
	}
	
	private function get_reverse():Bool { return this.timeLine.reverse; }
	private function set_reverse(value:Bool):Bool
	{
		return this.timeLine.reverse = value;
	}
	
	private var _rootContainerStarling:DisplayObjectContainer;
	private function get_rootContainerStarling():DisplayObjectContainer { return this._rootContainerStarling; }
	private function set_rootContainerStarling(value:DisplayObjectContainer):DisplayObjectContainer
	{
		if (this._rootContainerStarling == value) return value;
		
		if (value != null)
		{
			value.addChild(this._displayContainer);
		}
		else if (this._rootContainerStarling != null)
		{
			this._rootContainerStarling.removeChild(this._displayContainer);
		}
		
		return this._rootContainerStarling = value;
	}
	
	private function get_rotation():Float { return this._displayContainer.rotation; }
	private function set_rotation(value:Float):Float
	{
		return this._displayContainer.rotation = value;
	}
	
	private function get_scaleX():Float { return this._displayContainer.scaleX; }
	private function set_scaleX(value:Float):Float
	{
		return this._displayContainer.scaleX = value;
	}
	
	private function get_scaleY():Float { return this._displayContainer.scaleY; }
	private function set_scaleY(value:Float):Float
	{
		return this._displayContainer.scaleY = value;
	}
	
	private function get_skewX():Float { return this._displayContainer.skewX; }
	private function set_skewX(value:Float):Float
	{
		return this._displayContainer.skewX = value;
	}
	
	private function get_skewY():Float { return this._displayContainer.skewY; }
	private function set_skewY(value:Float):Float
	{
		return this._displayContainer.skewY = value;
	}
	
	private function get_visible():Bool { return this._displayContainer.visible; }
	private function set_visible(value:Bool):Bool
	{
		return this._displayContainer.visible = value;
	}
	
	private function get_x():Float { return this._displayContainer.x; }
	private function set_x(value:Float):Float
	{
		return this._displayContainer.x = value;
	}
	
	private function get_y():Float { return this._displayContainer.y; }
	private function set_y(value:Float):Float
	{
		return this._displayContainer.y = value;
	}
	
	private var _displayContainer:Sprite = new Sprite();
	
	private var _layers:Array<LayerStarling> = new Array<LayerStarling>();
	private var _layerMap:Map<String, LayerStarling> = new Map<String, LayerStarling>();
	
	private var _allObjects:Map<String, ValEditObject> = new Map<String, ValEditObject>();
	private var _activeObjects:Map<String, ValEditObject> = new Map<String, ValEditObject>();
	private var _objectToLayer:ObjectMap<ValEditObject, LayerStarling> = new ObjectMap<ValEditObject, LayerStarling>();
	
	public function new() 
	{
		super();
		
		this.timeLine = new ValEditTimeLine();
		this.timeLine.addEventListener(PlayEvent.PLAY, onPlay);
		this.timeLine.addEventListener(PlayEvent.STOP, onStop);
	}
	
	public function clear():Void
	{
		this.timeLine.clear();
		
		for (layer in this._layers)
		{
			layer.pool();
		}
		this._layers.resize(0);
		this._layerMap.clear();
		this._currentLayer = null;
		
		this.rootContainerStarling = null;
		
		this.alpha = 1.0;
		this.autoPlay = true;
		this.blendMode = BlendMode.AUTO;
		this.rotation = 0;
		this.scaleX = 1.0;
		this.scaleY = 1.0;
		this.skewX = 0;
		this.skewY = 0;
		this.visible = true;
		this.x = 0;
		this.y = 0;
		
		this._allObjects.clear();
		this._activeObjects.clear();
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	public function play():Void
	{
		this.timeLine.play();
	}
	
	public function stop():Void
	{
		this.timeLine.stop();
	}
	
	public function createLayer():ITimeLineLayer
	{
		return LayerStarling.fromPool();
	}
	
	public function addLayer(layer:LayerStarling):Void
	{
		this._layers[this._layers.length] = layer;
		this._layerMap.set(layer.name, layer);
		layerRegister(layer, this._layers.length - 1);
	}
	
	public function addLayerAt(layer:LayerStarling, index:Int):Void
	{
		this._layers.insert(index, layer);
		this._layerMap.set(layer.name, layer);
		layerRegister(layer, index);
	}
	
	public function getLayer(name:String):LayerStarling
	{
		return this._layerMap.get(name);
	}
	
	public function getLayerAt(index:Int):LayerStarling
	{
		return this._layers[index];
	}
	
	public function removeLayer(layer:LayerStarling):Void
	{
		var index:Int = this._layers.indexOf(layer);
		this._layers.splice(index, 1);
		this._layerMap.remove(layer.name);
		layerUnregister(layer);
	}
	
	public function removeLayerAt(index:Int):Void
	{
		var layer:LayerStarling = this._layers.splice(index, 1)[0];
		this._layerMap.remove(layer.name);
		layerUnregister(layer);
	}
	
	public function removeLayerWithName(name:String):Void
	{
		var layer:LayerStarling = this._layerMap.get(name);
		removeLayer(layer);
	}
	
	private function layerRegister(layer:LayerStarling, index:Int):Void
	{
		this.timeLine.addSlaveAt(layer.timeLine, index);
		
		layer.rootContainerStarling = this._displayContainer;
		
		for (object in layer.allObjects)
		{
			objectRegister(object);
		}
		
		layer.addEventListener(KeyFrameEvent.OBJECT_ADDED, layer_objectAdded);
		layer.addEventListener(KeyFrameEvent.OBJECT_REMOVED, layer_objectRemoved);
		layer.addEventListener(LayerEvent.OBJECT_ACTIVATED, layer_objectActivated);
		layer.addEventListener(LayerEvent.OBJECT_DEACTIVATED, layer_objectDeactivated);
	}
	
	private function layerUnregister(layer:LayerStarling):Void
	{
		this.timeLine.removeSlave(layer.timeLine);
		
		layer.rootContainerStarling = null;
		
		for (object in layer.allObjects)
		{
			objectUnregister(object);
		}
		
		layer.removeEventListener(KeyFrameEvent.OBJECT_ADDED, layer_objectAdded);
		layer.removeEventListener(KeyFrameEvent.OBJECT_REMOVED, layer_objectRemoved);
		layer.removeEventListener(LayerEvent.OBJECT_ACTIVATED, layer_objectActivated);
		layer.removeEventListener(LayerEvent.OBJECT_DEACTIVATED, layer_objectDeactivated);
	}
	
	private function objectRegister(object:ValEditObject):Void
	{
		this._allObjects.set(object.objectID, object);
		
		object.container = this;
	}
	
	private function objectUnregister(object:ValEditObject):Void
	{
		this._allObjects.remove(object.objectID);
		
		object.container = null;
	}
	
	private function layer_objectAdded(evt:KeyFrameEvent):Void
	{
		objectRegister(evt.object);
	}
	
	private function layer_objectRemoved(evt:KeyFrameEvent):Void
	{
		objectUnregister(evt.object);
	}
	
	private function layer_objectActivated(evt:LayerEvent):Void 
	{
		this._activeObjects.set(evt.object.objectID, evt.object);
	}
	
	private function layer_objectDeactivated(evt:LayerEvent):Void 
	{
		this._activeObjects.remove(evt.object.objectID);
	}
	
	public function addObject(object:ValEditObject):Void
	{
		this._currentLayer.addObject(object);
	}
	
	public function getActiveObject(objectID:String):ValEditObject
	{
		return this._activeObjects.get(objectID);
	}
	
	public function getObject(objectID:String):ValEditObject
	{
		return this._allObjects.get(objectID);
	}
	
	public function removeObject(object:ValEditObject):Void
	{
		var layer:LayerStarling = this._objectToLayer.get(object);
		layer.removeObject(object);
	}
	
	public function removeObjectCompletely(object:ValEditObject):Void
	{
		object.removeAllKeyFrames();
	}
	
	private function onPlay(evt:PlayEvent):Void
	{
		PlayEvent.dispatch(this, PlayEvent.PLAY);
	}
	
	private function onStop(evt:PlayEvent):Void
	{
		PlayEvent.dispatch(this, PlayEvent.STOP);
	}
	
	public function fromJSONExport(json:Dynamic):Void
	{
		
	}
	
}