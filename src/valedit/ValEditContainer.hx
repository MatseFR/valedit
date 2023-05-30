package valedit;
import editor.MouseController;
import feathers.data.ArrayCollection;
import haxe.ds.ObjectMap;
import openfl.Lib;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import openfl.errors.Error;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.events.MouseEvent;
import openfl.geom.Point;
#if starling
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
#end
import ui.UIConfig;
import ui.feathers.controls.SelectionBox;
import ui.shape.PivotIndicator;
import valedit.util.RegularPropertyName;
import valedit.util.StringIndexedMap;

/**
 * ...
 * @author Matse
 */
class ValEditContainer 
{
	public var isOpen(get, never):Bool;
	private var _isOpen:Bool;
	private function get_isOpen():Bool { return this._isOpen; }
	
	public var x(get, set):Float;
	private var _x:Float = 0;
	private function get_x():Float { return this._x; }
	private function set_x(value:Float):Float
	{
		if (this._container != null)
		{
			this._container.x = value - this._cameraX;
		}
		if (this._containerUI != null)
		{
			this._containerUI.x = value - this._cameraX;
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
		if (this._containerUI != null)
		{
			this._containerUI.y = value - this._cameraY;
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
		if (this._containerUI != null)
		{
			this._containerUI.x = this._x - value;
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
		if (this._containerUI != null)
		{
			this._containerUI.y = this._y - value;
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
			
			value.addChild(this._containerUI);
		}
		else if (this._rootContainer != null)
		{
			if (this._container != null)
			{
				this._rootContainer.removeChild(this._container);
			}
			
			this._rootContainer.removeChild(this._containerUI);
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
	private var _containerUI:Sprite = new Sprite();
	#if starling
	private var _containerStarling:starling.display.Sprite;
	#end
	
	public var layerCollection(default, null):ArrayCollection<ValEditLayer> = new ArrayCollection<ValEditLayer>();
	public var objectCollection(default, null):ArrayCollection<ValEditObject> = new ArrayCollection<ValEditObject>();
	
	private var _layers:StringIndexedMap<ValEditLayer> = new StringIndexedMap<ValEditLayer>();
	private var _objects:StringIndexedMap<ValEditObject> = new StringIndexedMap<ValEditObject>();
	
	private var _interactiveObjectToValEditObject:ObjectMap<Dynamic, ValEditObject> = new ObjectMap<Dynamic, ValEditObject>();
	private var _objectToValEditObject:ObjectMap<Dynamic, ValEditObject> = new ObjectMap<Dynamic, ValEditObject>();
	
	private var _mouseObject:ValEditObject;
	private var _mouseObjectOffsetX:Float;
	private var _mouseObjectOffsetY:Float;
	private var _mouseObjectRestoreX:Float;
	private var _mouseObjectRestoreY:Float;
	
	private var _mouseDownOnObject:Bool;
	
	private var _pt:Point;
	
	private var _layerNameIndex:Int = 0;
	
	public function new() 
	{
		var layer:ValEditLayer = new ValEditLayer();
		addLayer(layer);
	}
	
	public function addLayer(layer:ValEditLayer):Void
	{
		if (layer.name == null || layer.name == "")
		{
			layer.name = makeLayerName();
		}
		this._layers.set(layer.name, layer);
		this.layerCollection.add(layer);
		layer.valEditContainer = this;
	}
	
	public function addLayerAt(layer:ValEditLayer, index:Int):Void
	{
		if (layer.name == null || layer.name == "")
		{
			layer.name = makeLayerName();
		}
		this._layers.insert(layer.name, layer, index);
		this.layerCollection.addAt(layer, index);
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
	
	public function makeLayerName():String
	{
		var name:String = null;
		while (true)
		{
			this._layerNameIndex++;
			name = "layer " + this._layerNameIndex;
			if (!this._layers.exists(name)) break;
		}
		return name;
	}
	
	public function removeLayer(layer:ValEditLayer):Void
	{
		this._layers.remove(layer.name);
		this.layerCollection.remove(layer);
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
					this._container.addChild(cast object.interactiveObject);
				}
				else
				{
					this._container.addChild(object.object);
					this._container.addChild(cast object.interactiveObject);
				}
				var dispatcher:EventDispatcher = cast object.interactiveObject;
				dispatcher.addEventListener(MouseEvent.MOUSE_DOWN, onObjectMouseDown);
				dispatcher.addEventListener(MouseEvent.MOUSE_UP, onObjectMouseUp);
			
			#if starling
			case ObjectType.DISPLAY_STARLING :
				if (object.clss.addToDisplayCustom != null)
				{
					#if neko
					Reflect.callMethod(null, object.clss.addToDisplayCustom, [object.object, this._containerStarling]);
					#else
					object.clss.addToDisplayCustom(object.object, this._containerStarling);
					#end
					this._containerStarling.addChild(cast object.interactiveObject);
				}
				else
				{
					this._containerStarling.addChild(object.object);
					this._containerStarling.addChild(cast object.interactiveObject);
				}
				var starlingDispatcher:starling.events.EventDispatcher = cast object.interactiveObject;
				starlingDispatcher.addEventListener(TouchEvent.TOUCH, onObjectTouch);
			#end
			
			case ObjectType.OTHER :
				// nothing here
			
			default :
				throw new Error("ValEditContainer.add ::: unknown object type " + object.objectType);
		}
		
		this._objects.set(object.id, object);
		this._objectToValEditObject.set(object.object, object);
		this._interactiveObjectToValEditObject.set(object.interactiveObject, object);
		
		this.objectCollection.add(object);
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
					this._container.removeChild(cast object.interactiveObject);
				}
				else
				{
					this._container.removeChild(object.object);
					this._container.removeChild(cast object.interactiveObject);
				}
				var dispatcher:EventDispatcher = cast object.interactiveObject;
				dispatcher.removeEventListener(MouseEvent.MOUSE_DOWN, onObjectMouseDown);
				dispatcher.removeEventListener(MouseEvent.MOUSE_UP, onObjectMouseUp);
			
			#if starling
			case ObjectType.DISPLAY_STARLING :
				if (object.clss.removeFromDisplayCustom != null)
				{
					#if neko
					Reflect.callMethod(null, object.clss.removeFromDisplayCustom, [object.object, this._containerStarling]);
					#else
					object.clss.removeFromDisplayCustom(object.object, this._containerStarling);
					#end
					this._containerStarling.removeChild(cast object.interactiveObject);
				}
				else
				{
					this._containerStarling.removeChild(object.object);
					this._containerStarling.removeChild(cast object.interactiveObject);
				}
				var starlingDispatcher:starling.events.EventDispatcher = cast object.interactiveObject;
				starlingDispatcher.removeEventListener(TouchEvent.TOUCH, onObjectTouch);
			#end
			
			case ObjectType.OTHER :
				// nothing here
			
			default :
				throw new Error("ValEditContainer.remove ::: unknown object type " + object.objectType);
		}
		
		this._objects.remove(object.id);
		this._objectToValEditObject.remove(object.object);
		this._interactiveObjectToValEditObject.remove(object.interactiveObject);
		
		this.objectCollection.remove(object);
	}
	
	public function open():Void
	{
		if (this._isOpen) return;
		if (_containerUI == null)
		{
			_containerUI = new Sprite();
		}
		
		this._containerUI.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	public function close():Void
	{
		if (!this._isOpen) return;
		
		this._containerUI.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onObjectMouseDown(evt:MouseEvent):Void
	{
		//trace("ValEditContainer.onObjectMouseDown");
		
		if (this._mouseDownOnObject) return;
		this._mouseDownOnObject = true;
		
		var object:ValEditObject = this._interactiveObjectToValEditObject.get(evt.target);
		if (this._mouseObject != null && this._mouseObject != object)
		{
			ValEdit.selection.object = null;
		}
		this._mouseObject = object;
		this._mouseObject.isMouseDown = true;
		this._mouseObjectOffsetX = evt.localX;
		this._mouseObjectOffsetY = evt.localY;
		this._mouseObjectRestoreX = this._mouseObject.getProperty(RegularPropertyName.X);
		this._mouseObjectRestoreY = this._mouseObject.getProperty(RegularPropertyName.Y);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, onObjectMouseMove);
		
		cast(this._mouseObject.interactiveObject, EventDispatcher).addEventListener(MouseEvent.RELEASE_OUTSIDE, onObjectMouseUpOutside);
	}
	
	private function onObjectMouseUp(evt:MouseEvent):Void
	{
		//trace("ValEditContainer.onObjectMouseUp");
		
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onObjectMouseMove);
		cast(this._mouseObject.interactiveObject, EventDispatcher).removeEventListener(MouseEvent.RELEASE_OUTSIDE, onObjectMouseUpOutside);
		ValEdit.selection.object = this._mouseObject;
		
		this._mouseObject.isMouseDown = false;
		
		var box:SelectionBox = this._mouseObject.selectionBox;
		if (box == null)
		{
			box = SelectionBox.fromPool();
			this._containerUI.addChild(box);
			this._mouseObject.selectionBox = box;
		}
		else
		{
			box.objectUpdate(this._mouseObject);
		}
		
		var pivot:PivotIndicator = this._mouseObject.pivotIndicator;
		if (pivot == null)
		{
			pivot = PivotIndicator.fromPool();
			this._containerUI.addChild(pivot);
			this._mouseObject.pivotIndicator = pivot;
		}
		else
		{
			pivot.objectUpdate(this._mouseObject);
		}
	}
	
	private function onObjectMouseUpOutside(evt:MouseEvent):Void
	{
		trace("ValEditContainer.onObjectMouseUpOutside");
		
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onObjectMouseMove);
		cast(this._mouseObject.interactiveObject, EventDispatcher).removeEventListener(MouseEvent.RELEASE_OUTSIDE, onObjectMouseUpOutside);
		
		this._mouseObject.isMouseDown = false;
		
		this._mouseObject.setProperty(RegularPropertyName.X, this._mouseObjectRestoreX);
		this._mouseObject.setProperty(RegularPropertyName.Y, this._mouseObjectRestoreY);
	}
	
	private function onObjectMouseMove(evt:MouseEvent):Void
	{
		//trace("ValEditContainer.onObjectMouseMove " + evt.target + " " + evt.currentTarget + " " + evt.stageX + ", " + evt.localY);
		
		this._mouseObject.setProperty(RegularPropertyName.X, evt.stageX - this._mouseObjectOffsetX + this._cameraX);
		this._mouseObject.setProperty(RegularPropertyName.Y, evt.stageY - this._mouseObjectOffsetY + this._cameraY);
	}
	
	#if starling
	private function onObjectTouch(evt:TouchEvent):Void
	{
		//trace("ValEditContainer.onObjectTouch");
		
		var touch:Touch = evt.touches[0];
		var object:ValEditObject = this._interactiveObjectToValEditObject.get(evt.target);
		if (touch.phase == TouchPhase.BEGAN)
		{
			if (this._mouseDownOnObject) return;
			this._mouseDownOnObject = true;
			
			if (this._mouseObject != null && this._mouseObject != object)
			{
				ValEdit.selection.object = null;
			}
			this._mouseObject = object;
			this._mouseObject.isMouseDown = true;
			_pt = touch.getLocation(cast object.interactiveObject, _pt);
			if (this._mouseObject.hasPivotProperties)
			{
				this._mouseObjectOffsetX = _pt.x - this._mouseObject.getProperty(RegularPropertyName.PIVOT_X);
				this._mouseObjectOffsetY = _pt.y - this._mouseObject.getProperty(RegularPropertyName.PIVOT_Y);
			}
			else
			{
				this._mouseObjectOffsetX = _pt.x;
				this._mouseObjectOffsetY = _pt.y;
			}
			this._mouseObjectRestoreX = this._mouseObject.getProperty(RegularPropertyName.X);
			this._mouseObjectRestoreY = this._mouseObject.getProperty(RegularPropertyName.Y);
			Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, onObjectMouseMove);
		}
		else if (touch.phase == TouchPhase.ENDED)
		{
			Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onObjectMouseMove);
			ValEdit.selection.object = this._mouseObject;
			
			this._mouseObject.isMouseDown = false;
			
			if (MouseController.isMouseOverUI)
			{
				this._mouseObject.setProperty(RegularPropertyName.X, this._mouseObjectRestoreX);
				this._mouseObject.setProperty(RegularPropertyName.Y, this._mouseObjectRestoreY);
			}
			
			var box:SelectionBox = this._mouseObject.selectionBox;
			if (box == null)
			{
				box = SelectionBox.fromPool();
				this._containerUI.addChild(box);
				this._mouseObject.selectionBox = box;
			}
			else
			{
				box.objectUpdate(this._mouseObject);
			}
			
			var pivot:PivotIndicator = this._mouseObject.pivotIndicator;
			if (pivot == null)
			{
				pivot = PivotIndicator.fromPool();
				this._containerUI.addChild(pivot);
				this._mouseObject.pivotIndicator = pivot;
			}
			else
			{
				pivot.objectUpdate(this._mouseObject);
			}
		}
	}
	#end
	
	private function onEnterFrame(evt:Event):Void
	{
		//trace("onEnterFrame");
		
		this._mouseDownOnObject = false;
	}
}