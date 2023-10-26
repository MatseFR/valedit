package valedit.asset.starling;
import haxe.zip.Entry;
import openfl.display.BitmapData;
import openfl.errors.Error;
import starling.textures.Texture;
import valeditor.utils.starling.TextureCreationParameters;

/**
 * ...
 * @author Matse
 */
class StarlingTextureAsset extends Asset 
{
	public var bitmapAsset:BitmapAsset;
	public var content:Texture;
	public var preview:BitmapData;
	public var textureParams:TextureCreationParameters;
	
	public function new() 
	{
		super();
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