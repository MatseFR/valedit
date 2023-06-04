package valedit.asset;
#if valeditor
import feathers.data.ArrayCollection;
#end
import feathers.utils.ScaleUtil;
import haxe.ds.ObjectMap;
import haxe.io.Path;
import openfl.Vector;
import openfl.display.BitmapData;
import openfl.errors.Error;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import openfl.media.Sound;
import openfl.utils.AssetType;
import openfl.utils.Assets;
import openfl.utils.ByteArray;
import starling.textures.SubTexture;
import starling.textures.TextureAtlas;
import valeditor.ui.UIConfig;
#if starling
import starling.textures.Texture;
#end
import valedit.asset.starling.StarlingAtlasAsset;
import valedit.asset.starling.StarlingTextureAsset;

/**
 * ...
 * @author Matse
 */
class AssetLib 
{
	static public var generatePreviews(get, never):Bool;
	static private var _generatePreview:Bool;
	static private function get_generatePreviews():Bool { return _generatePreview; }
	
	// BINARIES
	#if valeditor
	static private var _binaryCollection:ArrayCollection<BinaryAsset>;
	#end
	static private var _binaryList:Array<BinaryAsset> = new Array<BinaryAsset>();
	static private var _binaryMap:Map<String, BinaryAsset> = new Map<String, BinaryAsset>();
	static private var _binaryToAsset:ObjectMap<ByteArray, BinaryAsset> = new ObjectMap<ByteArray, BinaryAsset>();
	
	// BITMAPS
	#if valeditor
	static private var _bitmapCollection:ArrayCollection<BitmapAsset>;
	#end
	static private var _bitmapList:Array<BitmapAsset> = new Array<BitmapAsset>();
	static private var _bitmapMap:Map<String, BitmapAsset> = new Map<String, BitmapAsset>();
	static private var _bitmapDataToAsset:ObjectMap<BitmapData, BitmapAsset> = new ObjectMap<BitmapData, BitmapAsset>();
	
	// SOUNDS
	#if valeditor
	static private var _soundCollection:ArrayCollection<SoundAsset>;
	#end
	static private var _soundList:Array<SoundAsset> = new Array<SoundAsset>();
	static private var _soundMap:Map<String, SoundAsset> = new Map<String, SoundAsset>();
	static private var _soundToAsset:ObjectMap<Sound, SoundAsset> = new ObjectMap<Sound, SoundAsset>();
	
	// TEXTS
	#if valeditor
	static private var _textCollection:ArrayCollection<TextAsset>;
	#end
	static private var _textList:Array<TextAsset> = new Array<TextAsset>();
	static private var _textMap:Map<String, TextAsset> = new Map<String, TextAsset>();
	static private var _textToAsset:Map<String, TextAsset> = new Map<String, TextAsset>();
	
	// STARLING TEXTURES
	#if starling
	#if valeditor
	static private var _starlingTextureCollection:ArrayCollection<StarlingTextureAsset>;
	#end
	static private var _starlingTextureList:Array<StarlingTextureAsset> = new Array<StarlingTextureAsset>();
	static private var _starlingTextureMap:Map<String, StarlingTextureAsset> = new Map<String, StarlingTextureAsset>();
	static private var _starlingTextureToAsset:ObjectMap<starling.textures.Texture, StarlingTextureAsset> = new ObjectMap<starling.textures.Texture, StarlingTextureAsset>();
	#end
	
	// STARLING ATLASES
	#if starling
	#if valeditor
	static private var _starlingAtlasCollection:ArrayCollection<StarlingAtlasAsset>;
	#end
	static private var _starlingAtlasList:Array<StarlingAtlasAsset> = new Array<StarlingAtlasAsset>();
	static private var _starlingAtlasMap:Map<String, StarlingAtlasAsset> = new Map<String, StarlingAtlasAsset>();
	static private var _starlingAtlasToAsset:ObjectMap<starling.textures.TextureAtlas, StarlingAtlasAsset> = new ObjectMap<starling.textures.TextureAtlas, StarlingAtlasAsset>();
	static private var _starlingAtlasTextureToAsset:ObjectMap<starling.textures.Texture, StarlingAtlasAsset> = new ObjectMap<starling.textures.Texture, StarlingAtlasAsset>();
	#end
	
