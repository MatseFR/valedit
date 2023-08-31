package valedit;
import haxe.ds.ObjectMap;
import juggler.animation.Juggler;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import openfl.events.EventDispatcher;
import valedit.events.PlayEvent;
import valedit.utils.StringIndexedMap;

#if valeditor
import valeditor.events.LayerEvent;
#end

/**
 * ...
 * @author Matse
 */
class ValEditContainer extends EventDispatcher implements IValEditContainer
{
	static private var _POOL:Array<ValEditContainer> = new Array<ValEditContainer>();
	
	static public function fromPool():ValEditContainer
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new ValEditContainer();
	}
	
	public var autoPlay:Bool = true;
	public var cameraX(get, set):Float;
	public var cameraY(get, set):Float;
	public var currentLayer(get, set):ValEditLayer;
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
	#if starling
	public var rootContainerStarling(get, set):starling.display.DisplayObjectContainer;
	#end
	public var timeLine(default, null):ValEditTimeLine;
	public var visible(get, set):Bool;
	public var x(get, set):Float;
	public var y(get, set):Float;
	
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
	
	private var _container:Sprite;
	#if starling
	private var _containerStarling:starling.display.Sprite;
	#end
	
	private var _layers:Array<ValEditLayer> = new Array<ValEditLayer>();
	private var _layerMap:Map<String, ValEditLayer> = new Map<String, ValEditLayer>();
	
	private var _objects:StringIndexedMap<ValEditObject> = new StringIndexedMap<ValEditObject>();
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
			layer.clear();
		}
		this._layers.resize(0);
		this._layerMap.clear();
		this._currentLayer = null;
		
		if (this._rootContainer != null)
		{
			this.rootContainer = null;
		}
		
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
		
		this.autoPlay = true;
		this.cameraX = 0;
		this.cameraY = 0;
		this.visible = true;
		this.x = 0;
		this.y = 0;
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
		this._layers.remove(layer);
		this._layerMap.remove(layer.name);
		layerUnregister(layer);
	}
	
	public function removeLayerAt(index:Int):Void
	{
		var layer:ValEditLayer = this._layers.splice(index, 1)[0];
		this._layerMap.remove(layer.name);
		layerUnregister(layer);
	}
	
	private function layerRegister(layer:ValEditLayer, index:Int):Void
	{
		layer.valEditContainer = this;
		this.timeLine.addChildAt(layer.timeLine, index);
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
		#if valeditor
		layer.addEventListener(LayerEvent.OBJECT_ADDED, layer_objectAdded);
		layer.addEventListener(LayerEvent.OBJECT_REMOVED, layer_objectRemoved);
		#end
	}
	
	private function layerUnregister(layer:ValEditLayer):Void
	{
		layer.valEditContainer = null;
		this.timeLine.removeChild(layer.timeLine);
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
		#if valeditor
		layer.removeEventListener(LayerEvent.OBJECT_ADDED, layer_objectAdded);
		layer.removeEventListener(LayerEvent.OBJECT_REMOVED, layer_objectRemoved);
		#end
	}
	
	#if valeditor
	private function layer_objectAdded(evt:LayerEvent):Void
	{
		this._objects.set(evt.object.id, evt.object);
		this._objectToLayer.set(evt.object, evt.layer);
	}
	
	private function layer_objectRemoved(evt:LayerEvent):Void
	{
		this._objects.remove(evt.object.id);
		this._objectToLayer.remove(evt.object);
	}
	#end
	
	public function add(object:ValEditObject):Void
	{
		this._currentLayer.add(object);
	}
	
	public function get(objectName:String):ValEditObject
	{
		return this._objects.get(objectName);
	}
	
	public function remove(object:ValEditObject):Void
	{
		var layer:ValEditLayer = this._objectToLayer.get(object);
		layer.remove(object);
	}
	
	private function createContainer():Void
	{
		this._container = new Sprite();
		this._container.x = this._x - this._cameraX;
		this._container.y = this._y - this._cameraY;
		this._container.visible = this._visible;
		for (layer in this._layers)
		{
			layer.rootContainer = this._container;
		}
		if (this._rootContainer != null) this._rootContainer.addChild(this._container);
	}
	
	#if starling
	private function createContainerStarling():Void
	{
		this._containerStarling = new starling.display.Sprite();
		this._containerStarling.x = this._x - this._cameraX;
		this._containerStarling.y = this._y - this._cameraY;
		this._containerStarling.visible = this._visible;
		for (layer in this._layers)
		{
			layer.rootContainerStarling = this._containerStarling;
		}
		if (this._rootContainerStarling != null) this._rootContainerStarling.addChild(this._containerStarling);
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