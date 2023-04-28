package valedit.asset;

/**
 * ...
 * @author Matse
 */
class AssetType 
{
	static public inline var BINARY:String = "binary";
	static public inline var BITMAP:String = "bitmap";
	static public inline var SOUND:String = "sound";
	static public inline var TEXT:String = "text";
	#if starling
	static public inline var STARLING_ATLAS:String = "starling_atlas";
	static public inline var STARLING_TEXTURE:String = "starling_texture";
	#end
}