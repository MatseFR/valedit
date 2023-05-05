package valedit.value.extra;
import openfl.errors.Error;
import valedit.ExposedCollection;
import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ValueExtra 
{
	public var collection(get, set):ExposedCollection;
	private var _collection:ExposedCollection;
	private function get_collection():ExposedCollection { return this._collection; }
	private function set_collection(value:ExposedCollection):ExposedCollection
	{
		return this._collection = value;
	}
	
	public var object(get, set):Dynamic;
	private var _object:Dynamic;
	private function get_object():Dynamic { return this._object; }
	private function set_object(value:Dynamic):Dynamic
	{
		return this._object = value;
	}
	
	public var owner(get, set):ExposedValue;
	private var _owner:ExposedValue;
	private function get_owner():ExposedValue { return this._owner; }
	private function set_owner(value:ExposedValue):ExposedValue
	{
		return this._owner = value;
	}

	public function new() 
	{
		
	}
	
	public function applyToObject(object:Dynamic):Void
	{
		
	}
	
	public function execute():Void
	{
		
	}
	
	public function clone():ValueExtra
	{
		throw new Error("You have to override ValueExtra.clone");
	}
	
	private function clone_internal(extra:ValueExtra):Void
	{
		
	}
	
	public function fromJSON(json:Dynamic):Void
	{
		
	}
	
	public function toJSON(json:Dynamic = null):Dynamic
	{
		if (json == null) json = {};
		json.clss = Type.getClassName(Type.getClass(this));
		return json;
	}
	
	static public function valueExtraFromJSON(json:Dynamic):ValueExtra
	{
		var clss:Class<Dynamic> = Type.resolveClass(json.clss);
		var extra:ValueExtra = Type.createInstance(clss, []);
		extra.fromJSON(json);
		return extra;
	}
	
}