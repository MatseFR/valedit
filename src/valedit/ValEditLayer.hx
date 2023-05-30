package valedit;
import feathers.data.ArrayCollection;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import openfl.events.EventDispatcher;
import valedit.util.StringIndexedMap;

/**
 * ...
 * @author Matse
 */
class ValEditLayer extends EventDispatcher
{
	public var name(get, set):String;
	private var _name:String;
	private function get_name():String { return this._name; }
	private function set_name(value:String):String
	{
		if (value == this._name) return value;
		this._name = value;
		// TODO : dispatch event
		return value;
	}
	
	public var valEditContainer(get, set):ValEditContainer;
	private var _valEditContainer:ValEditContainer;
	private function get_valEditContainer():ValEditContainer { return this._valEditContainer; }
	private function set_valEditContainer(value:ValEditContainer):ValEditContainer
	{
		return this._valEditContainer = value;
	}
	
	public var rootContainer(get, set):DisplayObjectContainer;
	private var _rootContainer:DisplayObjectContainer;
	private function get_rootContainer():DisplayObjectContainer { return this._rootContainer; }
	private function set_rootContainer(value:DisplayObjectContainer):DisplayObjectContainer
	{
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
	
	#if starling
	public var rootContainerStarling(get, set):starling.display.DisplayObjectContainer;
	private var _rootContainerStarling:starling.display.DisplayObjectContainer;
	private function get_rootContainerStarling():starling.display.DisplayObjectContainer { return this._rootContainerStarling; }
	private function set_rootContainerStarling(value:starling.display.DisplayObjectContainer):starling.display.DisplayObjectContainer
	{
		if (value != null)
		{
			value.addChild(this._containerStarling);
		}
		else if (this._rootContainerStarling != null)
		{
			this._rootContainerStarling.removeChild(this._containerStarling);
		}
		return this._rootContainerStarling = value;
	}
	#end
	
	public var timeLine(default, null):ValEditTimeLine = new ValEditTimeLine();
	
	public var visible(get, set):Bool;
	private var _visible:Bool = true;
	private function get_visible():Bool { return this._visible; }
	private function set_visible(value:Bool):Bool
	{
		if (value == this._visible) return value;
		if (this._container != null) this._container.visible = value;
		#if starling
		if (this._containerStarling != null) this._containerStarling.visible = value;
		#end
		return this._visible = value;
	}
	
	public var x(get, set):Float;
	private var _x:Float = 0;
	private function get_x():Float { return this._x; }
	private function set_x(value:Float):Float
	{
		this._container.x = value;
		#if starling
		this._containerStarling.x = value;
		#end
		return this._x = value;
	}
	
	public var y(get, set):Float;
	private var _y:Float = 0;
	private function get_y():Float { return this._y; }
	private function set_y(value:Float):Float
	{
		this._container.y = value;
		#if starling
		this._containerStarling.y = value;
		#end
		return this._y = value;
	}
	
	public var objectCollection(default, null):ArrayCollection<ValEditObject> = new ArrayCollection<ValEditObject>();
	
	private var _objects:StringIndexedMap<ValEditObject> = new StringIndexedMap<ValEditObject>();
	
	private var _container:Sprite = new Sprite();
	#if starling
	private var _containerStarling:starling.display.Sprite = new starling.display.Sprite();
	#end

	public function new() 
	{
		super();
	}
	
}