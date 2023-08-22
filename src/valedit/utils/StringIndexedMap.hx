package valedit.utils;

/**
 * Thanks to Chris Speciale !
 */
class StringIndexedMap<V>
{
	public var length(get, never):Int;
	
	private function get_length():Int { return this.keys.length; }
	
	private var keys:Array<String> = [];
	private var values:Array<V> = [];
	private var map:Map<String, Int> = new Map<String, Int>();

	public function new() {}
	
	public function clear():Void
	{
		this.keys.resize(0);
		this.values.resize(0);
		this.map.clear();
	}

	public function set(key:String, value:V):Void
	{
		if (this.map.exists(key))
		{
			this.values[this.map.get(key)] = value;
		}
		else
		{
			this.map.set(key, this.keys.length);
			this.keys.push(key);
			this.values.push(value);
		}
	}
	
	public function insert(key:String, value:V, at:Int):Void
	{
		var count:Int = this.keys.length;
		if (this.map.exists(key))
		{
			var index:Int = this.map.get(key);
			this.keys.splice(index, 1);
			this.values.splice(index, 1);
			this.map.remove(key);
			count--;
			for (i in index...count)
			{
				this.map.set(keys[i], i);
			}
		}
		
		this.map.set(key, at);
		this.keys.insert(at, key);
		this.values.insert(at, value);
		count++;
		for (i in at + 1...count)
		{
			this.map.set(keys[i], i);
		}
	}
	
	public function get(key:String):Null<V>
	{
		if (this.map.exists(key))
		{
			return this.values[map.get(key)];
		}
		else
		{
			return null;
		}
	}
	
	public function remove(key:String):Void
	{
		if (this.map.exists(key))
		{
			var index:Int = this.map.get(key);
			this.keys.splice(index, 1);
			this.values.splice(index, 1);
			this.map.remove(key);
			var count:Int = this.keys.length;
			for (i in index...count)
			{
				this.map.set(keys[i], i);
			}
		}
	}
	
	public function exists(key:String):Bool
	{
		return this.map.exists(key);
	}
	
	public function iterator():Iterator<V>
	{
		return this.values.iterator();
	}
	
	public function keysIterator():Iterator<String>
	{
		return this.keys.iterator();
	}
	
	public function valuesIterator():Iterator<V>
	{
		return this.values.iterator();
	}
	
	public function getKeys():Array<String>
	{
		return this.keys.copy();
	}
	
	public function getValues():Array<V>
	{
		return this.values.copy();
	}
}