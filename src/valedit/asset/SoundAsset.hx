package valedit.asset;
import haxe.crypto.Crc32;
import haxe.io.Bytes;
import haxe.zip.Entry;
import openfl.media.Sound;
import openfl.utils.ByteArray;

/**
 * ...
 * @author Matse
 */
class SoundAsset extends Asset 
{
	static private var _POOL:Array<SoundAsset> = new Array<SoundAsset>();
	
	static public function fromPool():SoundAsset
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new SoundAsset();
	}
	
	public var content:Sound;
	public var data:ByteArray;
	
	public function new() 
	{
		super();
	}
	
	override public function clear():Void 
	{
		this.content = null;
		this.data = null;
		super.clear();
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	public function toZIPEntry():Entry
	{
		var bytes:Bytes = this.data;
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