	static private var _matrix:Matrix;
	static private var _previewRect:Rectangle;
	static private var _rect:Rectangle;
	
	static private var _loadStack:Array<Void->Void>;
	static private var _loadCompleteCallback:Void->Void;
	
	static public function init(generatePreviews:Bool = true):Void
	{
		_generatePreview = generatePreviews;
		
		if (_generatePreview)
		{
			_matrix = new Matrix();
			_previewRect = new Rectangle(0, 0, UIConfig.ASSET_PREVIEW_SIZE, UIConfig.ASSET_PREVIEW_SIZE);
			_rect = new Rectangle();
		}
		
		#if valeditor
		_binaryCollection = new ArrayCollection<BinaryAsset>();
		_bitmapCollection = new ArrayCollection<BitmapAsset>();
		_soundCollection = new ArrayCollection<SoundAsset>();
		_textCollection = new ArrayCollection<TextAsset>();
		#if starling
		_starlingTextureCollection = new ArrayCollection<StarlingTextureAsset>();
		_starlingAtlasCollection = new ArrayCollection<StarlingAtlasAsset>();
		#end
		#end
		
		initBinaries();
		initBitmaps();
		initMovieClips();
		initSounds();
		initTexts();
	}
	
	static public function load(completeCallback:Void->Void):Void
	{
		_loadCompleteCallback = completeCallback;
		
		_loadStack = [];
		_loadStack.push(loadBinaries);
		_loadStack.push(loadBitmaps);
		_loadStack.push(loadSounds);
		_loadStack.push(loadTexts);
		
		loadNext();
	}
	
	static private function loadNext():Void
	{
		if (_loadStack.length != 0)
		{
			var func:Void->Void = _loadStack.pop();
			func();
		}
		else
		{
			if (_loadCompleteCallback != null)
			{
				_loadCompleteCallback();
			}
		}
	}
	
	//####################################################################################################
	// BINARIES
	//####################################################################################################
	static private function initBinaries():Void
	{
		var asset:BinaryAsset;
		var bytes:ByteArray;
		var strList:Array<String> = Assets.list(AssetType.BINARY);
		//trace("AssetLib initBinaries " + strList);
		for (id in strList)
		{
			asset = new BinaryAsset();
			asset.path = id;
			asset.name = Path.withoutDirectory(id);
			try
			{
				bytes = Assets.getBytes(id);
				asset.content = bytes;
				asset.source = AssetSource.ASSETS_EMBEDDED;
				asset.isLoaded = true;
			}
			catch (e)
			{
				asset.source = AssetSource.ASSETS;
				asset.isLoaded = false;
			}
			addBinary(asset);
		}
	}
	
	static public function addBinary(asset:BinaryAsset):Void
	{
		_binaryList.push(asset);
		_binaryMap[asset.path] = asset;
		#if valeditor
		_binaryCollection.add(asset);
		#end
		if (asset.content != null) _binaryToAsset.set(asset.content, asset);
	}
	
	static public function removeBinary(asset:BinaryAsset):Void
	{
		_binaryList.remove(asset);
		_binaryMap.remove(asset.path);
		#if valeditor
		_binaryCollection.remove(asset);
		#end
		if (asset.content != null) _binaryToAsset.remove(asset.content);
	}
	
	static public function createBinary(path:String, bytes:ByteArray):Void
	{
		var asset:BinaryAsset = new BinaryAsset();
		path = Path.normalize(path);
		asset.path = path;
		asset.name = Path.withoutDirectory(path);
		asset.content = bytes;
		asset.source = AssetSource.EXTERNAL;
		asset.isLoaded = true;
		addBinary(asset);
	}
	
	static public function getBinaryFromByteArray(bytes:ByteArray):BinaryAsset
	{
		return _binaryToAsset.get(bytes);
	}
	
	static public function getBinaryFromPath(path:String):BinaryAsset
	{
		return _binaryMap[path];
	}
	
	static private function loadBinaries():Void
	{
		var idList:Array<String> = new Array<String>();
		for (asset in _binaryList)
		{
			if (!asset.isLoaded && asset.source == AssetSource.ASSETS)
			{
				idList.push(asset.path);
			}
		}
		
		var loader:AssetLoader<ByteArray> = new AssetLoader<ByteArray>(idList, Assets.loadBytes, loadBinariesComplete);
		loader.start();
	}
	
