package valedit.utils;
import haxe.zip.Entry;
import haxe.zip.Tools;
import openfl.utils.ByteArray;
import openfl.utils.CompressionAlgorithm;

/**
 * ...
 * @author Matse
 */
class ZipUtil 
{

	inline static public function compressEntry(entry:Entry):Void
	{
		#if air
		var ba:ByteArray = ByteArray.fromBytes(entry.data);
		ba.compress(CompressionAlgorithm.DEFLATE);
		entry.data = ba;
		entry.dataSize = ba.length;
		entry.compressed = true;
		#else
		Tools.compress(entry, 0);
		#end
	}
	
	inline static public function uncompressEntry(entry:Entry):Void
	{
		#if air
		var ba:ByteArray = ByteArray.fromBytes(entry.data);
		ba.uncompress(CompressionAlgorithm.DEFLATE);
		entry.data = ba;
		entry.dataSize = ba.length;
		entry.compressed = false;
		#else
		Tools.uncompress(entry);
		#end
	}
	
}