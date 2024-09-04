#if starling
package valedit;

import haxe.ds.ObjectMap;
import juggler.animation.Juggler;
import openfl.display.BlendMode;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import openfl.events.EventDispatcher;
import valedit.events.KeyFrameEvent;
import valedit.events.LayerEvent;
import valedit.events.PlayEvent;
import valeditor.utils.MathUtil;

/**
 * ...
 * @author Matse
 */
class TimeLineContainerOpenFLStarling extends EventDispatcher implements IContainer implements ITimeLineContainer implements IContainerOpenFL implements IContainerStarling
{
	static private var _POOL:Array<TimeLineContainerOpenFLStarling> = new Array<TimeLineContainerOpenFLStarling>();
	
	static public function fromPool():TimeLineContainerOpenFLStarling
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new TimeLineContainerOpenFLStarling();
	}
	
	public var alpha(get, set):Float;
	public var autoPlay:Bool = true;
	public var blendMode(get, set):BlendMode;
	public var blendModeStarling(get, set):String;
	public var container(get, never):DisplayObjectContainer;
	public var containerStarling(get, never):starling.display.DisplayObjectContainer;
	public var currentLayer(get, set):ITimeLineLayer;
	public var frameIndex(get, set):Int;
	public var frameRate(get, set):Float;
	public var height(get, set):Float;
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
	public var rootContainerStarling(get, set):starling.display.DisplayObjectContainer;
	public var rotation(get, set):Float;
	public var scaleX(get, set):Float;
	public var scaleY(get, set):Float;
	public var timeLine(default, null):ValEditTimeLine;
	public var visible(get, set):Bool;
	public var width(get, set):Float;
	public var x(get, set):Float;
	public var y(get, set):Float;
	
	private var _alpha:Float = 1.0;
	private function get_alpha():Float { return this._alpha; }
	private function set_alpha(value:Float):Float
	{
		this._container.alpha = this._containerStarling.alpha = value;
		return this._alpha = value;
	}
	
	private var _blendMode:BlendMode = BlendMode.NORMAL;
	private function get_blendMode():BlendMode { return this._blendMode; }
	private function set_blendMode(value:BlendMode):BlendMode
	{
		this._container.blendMode = value;
		return this._blendMode = value;
	}
	
	private var _blendModeStarling:String = starling.display.BlendMode.AUTO;
	private function get_blendModeStarling():String { return this._blendModeStarling; }
	private function set_blendModeStarling(value:String):String
	{
		this._containerStarling.blendMode = value;
		return this._blendModeStarling = value;
	}
	
	private var _container:Sprite = new Sprite();
	private function get_container():DisplayObjectContainer { return this._container; }
	
	private var _containerStarling:starling.display.Sprite = new starling.display.Sprite();
	private function get_containerStarling():starling.display.DisplayObjectContainer { return this._containerStarling; }
	
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
	
	private function get_height():Float { return Math.max(this._container.height, this._containerStarling.height); }
	private function set_height(value:Float):Float
	{
		var h:Float = this.height / this.scaleY;
		if (h == 0.0) return h;
		this.scaleY = value / h;
		return value;
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
	
	private var _layers:Array<LayerOpenFLStarling> = new Array<LayerOpenFLStarling>();
	private var _layerMap:Map<String, LayerOpenFLStarling> = new Map<String, LayerOpenFLStarling>();
	
	private var _allObjects:Map<String, ValEditObject> = new Map<String, ValEditObject>();
	private var _activeObjects:Map<String, ValEditObject> = new Map<String, ValEditObject>();
	private var _objectToLayer:ObjectMap<ValEditObject, LayerOpenFLStarling> = new ObjectMap<ValEditObject, LayerOpenFLStarling>();
	
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
		this.rootContainerStarling = null;
		
		this.alpha = 1.0;
		this.autoPlay = true;
		this.blendMode = BlendMode.NORMAL;
		this.blendModeStarling = starling.display.BlendMode.AUTO;
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
		return LayerOpenFLStarling.fromPool();
	}
	
	public function addLayer(layer:LayerOpenFLStarling):Void
	{
		this._layers[this._layers.length] = layer;
		this._layerMap.set(layer.name, layer);
		layerRegister(layer, this._layers.length - 1);
	}
	
	public function addLayerAt(layer:LayerOpenFLStarling, index:Int):Void
	{
		this._layers.insert(index, layer);
		this._layerMap.set(layer.name, layer);
		layerRegister(layer, index);
	}
	
	public function getLayer(name:String):LayerOpenFLStarling
	{
		return this._layerMap.get(name);
	}
	
	public function getLayerAt(index:Int):LayerOpenFLStarling
	{
		return this._layers[index];
	}
	
	public function removeLayer(layer:LayerOpenFLStarling):Void
	{
		var index:Int = this._layers.indexOf(layer);
		this._layers.splice(index, 1);
		this._layerMap.remove(layer.name);
		layerUnregister(layer);
	}
	
	public function removeLayerAt(index:Int):Void
	{
		var layer:LayerOpenFLStarling = this._layers.splice(index, 1)[0];
		this._layerMap.remove(layer.name);
		layerUnregister(layer);
	}
	
	public function removeLayerWithName(name:String):Void
	{
		var layer:LayerOpenFLStarling = this._layerMap.get(name);
		removeLayer(layer);
	}
	
	private function layerRegister(layer:LayerOpenFLStarling, index:Int):Void
	{
		this.timeLine.addSlaveAt(layer.timeLine, index);
		
		layer.rootContainer = this._container;
		layer.rootContainerStarling = this._containerStarling;
		
		for (object in layer.allObjects)
		{
			objectRegister(object);
		}
		
		layer.addEventListener(KeyFrameEvent.OBJECT_ADDED, layer_objectAdded);
		layer.addEventListener(KeyFrameEvent.OBJECT_REMOVED, layer_objectRemoved);
		layer.addEventListener(LayerEvent.OBJECT_ACTIVATED, layer_objectActivated);
		layer.addEventListener(LayerEvent.OBJECT_DEACTIVATED, layer_objectDeactivated);
	}
	
	private function layerUnregister(layer:LayerOpenFLStarling):Void
	{
		this.timeLine.removeSlave(layer.timeLine);
		
		layer.rootContainer = null;
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
		var layer:LayerOpenFLStarling = this._objectToLayer.get(object);
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
	#end
	
}