	static private function loadBinariesComplete():Void
	{
		var bytes:ByteArray;
		for (asset in _binaryList)
		{
			if (!asset.isLoaded && asset.source == AssetSource.ASSETS)
			{
				try
				{
					bytes = Assets.getBytes(asset.path);
					asset.content = bytes;
					asset.isLoaded = true;
					_binaryToAsset.set(bytes, asset);
				}
				catch (e)
				{
					// do nothing
				}
			}
		}
		
		loadNext();
	}
	//####################################################################################################
	//\BINARIES
	//####################################################################################################
	
	//####################################################################################################
	// BITMAPS
	//####################################################################################################
	static private function initBitmaps():Void
	{
		var asset:BitmapAsset;
		var bmd:BitmapData;
		var strList:Array<String> = Assets.list(AssetType.IMAGE);
		trace("AssetLib initBitmaps " + strList);
		for (id in strList)
		{
			asset = new BitmapAsset();
			asset.path = id;
			asset.name = Path.withoutDirectory(id);
			try
			{
				bmd = Assets.getBitmapData(id);
				asset.content = bmd;
				asset.source = AssetSource.ASSETS_EMBEDDED;
				if (_generatePreview) makeBitmapPreview(asset);
				asset.isLoaded = true;
			}
			catch (e)
			{
				asset.source = AssetSource.ASSETS;
				asset.isLoaded = false;
			}
			addBitmap(asset);
		}
	}
	
	static public function addBitmap(asset:BitmapAsset):Void
	{
		_bitmapList.push(asset);
		_bitmapMap[asset.path] = asset;
		#if valeditor
		_bitmapCollection.add(asset);
		#end
		if (asset.content != null) _bitmapDataToAsset.set(asset.content, asset);
	}
	
	static public function removeBitmap(asset:BitmapAsset):Void
	{
		_bitmapList.remove(asset);
		_bitmapMap.remove(asset.path);
		#if valeditor
		_bitmapCollection.remove(asset);
		#end
		if (asset.content != null) _bitmapDataToAsset.remove(asset.content);
	}
	
	static public function createBitmap(path:String, bmd:BitmapData):Void
	{
		var asset:BitmapAsset = new BitmapAsset();
		path = Path.normalize(path);
		asset.path = path;
		asset.name = path.substr(path.lastIndexOf("/") + 1);
		asset.content = bmd;
		asset.source = AssetSource.EXTERNAL;
		if (_generatePreview) makeBitmapPreview(asset);
		asset.isLoaded = true;
		addBitmap(asset);
	}
	
	static public function getBitmapFromBitmapData(bmd:BitmapData):BitmapAsset
	{
		return _bitmapDataToAsset.get(bmd);
	}
	
	static public function getBitmapFromPath(path:String):BitmapAsset
	{
		return _bitmapMap[path];
	}
	
	static private function loadBitmaps():Void
	{
		var idList:Array<String> = new Array<String>();
		for (asset in _bitmapList)
		{
			if (!asset.isLoaded && asset.source == AssetSource.ASSETS)
			{
				idList.push(asset.path);
			}
		}
		
		var loader:AssetLoader<BitmapData> = new AssetLoader<BitmapData>(idList, Assets.loadBitmapData, loadBitmapsComplete);
		loader.start();
	}
	
	static private function loadBitmapsComplete():Void
	{
		var bmd:BitmapData;
		for (asset in _bitmapList)
		{
			if (!asset.isLoaded && asset.source == AssetSource.ASSETS)
			{
				try
				{
					bmd = Assets.getBitmapData(asset.path);
					asset.content = bmd;
					if (_generatePreview) makeBitmapPreview(asset);
					asset.isLoaded = true;
					_bitmapDataToAsset.set(bmd, asset);
				}
				catch (e)
				{
					// do nothing
				}
			}
		}
		
		loadNext();
	}
	
