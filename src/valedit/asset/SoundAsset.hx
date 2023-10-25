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
	public var content:Sound;
	public var data:ByteArray;
	
	public function new() 
	{
		super();
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