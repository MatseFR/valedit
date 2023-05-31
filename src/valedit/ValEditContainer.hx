package valedit;
import editor.MouseController;
import events.SelectionEvent;
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
	
	private var _selection:ValEditObjectGroup = new ValEditObjectGroup();
	
	private var _mouseDownOnObject:Bool;
	private var _mouseDownWithCtrl:Bool;
	private var _mouseDownWithShift:Bool;
	
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
				//dispatcher.addEventListener(MouseEvent.MOUSE_UP, onObjectMouseUp);
			
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
				//dispatcher.removeEventListener(MouseEvent.MOUSE_UP, onObjectMouseUp);
			
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
		
		ValEdit.selection.addEventListener(SelectionEvent.CHANGE, onSelectionChange);
		this._containerUI.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		Lib.current.stage.addEventListener(MouseEvent.CLICK, onStageMouseClick);
	}
	
	public function close():Void
	{
		if (!this._isOpen) return;
		
		ValEdit.selection.removeEventListener(SelectionEvent.CHANGE, onSelectionChange);
		this._containerUI.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		Lib.current.stage.removeEventListener(MouseEvent.CLICK, onStageMouseClick);
	}
	
	private function onObjectMouseDown(evt:MouseEvent):Void
	{
		//trace("ValEditContainer.onObjectMouseDown");
		
		if (this._mouseDownOnObject) return;
		this._mouseDownOnObject = true;
		
		this._mouseDownWithCtrl = evt.ctrlKey;
		this._mouseDownWithShift = evt.shiftKey;
		
		var object:ValEditObject = this._interactiveObjectToValEditObject.get(evt.target);
		if (this._mouseObject != null && this._mouseObject != object && !this._mouseDownWithCtrl && !this._mouseDownWithShift)
		{
			ValEdit.selection.object = null;
		}
		this._mouseObject = object;
		this._mouseObject.isMouseDown = true;
		this._selection.isMouseDown = true;
		this._mouseObjectOffsetX = evt.localX;
		this._mouseObjectOffsetY = evt.localY;
		this._mouseObjectRestoreX = this._mouseObject.getProperty(RegularPropertyName.X);
		this._mouseObjectRestoreY = this._mouseObject.getProperty(RegularPropertyName.Y);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, onObjectMouseMove);
		
		cast(this._mouseObject.interactiveObject, EventDispatcher).addEventListener(MouseEvent.MOUSE_UP, onObjectMouseUp);
		cast(this._mouseObject.interactiveObject, EventDispatcher).addEventListener(MouseEvent.RELEASE_OUTSIDE, onObjectMouseUpOutside);
	}
	
	private function onObjectMouseUp(evt:MouseEvent):Void
	{
		//trace("ValEditContainer.onObjectMouseUp");
		
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onObjectMouseMove);
		cast(this._mouseObject.interactiveObject, EventDispatcher).removeEventListener(MouseEvent.MOUSE_UP, onObjectMouseUp);
		cast(this._mouseObject.interactiveObject, EventDispatcher).removeEventListener(MouseEvent.RELEASE_OUTSIDE, onObjectMouseUpOutside);
		
		if ((this._mouseDownWithCtrl && evt.ctrlKey) || (this._mouseDownWithShift && evt.shiftKey))
		{
			if (this._selection.hasObject(this._mouseObject))
			{
				ValEdit.selection.removeObject(this._mouseObject);
			}
			else
			{
				ValEdit.selection.addObject(this._mouseObject);
			}
		}
		else if (!this._selection.hasObject(this._mouseObject))
		{
			ValEdit.selection.object = this._mouseObject;
		}
		
		this._mouseObject.isMouseDown = false;
		this._selection.isMouseDown = false;
		
		this._mouseObject = null;
		
		for (obj in this._selection)
		{
			obj.selectionBox.objectUpdate(obj);
			obj.pivotIndicator.objectUpdate(obj);
		}
	}
	
	private function onObjectMouseUpOutside(evt:MouseEvent):Void
	{
		trace("ValEditContainer.onObjectMouseUpOutside");
		
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onObjectMouseMove);
		cast(this._mouseObject.interactiveObject, EventDispatcher).removeEventListener(MouseEvent.MOUSE_UP, onObjectMouseUp);
		cast(this._mouseObject.interactiveObject, EventDispatcher).removeEventListener(MouseEvent.RELEASE_OUTSIDE, onObjectMouseUpOutside);
		
		this._mouseObject.isMouseDown = false;
		this._selection.isMouseDown = false;
		
		if (!this._selection.hasObject(this._mouseObject))
		{
			ValEdit.selection.object = this._mouseObject;
		}
		
		this._mouseObject.setProperty(RegularPropertyName.X, this._mouseObjectRestoreX);
		this._mouseObject.setProperty(RegularPropertyName.Y, this._mouseObjectRestoreY);
		
		this._mouseObject = null;
	}
	
	private function onObjectMouseMove(evt:MouseEvent):Void
	{
		//trace("ValEditContainer.onObjectMouseMove " + evt.target + " " + evt.currentTarget + " " + evt.stageX + ", " + evt.localY);
		
		this._mouseDownWithCtrl = false;
		this._mouseDownWithShift = false;
		
		if (!this._selection.hasObject(this._mouseObject))
		{
			ValEdit.selection.object = null;
			this._mouseObject.setProperty(RegularPropertyName.X, evt.stageX - this._mouseObjectOffsetX + this._cameraX);
			this._mouseObject.setProperty(RegularPropertyName.Y, evt.stageY - this._mouseObjectOffsetY + this._cameraY);
		}
		else
		{
			var moveX:Float = evt.stageX - this._mouseObjectOffsetX + this._cameraX - this._mouseObject.getProperty(RegularPropertyName.X);
			var moveY:Float = evt.stageY - this._mouseObjectOffsetY + this._cameraY - this._mouseObject.getProperty(RegularPropertyName.Y);
			this._selection.modifyProperty(RegularPropertyName.X, moveX);
			this._selection.modifyProperty(RegularPropertyName.Y, moveY);
		}
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
			
			this._mouseDownWithCtrl = evt.ctrlKey;
			this._mouseDownWithShift = evt.shiftKey;
			
			if (this._mouseObject != null && this._mouseObject != object && !this._mouseDownWithCtrl && !this._mouseDownWithShift)
			{
				ValEdit.selection.object = null;
			}
			this._mouseObject = object;
			this._mouseObject.isMouseDown = true;
			this._selection.isMouseDown = true;
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
			
			if ((this._mouseDownWithCtrl && evt.ctrlKey) || (this._mouseDownWithShift && evt.shiftKey))
			{
				if (this._selection.hasObject(this._mouseObject))
				{
					ValEdit.selection.removeObject(this._mouseObject);
				}
				else
				{
					ValEdit.selection.addObject(this._mouseObject);
				}
			}
			else if (!this._selection.hasObject(this._mouseObject))
			{
				ValEdit.selection.object = this._mouseObject;
			}
			
			this._mouseObject.isMouseDown = false;
			this._selection.isMouseDown = false;
			
			if (MouseController.isMouseOverUI)
			{
				// release outside
				this._mouseObject.setProperty(RegularPropertyName.X, this._mouseObjectRestoreX);
				this._mouseObject.setProperty(RegularPropertyName.Y, this._mouseObjectRestoreY);
			}
			
			this._mouseObject = null;
			
			for (obj in this._selection)
			{
				obj.selectionBox.objectUpdate(obj);
				obj.pivotIndicator.objectUpdate(obj);
			}
		}
	}
	#end
	
	private function select(object:ValEditObject):Void
	{
		var box:SelectionBox = SelectionBox.fromPool();
		this._containerUI.addChild(box);
		object.selectionBox = box;
		
		var pivot:PivotIndicator = PivotIndicator.fromPool();
		this._containerUI.addChild(pivot);
		object.pivotIndicator = pivot;
		
		this._selection.addObject(object);
	}
	
	private function unselect(object:ValEditObject):Void
	{
		var box:SelectionBox = object.selectionBox;
		this._containerUI.removeChild(box);
		object.selectionBox = null;
		box.pool();
		
		var pivot:PivotIndicator = object.pivotIndicator;
		this._containerUI.removeChild(pivot);
		object.pivotIndicator = null;
		pivot.pool();
		
		this._selection.removeObject(object);
	}
	
	private function clearSelection():Void
	{
		for (object in this._selection)
		{
			this._objectsToDeselect.push(object);
		}
		
		for (object in this._objectsToDeselect)
		{
			unselect(object);
		}
		this._objectsToDeselect.resize(0);
	}
	
	private var _objectsToDeselect:Array<ValEditObject> = new Array<ValEditObject>();
	private function onSelectionChange(evt:SelectionEvent):Void
	{
		if (evt.object == null)
		{
			clearSelection();
		}
		else if (Std.isOfType(evt.object, ValEditTemplate))
		{
			clearSelection();
		}
		else if (Std.isOfType(evt.object, ValEditObject))
		{
			var object:ValEditObject = cast evt.object;
			if (this._selection.hasObject(object))
			{
				for (obj in this._selection)
				{
					if (obj != object) this._objectsToDeselect.push(obj);
				}
				
				for (obj in this._objectsToDeselect)
				{
					unselect(obj);
				}
				this._objectsToDeselect.resize(0);
			}
			else
			{
				clearSelection();
				select(object);
			}
		}
		else // ValEditGroup
		{
			var group:ValEditObjectGroup = cast evt.object;
			for (obj in this._selection)
			{
				if (!group.hasObject(obj))
				{
					this._objectsToDeselect.push(obj);
				}
			}
			
			for (obj in this._objectsToDeselect)
			{
				unselect(obj);
			}
			this._objectsToDeselect.resize(0);
			
			for (obj in group)
			{
				if (!this._selection.hasObject(obj))
				{
					select(obj);
				}
			}
		}
	}
	
	private function onStageMouseClick(evt:MouseEvent):Void
	{
		if (evt.target != Lib.current.stage) return;
		if (this._mouseObject != null) return;
		if (this._selection.numObjects == 0) return;
		ValEdit.selection.object = null;
	}
	
	private function onEnterFrame(evt:Event):Void
	{
		this._mouseDownOnObject = false;
	}
}