	static private function makeBitmapPreview(asset:BitmapAsset):Void
	{
		ScaleUtil.fitRectangle(asset.content.rect, _previewRect, _rect);
		var bmd:BitmapData;
		if (asset.content.transparent)
		{
			bmd = new BitmapData(Math.ceil(_rect.width), Math.ceil(_rect.height), true, 0x00ffffff);
		}
		else
		{
			bmd = new BitmapData(Math.ceil(_rect.width), Math.ceil(_rect.height), false, 0x000000);
		}
		var scale = bmd.width / asset.content.width;
		_matrix.identity();
		_matrix.scale(scale, scale);
		bmd.draw(asset.content, _matrix);
		asset.preview = bmd;
	}
	//####################################################################################################
	//\BITMAPS
	//####################################################################################################
	
	//####################################################################################################
	// MOVIE CLIPS
	//####################################################################################################
	static private function initMovieClips():Void
	{
		var strList:Array<String> = Assets.list(AssetType.MOVIE_CLIP);
	}
	//####################################################################################################
	//\MOVIE CLIPS
	//####################################################################################################
	
	//####################################################################################################
	// SOUNDS
	//####################################################################################################
	static private function initSounds():Void
	{
		var asset:SoundAsset;
		var sound:Sound;
		var strList:Array<String> = Assets.list(AssetType.SOUND);
		trace("AssetLib initSounds " + strList);
		for (id in strList)
		{
			asset = new SoundAsset();
			asset.path = id;
			asset.name = Path.withoutDirectory(id);
			try
			{
				sound = Assets.getSound(id);
				asset.content = sound;
				asset.source = AssetSource.ASSETS_EMBEDDED;
				asset.isLoaded = true;
			}
			catch (e:Error)
			{
				asset.source = AssetSource.ASSETS;
				asset.isLoaded = false;
			}
			addSound(asset);
		}
	}
	
	static public function addSound(asset:SoundAsset):Void
	{
		_soundList.push(asset);
		_soundMap[asset.path] = asset;
		#if valeditor
		_soundCollection.add(asset);
		#end
		if (asset.content != null) _soundToAsset.set(asset.content, asset);
	}
	
	static public function removeSound(asset:SoundAsset):Void
	{
		_soundList.remove(asset);
		_soundMap.remove(asset.path);
		#if valeditor
		_soundCollection.remove(asset);
		#end
		if (asset.content != null) _soundToAsset.remove(asset.content);
	}
	
	static public function createSound(path:String, sound:Sound):Void
	{
		var asset:SoundAsset = new SoundAsset();
		path = Path.normalize(path);
		asset.path = path;
		asset.name = Path.withoutDirectory(path);
		asset.content = sound;
		asset.source = AssetSource.EXTERNAL;
		asset.isLoaded = true;
		addSound(asset);
	}
	
	static public function getSoundFromPath(path:String):SoundAsset
	{
		return _soundMap[path];
	}
	
	static public function getSoundFromSound(sound:Sound):SoundAsset
	{
		return _soundToAsset.get(sound);
	}
	
	static private function loadSounds():Void
	{
		var idList:Array<String> = new Array<String>();
		for (asset in _soundList)
		{
			if (!asset.isLoaded && asset.source == AssetSource.ASSETS)
			{
				idList.push(asset.path);
			}
		}
		
		var loader:AssetLoader<Sound> = new AssetLoader<Sound>(idList, Assets.loadSound, loadSoundsComplete);
		loader.start();
	}
	
	static private function loadSoundsComplete():Void
	{
		var sound:Sound;
		for (asset in _soundList)
		{
			if (!asset.isLoaded && asset.source == AssetSource.ASSETS)
			{
				try
				{
					sound = Assets.getSound(asset.path);
					asset.content = sound;
					asset.isLoaded = true;
					_soundToAsset.set(sound, asset);
				}
				catch (e:Error)
				{
					// do nothing
				}
			}
		}
		
		loadNext();
	}
	//####################################################################################################
	//\SOUNDS
	//####################################################################################################
	
	//####################################################################################################
	// TEXTS
	//####################################################################################################
	static private function initTexts():Void
	{
		var asset:TextAsset;
		var text:String;
		var strList:Array<String> = Assets.list(AssetType.TEXT);
		trace("AssetLib initTexts " + strList);
		for (id in strList)
		{
			asset = new TextAsset();
			asset.path = id;
			asset.name = Path.withoutDirectory(id);
			try
			{
				text = Assets.getText(id);
				asset.content = text;
				asset.source = AssetSource.ASSETS_EMBEDDED;
				asset.isLoaded = true;
			}
			catch (e:Error)
			{
				asset.source = AssetSource.ASSETS;
				asset.isLoaded = false;
			}
		}
	}
	
