package valedit;
import openfl.events.EventDispatcher;
import valedit.utils.PropertyMap;

/**
 * ...
 * @author Matse
 */
class ValEditObject extends EventDispatcher
{
	static private var _POOL:Array<ValEditObject> = new Array<ValEditObject>();
	
	static public function fromPool(clss:ValEditClass, ?id:String):ValEditObject
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(clss, id);
		return new ValEditObject(clss, id);
	}
	
	public var className:String;
	public var clss:ValEditClass;
	public var displayObjectType:Int;
	public var id(get, set):String;
	public var isDisplayObject:Bool;
	public var object:Dynamic;
	public var template:ValEditTemplate;
	
	public var propertyMap:PropertyMap;
	
	private var _id:String;
	private function get_id():String { return this._id; }
	private function set_id(value:String):String
	{
		return this._id = value;
	}
	
	private var _realPropertyName:String;
	private var _regularPropertyName:String;
	
	public function new(clss:ValEditClass, ?id:String)
	{
		super();
		
		setTo(clss, id);
	}
	
	public function clear():Void
	{
		this.clss = null;
		this.object = null;
		this.template = null;
		this.propertyMap = null;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	public function ready():Void
	{
		
	}
	
	public function getProperty(regularPropertyName:String):Dynamic
	{
		this._realPropertyName = this.propertyMap.getObjectPropertyName(regularPropertyName);
		if (this._realPropertyName == null) this._realPropertyName = regularPropertyName;
		return Reflect.getProperty(this.object, this._realPropertyName);
	}
	
	private function setTo(clss:ValEditClass, id:String):ValEditObject
	{
		this._id = id;
		this.clss = clss;
		this.className = clss.className;
		this.isDisplayObject = clss.isDisplayObject;
		this.displayObjectType = clss.displayObjectType;
		
		return this;
	}
	
}