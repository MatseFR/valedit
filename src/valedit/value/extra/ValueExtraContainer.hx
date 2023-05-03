package valedit.value.extra;
import valedit.ExposedCollection;
import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ValueExtraContainer 
{
	public var collection(get, set):ExposedCollection;
	private var _collection:ExposedCollection;
	private function get_collection():ExposedCollection { return this._collection; }
	private function set_collection(value:ExposedCollection):ExposedCollection
	{
		for (extra in this._extras)
		{
			extra.collection = value;
		}
		return this._collection = value;
	}
	
	public var object(get, set):Dynamic;
	private var _object:Dynamic;
	private function get_object():Dynamic { return this._object; }
	private function set_object(value:Dynamic):Dynamic
	{
		for (extra in this._extras)
		{
			extra.object = value;
		}
		return this._object = value;
	}
	
	public var owner(get, set):ExposedValue;
	private var _owner:ExposedValue;
	private function get_owner():ExposedValue { return this._owner; }
	private function set_owner(value:ExposedValue):ExposedValue
	{
		for (extra in this._extras)
		{
			extra.owner = value;
		}
		return this._owner = value;
	}
	
	private var _extras:Array<ValueExtra> = new Array<ValueExtra>();

	public function new() 
	{
		
	}
	
	public function add(extra:ValueExtra):Void
	{
		extra.collection = this._collection;
		extra.object = this._object;
		extra.owner = this._owner;
		this._extras.push(extra);
	}
	
	public function clone(toContainer:ValueExtraContainer):Void
	{
		var newExtra:ValueExtra;
		for (extra in this._extras)
		{
			newExtra = extra.clone();
			toContainer.add(newExtra);
		}
	}
	
	public function execute():Void
	{
		for (extra in this._extras)
		{
			extra.execute();
		}
	}
	
}