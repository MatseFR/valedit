package valedit.asset.starling;

import haxe.zip.Entry;
import openfl.display.BitmapData;
import openfl.errors.Error;
import starling.textures.TextureAtlas;
import valedit.asset.Asset;
import valedit.asset.BitmapAsset;
import valedit.asset.TextAsset;
import valeditor.utils.starling.TextureCreationParameters;

/**
 * ...
 * @author Matse
 */
class StarlingAtlasAsset extends Asset 
{
	static private var _POOL:Array<StarlingAtlasAsset> = new Array<StarlingAtlasAsset>();
	
	static public function fromPool():StarlingAtlasAsset
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new StarlingAtlasAsset();
	}
	
	public var bitmapAsset(get, set):BitmapAsset;
	public var textAsset(get, set):TextAsset;
	public var content:TextureAtlas;
	public var preview:BitmapData;
	public var textureParams:TextureCreationParameters;
	
	private var _bitmapAsset:BitmapAsset;
	private function get_bitmapAsset():BitmapAsset { return this._bitmapAsset; }
	private function set_bitmapAsset(value:BitmapAsset):BitmapAsset
	{
		if (this._bitmapAsset == value) return value;
		
		if (this._bitmapAsset != null)
		{
			this._bitmapAsset.unregisterAsset(this);
		}
		if (value != null)
		{
			value.registerAsset(this);
		}
		return this._bitmapAsset = value;
	}
	
	private var _textAsset:TextAsset;
	private function get_textAsset():TextAsset { return this._textAsset; }
	private function set_textAsset(value:TextAsset):TextAsset
	{
		if (this._textAsset == value) return value;
		
		if (this._textAsset != null)
		{
			this._textAsset.unregisterAsset(this);
		}
		if (value != null)
		{
			value.registerAsset(this);
		}
		return this._textAsset = value;
	}

	public function new() 
	{
		super();
	}
	
	override public function clear():Void 
	{
		this.bitmapAsset = null;
		this.textAsset = null;
		this.content = null;
		this.preview = null;
		this.textureParams.pool();
		this.textureParams = null;
		
		super.clear();
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	override public function assetUpdate(asset:Asset):Void 
	{
		super.assetUpdate(asset);
		
		if (Std.isOfType(asset, BitmapAsset))
		{
			this.bitmapAsset = cast asset;
		}
		else
		{
			this.textAsset = cast asset;
		}
		
		ValEdit.assetLib.updateStarlingAtlas(this);
	}
	
	override public function toJSONSave(json:Dynamic = null):Dynamic 
	{
		json = super.toJSONSave(json);
		json.bitmapPath = this._bitmapAsset.path;
		json.textPath = this._textAsset.path;
		json.textureParams = this.textureParams.toJSON();
		
		return json;
	}
	
	public function toZIPEntry():Entry
	{
		throw new Error("no ZIP entry for starling_atlas assets");
	}
	
}