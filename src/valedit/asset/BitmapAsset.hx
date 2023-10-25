package valedit.asset;
import haxe.crypto.Crc32;
import haxe.io.Bytes;
import haxe.zip.Entry;
import openfl.display.BitmapData;
import openfl.utils.ByteArray;

/**
 * ...
 * @author Matse
 */
class BitmapAsset extends Asset 
{
	public var content:BitmapData;
	public var data:ByteArray;
	public var preview:BitmapData;
	
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