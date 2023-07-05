package valedit;
import openfl.events.EventDispatcher;
import valedit.util.PropertyMap;

/**
 * ...
 * @author Matse
 */
class ValEditObject extends EventDispatcher
{
	public var className:String;
	public var clss:ValEditClass;
	public var id(get, set):String;
	public var object:Dynamic;
	public var objectType:Int = -1;
	/** non-proxy object */
	public var realObject:Dynamic;
	public var template:ValEditTemplate;
	
	public var propertyMap:PropertyMap;
	public var realPropertyMap:PropertyMap;
	
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
		
		this._id = id;
		this.clss = clss;
		this.className = clss.className;
		this.objectType = clss.objectType;
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
	
}