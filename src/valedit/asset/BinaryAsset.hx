package valedit.asset;
import haxe.crypto.Crc32;
import haxe.io.Bytes;
import haxe.zip.Entry;
import openfl.utils.ByteArray;

/**
 * ...
 * @author Matse
 */
class BinaryAsset extends Asset 
{
	static private var _POOL:Array<BinaryAsset> = new Array<BinaryAsset>();
	
	static public function fromPool():BinaryAsset
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new BinaryAsset();
	}
	
	public var content:ByteArray;
	
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
		var bytes:Bytes = this.content;
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