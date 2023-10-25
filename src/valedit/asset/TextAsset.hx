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
	public var content:String;
	
	public function new() 
	{
		super();
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