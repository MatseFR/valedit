package valedit;

import haxe.ds.ObjectMap;
import juggler.animation.Juggler;
import openfl.display.BlendMode;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import valedit.events.KeyFrameEvent;
import valedit.events.LayerEvent;
import valedit.events.PlayEvent;

/**
 * ...
 * @author Matse
 */
class TimeLineContainerOpenFL extends Sprite implements IContainer implements ITimeLineContainer implements IContainerOpenFL
{
	static private var _POOL:Array<TimeLineContainerOpenFL> = new Array<TimeLineContainerOpenFL>();
	
	static public function fromPool():TimeLineContainerOpenFL
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new TimeLineContainerOpenFL();
	}
	
	public var autoPlay:Bool = true;
	public var container(get, never):DisplayObjectContainer;
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
	public var rootContainer(get, set):DisplayObjectContainer;
	public var timeLine(default, null):ValEditTimeLine;
	
	private function get_container():DisplayObjectContainer { return this; }
	
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
	
	private var _rootContainer:DisplayObjectContainer;
	private function get_rootContainer():DisplayObjectContainer { return this._rootContainer; }
	private function set_rootContainer(value:DisplayObjectContainer):DisplayObjectContainer
	{
		if (this._rootContainer == value) return value;
		
		if (value != null)
		{
			value.addChild(this);
		}
		else if (this._rootContainer != null)
		{
			this._rootContainer.removeChild(this);
		}
		
		return this._rootContainer = value;
	}
	
	private var _layers:Array<LayerOpenFL> = new Array<LayerOpenFL>();
	private var _layerMap:Map<String, LayerOpenFL> = new Map<String, LayerOpenFL>();
	
	private var _allObjects:Map<String, ValEditObject> = new Map<String, ValEditObject>();
	private var _activeObjects:Map<String, ValEditObject> = new Map<String, ValEditObject>();
	private var _objectToLayer:ObjectMap<ValEditObject, LayerOpenFL> = new ObjectMap<ValEditObject, LayerOpenFL>();
	
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
		
		this.rootContainer = null;
		
		this.alpha = 1.0;
		this.autoPlay = true;
		this.blendMode = BlendMode.NORMAL;
		this.rotation = 0;
		this.scaleX = 1.0;
		this.scaleY = 1.0;
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
		return LayerOpenFL.fromPool();
	}
	
	public function addLayer(layer:LayerOpenFL):Void
	{
		this._layers[this._layers.length] = layer;
		this._layerMap.set(layer.name, layer);
		layerRegister(layer, this._layers.length - 1);
	}
	
	public function addLayerAt(layer:LayerOpenFL, index:Int):Void
	{
		this._layers.insert(index, layer);
		this._layerMap.set(layer.name, layer);
		layerRegister(layer, index);
	}
	
	public function getLayer(name:String):LayerOpenFL
	{
		return this._layerMap.get(name);
	}
	
	public function getLayerAt(index:Int):LayerOpenFL
	{
		return this._layers[index];
	}
	
	public function removeLayer(layer:LayerOpenFL):Void
	{
		var index:Int = this._layers.indexOf(layer);
		this._layers.splice(index, 1);
		this._layerMap.remove(layer.name);
		layerUnregister(layer);
	}
	
	public function removeLayerAt(index:Int):Void
	{
		var layer:LayerOpenFL = this._layers.splice(index, 1)[0];
		this._layerMap.remove(layer.name);
		layerUnregister(layer);
	}
	
	public function removeLayerWithName(name:String):Void
	{
		var layer:LayerOpenFL = this._layerMap.get(name);
		removeLayer(layer);
	}
	
	private function layerRegister(layer:LayerOpenFL, index:Int):Void
	{
		this.timeLine.addSlaveAt(layer.timeLine, index);
		
		layer.rootContainer = this;
		
		for (object in layer.allObjects)
		{
			objectRegister(object);
		}
		
		layer.addEventListener(KeyFrameEvent.OBJECT_ADDED, layer_objectAdded);
		layer.addEventListener(KeyFrameEvent.OBJECT_REMOVED, layer_objectRemoved);
		layer.addEventListener(LayerEvent.OBJECT_ACTIVATED, layer_objectActivated);
		layer.addEventListener(LayerEvent.OBJECT_DEACTIVATED, layer_objectDeactivated);
	}
	
	private function layerUnregister(layer:LayerOpenFL):Void
	{
		this.timeLine.removeSlave(layer.timeLine);
		
		layer.rootContainer = null;
		
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
		var layer:LayerOpenFL = this._objectToLayer.get(object);
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