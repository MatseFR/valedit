package valedit.asset.starling;
import haxe.zip.Entry;
import openfl.display.BitmapData;
import openfl.errors.Error;
import starling.textures.Texture;
import valedit.asset.Asset;
import valedit.asset.BitmapAsset;
import valeditor.utils.starling.TextureCreationParameters;

/**
 * ...
 * @author Matse
 */
class StarlingTextureAsset extends Asset 
{
	static private var _POOL:Array<StarlingTextureAsset> = new Array<StarlingTextureAsset>();
	
	static public function fromPool():StarlingTextureAsset
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new StarlingTextureAsset();
	}
	
	public var atlasAsset(get, set):StarlingAtlasAsset;
	public var bitmapAsset(get, set):BitmapAsset;
	public var content:Texture;
	public var isFromAtlas(default, null):Bool;
	public var preview:BitmapData;
	public var textureParams:TextureCreationParameters;
	
	private var _atlasAsset:StarlingAtlasAsset;
	private function get_atlasAsset():StarlingAtlasAsset { return this._atlasAsset; }
	private function set_atlasAsset(value:StarlingAtlasAsset):StarlingAtlasAsset
	{
		if (this._atlasAsset == value) return value;
		
		this.isFromAtlas = value != null;
		return this._atlasAsset = value;
	}
	
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
	
	public function new() 
	{
		super();
	}
	
	override public function clear():Void 
	{
		this.atlasAsset = null;
		this.bitmapAsset = null;
		this.content = null;
		this.preview = null;
		if (this.textureParams != null)
		{
			this.textureParams.pool();
			this.textureParams = null;
		}
		
		for (value in this._registeredValues)
		{
			value.value = ValEdit.assetLib.defaultStarlingTextureAsset;
		}
		this._registeredValues.resize(0);
		
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
		
		this.bitmapAsset = cast asset;
		
		ValEdit.assetLib.updateStarlingTexture(this, this._bitmapAsset, null, null, this.textureParams);
	}
	
	override public function toJSONSave(json:Dynamic = null):Dynamic 
	{
		json = super.toJSONSave(json);
		json.bitmapPath = this.bitmapAsset.path;
		json.textureParams = this.textureParams.toJSON();
		
		return json;
	}
	
	public function toZIPEntry():Entry
	{
		throw new Error("no ZIP entry for starling_texture assets");
	}
	
}