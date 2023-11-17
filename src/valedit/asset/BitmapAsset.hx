package valedit.asset;
import haxe.crypto.Crc32;
import haxe.io.Bytes;
import haxe.zip.Entry;
import openfl.display.BitmapData;

/**
 * ...
 * @author Matse
 */
class BitmapAsset extends Asset 
{
	static private var _POOL:Array<BitmapAsset> = new Array<BitmapAsset>();
	
	static public function fromPool():BitmapAsset
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new BitmapAsset();
	}
	
	public var content:BitmapData;
	public var data:Bytes;
	public var preview:BitmapData;
	
	public function new() 
	{
		super();
	}
	
	override public function clear():Void 
	{
		for (value in this._registeredValues)
		{
			value.value = ValEdit.assetLib.defaultBitmapAsset;
		}
		this._registeredValues.resize(0);
		
		this.content = null;
		this.data = null;
		this.preview = null;
		
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