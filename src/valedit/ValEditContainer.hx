package valedit;
import haxe.ds.ObjectMap;
import juggler.animation.Juggler;
import openfl.display.BlendMode;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import openfl.events.EventDispatcher;
import valedit.events.PlayEvent;
import valedit.utils.ReverseIterator;
#if !valeditor
import valeditor.events.KeyFrameEvent;
#end
import valeditor.events.LayerEvent;
import valeditor.utils.MathUtil;

/**
 * ...
 * @author Matse
 */
class ValEditContainer extends EventDispatcher implements IValEditContainer implements IValEditTimeLineContainer
{
	static private var _POOL:Array<ValEditContainer> = new Array<ValEditContainer>();
	
	static public function fromPool():ValEditContainer
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new ValEditContainer();
	}
	
	public var alpha(get, set):Float;
	public var autoPlay:Bool = true;
	public var blendMode(get, set):BlendMode;
	#if starling
	public var blendModeStarling(get, set):String;
	#end
	public var cameraX(get, set):Float;
	public var cameraY(get, set):Float;
	public var container(get, never):DisplayObjectContainer;
	#if starling
	public var containerStarling(get, never):starling.display.DisplayObjectContainer;
	#end
	public var currentLayer(get, set):ValEditLayer;
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
	#if starling
	public var rootContainerStarling(get, set):starling.display.DisplayObjectContainer;
	#end
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
		if (this._alpha == value) return value;
		
		if (this._container != null)
		{
			this._container.alpha = value;
		}
		#if starling
		if (this._containerStarling != null)
		{
			this._containerStarling.alpha = value;
		}
		#end
		return this._alpha = value;
	}
	
	private var _blendMode:BlendMode = BlendMode.NORMAL;
	private function get_blendMode():BlendMode { return this._blendMode; }
	private function set_blendMode(value:BlendMode):BlendMode
	{
		if (this._blendMode == value) return value;
		
		if (this._container != null)
		{
			this._container.blendMode = value;
		}
		return this._blendMode = value;
	}
	
	#if starling
	private var _blendModeStarling:String = starling.display.BlendMode.AUTO;
	private function get_blendModeStarling():String { return this._blendModeStarling; }
	private function set_blendModeStarling(value:String):String
	{
		if (this._blendModeStarling == value) return value;
		
		if (this._containerStarling != null)
		{
			this._containerStarling.blendMode = value;
		}
		return this._blendModeStarling = value;
	}
	#end
	
	private var _cameraX:Float = 0;
	private function get_cameraX():Float { return this._cameraX; }
	private function set_cameraX(value:Float):Float
	{
		if (this._container != null)
		{
			this._container.x = this._x - value;
		}
		#if starling
		if (this._containerStarling != null)
		{
			this._containerStarling.x = this._x - value;
		}
		#end
		return this._cameraX = value;
	}
	
	private var _cameraY:Float = 0;
	private function get_cameraY():Float { return this._cameraY; }
	private function set_cameraY(value:Float):Float
	{
		if (this._container != null)
		{
			this._container.y = this._y - value;
		}
		#if starling
		if (this._containerStarling != null)
		{
			this._containerStarling.y = this._y - value;
		}
		#end
		return this._cameraY = value;
	}
	
	private var _container:Sprite;
	private function get_container():DisplayObjectContainer { return this._container; }
	
	#if starling
	private var _containerStarling:starling.display.Sprite;
	private function get_containerStarling():starling.display.DisplayObjectContainer { return this._containerStarling; }
	#end
	
	private var _currentLayer:ValEditLayer;
	private function get_currentLayer():ValEditLayer { return this._currentLayer; }
	private function set_currentLayer(value:ValEditLayer):ValEditLayer
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
	
	private function get_height():Float
	{
		#if starling
		var height:Float = 0.0;
		var heightStarling:Float = 0.0;
		if (this._container != null)
		{
			height = this._container.height;
		}
		if (this._containerStarling != null)
		{
			heightStarling = this._containerStarling.height;
		}
		return Math.max(height, heightStarling);
		#else
		if (this._container != null)
		{
			return this._container.height;
		}
		else
		{
			return 0.0;
		}
		#end
	}
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
			if (this._container == null)
			{
				createContainer();
			}
			value.addChild(this._container);
		}
		else if (this._rootContainer != null)
		{
			if (this._container != null)
			{
				this._rootContainer.removeChild(this._container);
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
			if (this._containerStarling == null)
			{
				createContainerStarling();
			}
			value.addChild(this._containerStarling);
		}
		else
		{
			if (this._containerStarling != null)
			{
				this._containerStarling.removeFromParent();
			}
		}
		
		return this._rootContainerStarling = value;
	}
	#end
	
	private var _rotation:Float = 0;
	private function get_rotation():Float { return this._rotation; }
	private function set_rotation(value:Float):Float
	{
		if (this._rotation == value) return value;
		if (this._container != null)
		{
			this._container.rotation = value;
		}
		#if starling
		if (this._containerStarling != null)
		{
			this._containerStarling.rotation = MathUtil.deg2rad(value);
		}
		#end
		return this._rotation = value;
	}
	
	private var _scaleX:Float = 1.0;
	private function get_scaleX():Float { return this._scaleX; }
	private function set_scaleX(value:Float):Float
	{
		if (this._scaleX == value) return value;
		if (this._container != null)
		{
			this._container.scaleX = value;
		}
		#if starling
		if (this._containerStarling != null)
		{
			this._containerStarling.scaleX = value;
		}
		#end
		return this._scaleX = value;
	}
	
	private var _scaleY:Float = 1.0;
	private function get_scaleY():Float { return this._scaleY; }
	private function set_scaleY(value:Float):Float
	{
		if (this._scaleY == value) return value;
		if (this._container != null)
		{
			this._container.scaleY = value;
		}
		#if starling
		if (this._containerStarling != null)
		{
			this._containerStarling.scaleY = value;
		}
		#end
		return this._scaleY = value;
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
	
	private function get_width():Float
	{
		#if starling
		var width:Float = 0.0;
		var widthStarling:Float = 0.0;
		if (this._container != null)
		{
			width = this._container.width;
		}
		if (this._containerStarling != null)
		{
			widthStarling = this._containerStarling.width;
		}
		return Math.max(width, widthStarling);
		#else
		if (this._container != null)
		{
			return this._container.width;
		}
		else
		{
			return 0.0;
		}
		#end
	}
	private function set_width(value:Float):Float
	{
		var w:Float = this.width / this.scaleX;
		if (w == 0.0) return w;
		this.scaleX = value / w;
		return value;
	}
	
	private var _x:Float = 0;
	private function get_x():Float { return this._x; }
	private function set_x(value:Float):Float
	{
		if (this._container != null)
		{
			this._container.x = value - this._cameraX;
		}
		#if starling
		if (this._containerStarling != null)
		{
			this._containerStarling.x = value - this._cameraX;
		}
		#end
		return this._x = value;
	}
	
	private var _y:Float = 0;
	private function get_y():Float { return this._y; }
	private function set_y(value:Float):Float
	{
		if (this._container != null)
		{
			this._container.y = value - this._cameraY;
		}
		#if starling
		if (this._containerStarling != null)
		{
			this._containerStarling.y = value - this._cameraY;
		}
		#end
		return this._y = value;
	}
	
	private var _layers:Array<ValEditLayer> = new Array<ValEditLayer>();
	private var _layerMap:Map<String, ValEditLayer> = new Map<String, ValEditLayer>();
	
	private var _allObjects:Map<String, ValEditObject> = new Map<String, ValEditObject>();
	private var _activeObjects:Map<String, ValEditObject> = new Map<String, ValEditObject>();
	private var _objectToLayer:ObjectMap<ValEditObject, ValEditLayer> = new ObjectMap<ValEditObject, ValEditLayer>();
	
	public function new() 
	{
		super();
		if (this.timeLine == null)
		{
			this.timeLine = new ValEditTimeLine();
		}
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
		
		if (this._rootContainer != null)
		{
			this.rootContainer = null;
		}
		
		#if starling
		if (this._rootContainerStarling != null)
		{
			this.rootContainerStarling = null;
		}
		#end
		
		if (this._container != null)
		{
			this._container = null;
		}
		
		#if starling
		if (this._containerStarling != null)
		{
			this._containerStarling.dispose();
			this._containerStarling = null;
		}
		#end
		
		this.alpha = 1.0;
		this.autoPlay = true;
		this.blendMode = BlendMode.NORMAL;
		#if starling
		this.blendModeStarling = starling.display.BlendMode.AUTO;
		#end
		this.cameraX = 0;
		this.cameraY = 0;
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
	
	public function addLayer(layer:ValEditLayer):Void
	{
		this._layers[this._layers.length] = layer;
		this._layerMap.set(layer.name, layer);
		layerRegister(layer, this._layers.length - 1);
	}
	
	public function addLayerAt(layer:ValEditLayer, index:Int):Void
	{
		this._layers.insert(index, layer);
		this._layerMap.set(layer.name, layer);
		layerRegister(layer, index);
	}
	
	public function destroyLayer(layer:ValEditLayer):Void
	{
		removeLayer(layer);
	}
	
	public function getLayer(name:String):ValEditLayer
	{
		return this._layerMap.get(name);
	}
	
	public function getLayerAt(index:Int):ValEditLayer
	{
		return this._layers[index];
	}
	
	public function removeLayer(layer:ValEditLayer):Void
	{
		var index:Int = this._layers.indexOf(layer);
		this._layers.splice(index, 1);
		this._layerMap.remove(layer.name);
		layerUnregister(layer);
	}
	
	public function removeLayerAt(index:Int):Void
	{
		var layer:ValEditLayer = this._layers.splice(index, 1)[0];
		this._layerMap.remove(layer.name);
		layerUnregister(layer);
	}
	
	public function removeLayerWithName(name:String):Void
	{
		var layer:ValEditLayer = this._layerMap.get(name);
		removeLayer(layer);
	}
	
	private function layerRegister(layer:ValEditLayer, index:Int):Void
	{
		layer.container = this;
		this.timeLine.addSlaveAt(layer.timeLine, index);
		if (this._container != null)
		{
			layer.rootContainer = this._container;
		}
		#if starling
		if (this._containerStarling != null)
		{
			layer.rootContainerStarling = this._containerStarling;
		}
		#end
		
		#if !valeditor
		for (object in layer.allObjects)
		{
			objectRegister(object);
		}
		
		layer.addEventListener(KeyFrameEvent.OBJECT_ADDED, layer_objectAdded);
		layer.addEventListener(KeyFrameEvent.OBJECT_REMOVED, layer_objectRemoved);
		#end
		layer.addEventListener(LayerEvent.OBJECT_ACTIVATED, layer_objectActivated);
		layer.addEventListener(LayerEvent.OBJECT_DEACTIVATED, layer_objectDeactivated);
	}
	
	private function layerUnregister(layer:ValEditLayer):Void
	{
		layer.container = null;
		this.timeLine.removeSlave(layer.timeLine);
		if (this._container != null)
		{
			layer.rootContainer = null;
		}
		#if starling
		if (this._containerStarling != null)
		{
			layer.rootContainerStarling = null;
		}
		#end
		
		#if !valeditor
		for (object in layer.allObjects)
		{
			objectUnregister(object);
		}
		
		layer.removeEventListener(KeyFrameEvent.OBJECT_ADDED, layer_objectAdded);
		layer.removeEventListener(KeyFrameEvent.OBJECT_REMOVED, layer_objectRemoved);
		#end
		layer.removeEventListener(LayerEvent.OBJECT_ACTIVATED, layer_objectActivated);
		layer.removeEventListener(LayerEvent.OBJECT_DEACTIVATED, layer_objectDeactivated);
	}
	
	#if !valeditor
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
	#end
	
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
		this._currentLayer.add(object);
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
		var layer:ValEditLayer = this._objectToLayer.get(object);
		layer.remove(object);
	}
	
	public function removeObjectCompletely(object:ValEditObject):Void
	{
		object.removeAllKeyFrames();
	}
	
	private function createContainer():Void
	{
		this._container = new Sprite();
		this._container.alpha = this._alpha;
		this._container.blendMode = this._blendMode;
		this._container.rotation = this._rotation;
		this._container.scaleX = this._scaleX;
		this._container.scaleY = this._scaleY;
		this._container.x = this._x - this._cameraX;
		this._container.y = this._y - this._cameraY;
		this._container.visible = this._visible;
		
		for (i in new ReverseIterator(this._layers.length - 1, 0))
		{
			this._layers[i].rootContainer = this._container;
		}
		if (this._rootContainer != null) this._rootContainer.addChild(this._container);
	}
	
	private function clearContainer():Void
	{
		if (this._rootContainer != null)
		{
			this._rootContainer.removeChild(this._container);
		}
		this._container = null;
	}
	
	#if starling
	private function createContainerStarling():Void
	{
		this._containerStarling = new starling.display.Sprite();
		this._containerStarling.alpha = this._alpha;
		this._containerStarling.blendMode = this._blendModeStarling;
		this._containerStarling.rotation = MathUtil.deg2rad(this._rotation);
		this._containerStarling.scaleX = this._scaleX;
		this._containerStarling.scaleY = this._scaleY;
		this._containerStarling.x = this._x - this._cameraX;
		this._containerStarling.y = this._y - this._cameraY;
		this._containerStarling.visible = this._visible;
		
		for (i in new ReverseIterator(this._layers.length - 1, 0))
		{
			this._layers[i].rootContainerStarling = this._containerStarling;
		}
		if (this._rootContainerStarling != null) this._rootContainerStarling.addChild(this._containerStarling);
	}
	
	private function clearContainerStarling():Void
	{
		if (this._rootContainerStarling != null)
		{
			this._rootContainerStarling.removeChild(this._containerStarling);
		}
		this._containerStarling.dispose();
		this._containerStarling = null;
	}
	#end
	
	private function onPlay(evt:PlayEvent):Void
	{
		PlayEvent.dispatch(this, PlayEvent.PLAY);
	}
	
	private function onStop(evt:PlayEvent):Void
	{
		PlayEvent.dispatch(this, PlayEvent.STOP);
	}
	
}