	static public function addText(asset:TextAsset):Void
	{
		_textList.push(asset);
		_textMap[asset.path] = asset;
		#if valeditor
		_textCollection.add(asset);
		#end
		if (asset.content != null) _textToAsset.set(asset.content, asset);
	}
	
	static public function removeText(asset:TextAsset):Void
	{
		_textList.remove(asset);
		_textMap.remove(asset.path);
		#if valeditor
		_textCollection.remove(asset);
		#end
		if (asset.content != null) _textToAsset.remove(asset.content);
	}
	
	static public function createText(path:String, text:String):Void
	{
		var asset:TextAsset = new TextAsset();
		path = Path.normalize(path);
		asset.path = path;
		asset.name = Path.withoutDirectory(path);
		asset.content = text;
		asset.source = AssetSource.EXTERNAL;
		asset.isLoaded = true;
		addText(asset);
	}
	
	static public function getTextFromPath(path:String):TextAsset
	{
		return _textMap[path];
	}
	
	static public function getTextFromText(text:String):TextAsset
	{
		return _textToAsset[text];
	}
	
	static private function loadTexts():Void
	{
		var idList:Array<String> = new Array<String>();
		for (asset in _textList)
		{
			if (!asset.isLoaded && asset.source == AssetSource.ASSETS)
			{
				idList.push(asset.path);
			}
		}
		
		var loader:AssetLoader<String> = new AssetLoader<String>(idList, Assets.loadText, loadTextsComplete);
		loader.start();
	}
	
	static private function loadTextsComplete():Void
	{
		var text:String;
		for (asset in _textList)
		{
			if (!asset.isLoaded && asset.source == AssetSource.ASSETS)
			{
				try
				{
					text = Assets.getText(asset.path);
					asset.content = text;
					asset.isLoaded = true;
					_textToAsset.set(text, asset);
				}
				catch (e:Error)
				{
					// do nothing
				}
			}
		}
		
		loadNext();
	}
	//####################################################################################################
	//\TEXTS
	//####################################################################################################
	
	//####################################################################################################
	// STARLING TEXTURES
	//####################################################################################################
	#if starling
	static public function addStarlingTexture(asset:StarlingTextureAsset):Void
	{
		_starlingTextureList.push(asset);
		_starlingTextureMap[asset.path] = asset;
		#if valeditor
		_starlingTextureCollection.add(asset);
		#end
		if (asset.content != null) _starlingTextureToAsset.set(asset.content, asset);
	}
	
	static public function removeStarlingTexture(asset:StarlingTextureAsset):Void
	{
		_starlingTextureList.remove(asset);
		_starlingTextureMap.remove(asset.path);
		#if valeditor
		_starlingTextureCollection.remove(asset);
		#end
		if (asset.content != null) _starlingTextureToAsset.remove(asset.content);
	}
	
	static public function createStarlingTexture(path:String, texture:Texture, bitmapAsset:BitmapAsset, ?name:String, ?preview:BitmapData):Void
	{
		var asset:StarlingTextureAsset = new StarlingTextureAsset();
		path = Path.normalize(path);
		asset.path = path;
		if (name == null)
		{
			asset.name = Path.withoutDirectory(path);
		}
		else
		{
			asset.name = name;
		}
		asset.content = texture;
		asset.bitmapAsset = bitmapAsset;
		if (preview == null)
		{
			asset.preview = bitmapAsset.preview;
		}
		else
		{
			asset.preview = preview;
		}
		asset.source = AssetSource.EXTERNAL;
		asset.isLoaded = true;
		addStarlingTexture(asset);
	}
	
	static public function getStarlingTextureAssetFromPath(path:String):StarlingTextureAsset
	{
		return _starlingTextureMap[path];
	}
	
	static public function getStarlingTextureAssetFromTexture(texture:Texture):StarlingTextureAsset
	{
		return _starlingTextureToAsset.get(texture);
	}
	#end
	//####################################################################################################
	//\STARLING TEXTURES
	//####################################################################################################
	
