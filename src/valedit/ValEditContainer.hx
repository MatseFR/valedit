package valedit;
import haxe.ds.ObjectMap;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import valedit.utils.StringIndexedMap;

#if valeditor
import valeditor.events.LayerEvent;
#end

/**
 * ...
 * @author Matse
 */
class ValEditContainer implements IValEditContainer
{
	public var cameraX(get, set):Float;
	public var cameraY(get, set):Float;
	public var currentLayer(get, set):ValEditLayer;
	public var rootContainer(get, set):DisplayObjectContainer;
	#if starling
	public var rootContainerStarling(get, set):starling.display.DisplayObjectContainer;
	#end
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
	
	private var _layers:StringIndexedMap<ValEditLayer> = new StringIndexedMap<ValEditLayer>();
	private var _objects:StringIndexedMap<ValEditObject> = new StringIndexedMap<ValEditObject>();
	private var _objectToLayer:ObjectMap<ValEditObject, ValEditLayer> = new ObjectMap<ValEditObject, ValEditLayer>();
	
	public function new() 
	{
		
	}
	
	public function clear():Void
	{
		
	}
	
	public function addLayer(layer:ValEditLayer):Void
	{
		this._layers.set(layer.name, layer);
		layerRegister(layer);
	}
	
	public function addLayerAt(layer:ValEditLayer, index:Int):Void
	{
		this._layers.insert(layer.name, layer, index);
		layerRegister(layer);
	}
	
	public function destroyLayer(layer:ValEditLayer):Void
	{
		removeLayer(layer);
	}
	
	public function getLayer(name:String):ValEditLayer
	{
		return this._layers.get(name);
	}
	
	public function removeLayer(layer:ValEditLayer):Void
	{
		this._layers.remove(layer.name);
		layerUnregister(layer);
	}
	
	private function layerRegister(layer:ValEditLayer):Void
	{
		layer.valEditContainer = this;
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
	
}