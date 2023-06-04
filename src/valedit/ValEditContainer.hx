package valedit;
import haxe.ds.ObjectMap;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import openfl.errors.Error;
import valedit.util.StringIndexedMap;

/**
 * ...
 * @author Matse
 */
class ValEditContainer 
{
	public var x(get, set):Float;
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
	
	public var y(get, set):Float;
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
	
	public var cameraX(get, set):Float;
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
	
	public var cameraY(get, set):Float;
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
	
	public var rootContainer(get, set):DisplayObjectContainer;
	private var _rootContainer:DisplayObjectContainer;
	private function get_rootContainer():DisplayObjectContainer { return this._rootContainer; }
	private function set_rootContainer(value:DisplayObjectContainer):DisplayObjectContainer
	{
		if (this._rootContainer == value) return value;
		
		if (value != null)
		{
			if (this._container == null)
			{
				this._container = new Sprite();
				this._container.x = this._x - this._cameraX;
				this._container.y = this._y - this._cameraY;
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
	public var rootContainerStarling(get, set):starling.display.DisplayObjectContainer;
	private var _rootContainerStarling:starling.display.DisplayObjectContainer;
	private function get_rootContainerStarling():starling.display.DisplayObjectContainer { return this._rootContainerStarling; }
	private function set_rootContainerStarling(value:starling.display.DisplayObjectContainer):starling.display.DisplayObjectContainer
	{
		if (this._rootContainerStarling == value) return value;
		
		if (value != null)
		{
			if (this._containerStarling == null)
			{
				this._containerStarling = new starling.display.Sprite();
				this._containerStarling.x = this._x - this._cameraX;
				this._containerStarling.y = this._y - this._cameraY;
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
	
	private var _container:Sprite;
	#if starling
	private var _containerStarling:starling.display.Sprite;
	#end
	
	private var _layers:StringIndexedMap<ValEditLayer> = new StringIndexedMap<ValEditLayer>();
	private var _objects:StringIndexedMap<ValEditObject> = new StringIndexedMap<ValEditObject>();
	
	private var _objectToValEditObject:ObjectMap<Dynamic, ValEditObject> = new ObjectMap<Dynamic, ValEditObject>();
	
	public function new() 
	{
		
	}
	
	public function addLayer(layer:ValEditLayer):Void
	{
		this._layers.set(layer.name, layer);
		layer.valEditContainer = this;
	}
	
	public function addLayerAt(layer:ValEditLayer, index:Int):Void
	{
		this._layers.insert(layer.name, layer, index);
		layer.valEditContainer = this;
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
		layer.valEditContainer = null;
	}
	
	public function add(object:ValEditObject):Void
	{
		switch (object.objectType)
		{
			case ObjectType.DISPLAY_OPENFL :
				if (object.clss.addToDisplayCustom != null)
				{
					#if neko
					Reflect.callMethod(null, object.clss.addToDisplayCustom, [object.object, this._container]);
					#else
					object.clss.addToDisplayCustom(object.object, this._container);
					#end
				}
				else
				{
					this._container.addChild(object.object);
				}
			
			#if starling
			case ObjectType.DISPLAY_STARLING :
				if (object.clss.addToDisplayCustom != null)
				{
					#if neko
					Reflect.callMethod(null, object.clss.addToDisplayCustom, [object.object, this._containerStarling]);
					#else
					object.clss.addToDisplayCustom(object.object, this._containerStarling);
					#end
				}
				else
				{
					this._containerStarling.addChild(object.object);
				}
			#end
			
			case ObjectType.OTHER :
				// nothing here
			
			default :
				throw new Error("ValEditContainer.add ::: unknown object type " + object.objectType);
		}
		
		this._objects.set(object.id, object);
		this._objectToValEditObject.set(object.object, object);
	}
	
	public function get(objectName:String):ValEditObject
	{
		return this._objects.get(objectName);
	}
	
	public function remove(object:ValEditObject):Void
	{
		switch (object.objectType)
		{
			case ObjectType.DISPLAY_OPENFL :
				if (object.clss.removeFromDisplayCustom != null)
				{
					#if neko
					Reflect.callMethod(null, object.clss.removeFromDisplayCustom, [object.object, this._container]);
					#else
					object.clss.removeFromDisplayCustom(object.object, this._container);
					#end
				}
				else
				{
					this._container.removeChild(object.object);
				}
			
			#if starling
			case ObjectType.DISPLAY_STARLING :
				if (object.clss.removeFromDisplayCustom != null)
				{
					#if neko
					Reflect.callMethod(null, object.clss.removeFromDisplayCustom, [object.object, this._containerStarling]);
					#else
					object.clss.removeFromDisplayCustom(object.object, this._containerStarling);
					#end
				}
				else
				{
					this._containerStarling.removeChild(object.object);
				}
			#end
			
			case ObjectType.OTHER :
				// nothing here
			
			default :
				throw new Error("ValEditContainer.remove ::: unknown object type " + object.objectType);
		}
		
		this._objects.remove(object.id);
		this._objectToValEditObject.remove(object.object);
	}
	
}