	//####################################################################################################
	// STARLING ATLASES
	//####################################################################################################
	#if starling
	static public function addStarlingAtlas(asset:StarlingAtlasAsset):Void
	{
		_starlingAtlasList.push(asset);
		_starlingAtlasMap[asset.path] = asset;
		#if valeditor
		_starlingAtlasCollection.add(asset);
		#end
		if (asset.content != null) 
		{
			_starlingAtlasToAsset.set(asset.content, asset);
			_starlingAtlasTextureToAsset.set(asset.content.texture, asset);
			
			var names:Vector<String> = asset.content.getNames();
			var name:String;
			var subTexture:SubTexture;
			var preview:BitmapData = null;
			var scale:Float;
			var count:Int = names.length;
			var texWidth:Float;
			var texHeight:Float;
			
			for (i in 0...count)
			{
				name = names[i];
				subTexture = cast asset.content.getTexture(name);
				
				if (subTexture.rotated)
				{
					texWidth = subTexture.height;
					texHeight = subTexture.width;
				}
				else
				{
					texWidth = subTexture.width;
					texHeight = subTexture.height;
				}
				
				scale = ScaleUtil.scaleToFit(texWidth, texHeight, UIConfig.ASSET_PREVIEW_SIZE, UIConfig.ASSET_PREVIEW_SIZE);
				preview = new BitmapData(Math.ceil(texWidth * scale), Math.ceil(texHeight * scale), true, 0x00ffffff);
				
				_rect.setTo(0, 0, texWidth, texHeight);
				_matrix.identity();
				_matrix.translate(-subTexture.region.left, -subTexture.region.top);
				_matrix.scale(scale, scale);
				preview.draw(asset.bitmapAsset.content, _matrix, null, null, _rect);
				
				createStarlingTexture(asset.path + ValEdit.STARLING_SUBTEXTURE_MARKER + name, subTexture, asset.bitmapAsset, name, preview);
			}
		}
	}
	
	static public function removeStarlingAtlas(asset:StarlingAtlasAsset):Void
	{
		_starlingAtlasList.remove(asset);
		_starlingAtlasMap.remove(asset.path);
		#if valeditor
		_starlingAtlasCollection.remove(asset);
		#end
		if (asset.content != null)
		{
			_starlingAtlasToAsset.remove(asset.content);
			_starlingAtlasTextureToAsset.remove(asset.content.texture);
			
			var names:Vector<String> = asset.content.getNames();
			var name:String;
			var texture:Texture;
			var textureAsset:StarlingTextureAsset;
			var count:Int = names.length;
			for (i in 0...count)
			{
				name = names[i];
				texture = asset.content.getTexture(name);
				textureAsset = getStarlingTextureAssetFromTexture(texture);
				if (textureAsset != null) removeStarlingTexture(textureAsset);
			}
		}
	}
	
	static public function createStarlingAtlas(path:String, atlas:TextureAtlas, bitmapAsset:BitmapAsset, textAsset:TextAsset):Void
	{
		var asset:StarlingAtlasAsset = new StarlingAtlasAsset();
		path = Path.normalize(path);
		asset.path = path;
		asset.name = Path.withoutDirectory(path);
		asset.content = atlas;
		asset.preview = bitmapAsset.preview;
		asset.bitmapAsset = bitmapAsset;
		asset.textAsset = textAsset;
		asset.source = AssetSource.EXTERNAL;
		asset.isLoaded = true;
		addStarlingAtlas(asset);
	}
	
	static public function getStarlingAtlasAssetFromAtlas(atlas:TextureAtlas):StarlingAtlasAsset
	{
		return _starlingAtlasToAsset.get(atlas);
	}
	
	static public function getStarlingAtlasAssetFromPath(path:String):StarlingAtlasAsset
	{
		return _starlingAtlasMap[path];
	}
	
	static public function getStarlingAtlasAssetFromTexture(texture:Texture):StarlingAtlasAsset
	{
		return _starlingAtlasTextureToAsset.get(texture);
	}
	#end
	//####################################################################################################
	//\STARLING ATLASES
	//####################################################################################################
	
}