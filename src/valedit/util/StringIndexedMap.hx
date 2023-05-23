package valedit.util;

/**
 * Thanks to Chris Speciale !
 */
class StringIndexedMap<V>
{
	private var keys:Array<String> = [];
	private var values:Array<V> = [];
	private var map:Map<String, Int> = new Map<String, Int>();

	public function new() {}

	public function set(key:String, value:V):Void
	{
		if (map.exists(key)) {
			values[map.get(key)] = value;
		} else {
			map.set(key, keys.length);
			keys.push(key);
			values.push(value);
		}
	}
	
	public function get(key:String):Null<V>
	{
		if (map.exists(key)) {
			return values[map.get(key)];
		} else {
			return null;
		}
	}
	
	public function remove(key:String):Void
	{
		if (map.exists(key)) {
			var index:Int = map.get(key);
			keys.splice(index, 1);
			values.splice(index, 1);
			map.remove(key);
			for (i in index...keys.length) {
				map.set(keys[i], i);
			}
		}
	}
	
	public function exists(key:String):Bool
	{
		return map.exists(key);
	}
	
	public function iterator():Iterator<V>
	{
		return values.iterator();
	}
	
	public function keysIterator():Iterator<String>
	{
		return keys.iterator();
	}
	
	public function valuesIterator():Iterator<V>
	{
		return values.iterator();
	}
	
	public function getKeys():Array<String>
	{
		return keys.copy();
	}
	
	public function getValues():Array<V>
	{
		return values.copy();
	}
}