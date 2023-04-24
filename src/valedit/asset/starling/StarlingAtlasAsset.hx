package valedit.asset.starling;

import starling.textures.TextureAtlas;
import valedit.asset.Asset;
import valedit.asset.BitmapAsset;
import valedit.asset.TextAsset;

/**
 * ...
 * @author Matse
 */
class StarlingAtlasAsset extends Asset 
{
	public var bitmapAsset:BitmapAsset;
	public var textAsset:TextAsset;
	public var content:TextureAtlas;

	public function new() 
	{
		super();
	}
	
}