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
	public var bitmapAsset(get, set):BitmapAsset;
	public var content:Texture;
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
	
	public function new() 
	{
		super();
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