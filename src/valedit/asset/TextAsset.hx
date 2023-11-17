package valedit.asset;
import haxe.crypto.Crc32;
import haxe.io.Bytes;
import haxe.zip.Entry;

/**
 * ...
 * @author Matse
 */
class TextAsset extends Asset 
{
	static private var _POOL:Array<TextAsset> = new Array<TextAsset>();
	
	static public function fromPool():TextAsset
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new TextAsset();
	}
	
	public var content:String;
	
	public function new() 
	{
		super();
	}
	
	override public function clear():Void 
	{
		this.content = null;
		super.clear();
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	public function toZIPEntry():Entry
	{
		var bytes:Bytes = Bytes.ofString(this.content);
		return {
			fileName:this.path,
			fileSize:bytes.length,
			fileTime:Date.now(),
			compressed:false,
			dataSize:bytes.length,
			data:bytes,
			crc32:Crc32.make(bytes)
		};
	}
	
}