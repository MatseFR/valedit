package valedit.asset;

import haxe.ds.ObjectMap;
import haxe.io.Bytes;
import haxe.io.Path;
import openfl.display.BitmapData;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import openfl.media.Sound;
import openfl.utils.AssetType;
import openfl.utils.Assets;
import openfl.utils.ByteArray;

#if starling
import openfl.Vector;
import starling.textures.SubTexture;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import valedit.asset.starling.StarlingAtlasAsset;
import valedit.asset.starling.StarlingTextureAsset;
import valeditor.utils.starling.TextureCreationParameters;
#end

#if valeditor
import feathers.data.ArrayCollection;
import feathers.utils.ScaleUtil;
import valeditor.ui.UIConfig;
#end

/**
 * ...
 * @author Matse
 */
class AssetLib 
{
	public var generatePreviews(get, never):Bool;
	
	private var _generatePreview:Bool;
	private function get_generatePreviews():Bool { return this._generatePreview; }
	
	private var _excludedPaths:Map<String, String> = new Map<String, String>();
	private var _registeredExtensions:Map<String, String> = new Map<String, String>();
	
	// BINARIES
	#if valeditor
	public var binaryCollection(default, null):ArrayCollection<BinaryAsset>;
	#end
	public var binaryList(default, null):Array<BinaryAsset> = new Array<BinaryAsset>();
	private var _binaryMap:Map<String, BinaryAsset> = new Map<String, BinaryAsset>();
	private var _binaryToAsset:ObjectMap<ByteArray, BinaryAsset> = new ObjectMap<ByteArray, BinaryAsset>();
	
	// BITMAPS
	#if valeditor
	public var defaultBitmapAsset(default, null):BitmapAsset;
	public var bitmapCollection(default, null):ArrayCollection<BitmapAsset>;
	#end
	public var bitmapList(default, null):Array<BitmapAsset> = new Array<BitmapAsset>();
	private var _bitmapMap:Map<String, BitmapAsset> = new Map<String, BitmapAsset>();
	private var _bitmapDataToAsset:ObjectMap<BitmapData, BitmapAsset> = new ObjectMap<BitmapData, BitmapAsset>();
	
	// SOUNDS
	#if valeditor
	public var soundCollection(default, null):ArrayCollection<SoundAsset>;
	#end
	public var soundList(default, null):Array<SoundAsset> = new Array<SoundAsset>();
	private var _soundMap:Map<String, SoundAsset> = new Map<String, SoundAsset>();
	private var _soundToAsset:ObjectMap<Sound, SoundAsset> = new ObjectMap<Sound, SoundAsset>();
	
	// TEXTS
	#if valeditor
	public var textCollection(default, null):ArrayCollection<TextAsset>;
	#end
	public var textList(default, null):Array<TextAsset> = new Array<TextAsset>();
	private var _textMap:Map<String, TextAsset> = new Map<String, TextAsset>();
	private var _textToAsset:Map<String, TextAsset> = new Map<String, TextAsset>();
	
	// STARLING TEXTURES
	#if starling
	#if valeditor
	public var defaultStarlingTextureAsset(default, null):StarlingTextureAsset;
	public var starlingTextureCollection(default, null):ArrayCollection<StarlingTextureAsset>;
	#end
	public var starlingTextureList(default, null):Array<StarlingTextureAsset> = new Array<StarlingTextureAsset>();
	private var _starlingTextureMap:Map<String, StarlingTextureAsset> = new Map<String, StarlingTextureAsset>();
	private var _starlingTextureToAsset:ObjectMap<starling.textures.Texture, StarlingTextureAsset> = new ObjectMap<starling.textures.Texture, StarlingTextureAsset>();
	#end
	
	// STARLING ATLASES
	#if starling
	#if valeditor
	public var starlingAtlasCollection(default, null):ArrayCollection<StarlingAtlasAsset>;
	#end
	public var starlingAtlasList(default, null):Array<StarlingAtlasAsset> = new Array<StarlingAtlasAsset>();
	private var _starlingAtlasMap:Map<String, StarlingAtlasAsset> = new Map<String, StarlingAtlasAsset>();
	private var _starlingAtlasToAsset:ObjectMap<starling.textures.TextureAtlas, StarlingAtlasAsset> = new ObjectMap<starling.textures.TextureAtlas, StarlingAtlasAsset>();
	private var _starlingAtlasTextureToAsset:ObjectMap<starling.textures.Texture, StarlingAtlasAsset> = new ObjectMap<starling.textures.Texture, StarlingAtlasAsset>();
	#end
	
	private var _matrix:Matrix;
	private var _previewRect:Rectangle;
	private var _rect:Rectangle;
	
	private var _loadStack:Array<Void->Void>;
	private var _loadCompleteCallback:Void->Void;
	
	private var _debug:Bool = true;
	
	public function new() 
	{
		
	}
	
	/** generatePreview has no effect unless valeditor library is available */
	public function init(generatePreviews:Bool = true):Void
	{
		#if valeditor
		this._generatePreview = generatePreviews;
		
		if (this._generatePreview)
		{
			this._matrix = new Matrix();
			this._previewRect = new Rectangle(0, 0, UIConfig.ASSET_PREVIEW_WIDTH, UIConfig.ASSET_PREVIEW_HEIGHT);
			this._rect = new Rectangle();
		}
		#else
		this._generatePreview = false;
		#end
		
		#if valeditor
		this.binaryCollection = new ArrayCollection<BinaryAsset>();
		this.bitmapCollection = new ArrayCollection<BitmapAsset>();
		this.soundCollection = new ArrayCollection<SoundAsset>();
		this.textCollection = new ArrayCollection<TextAsset>();
		
		var size:Int = 32;
		var bmd:BitmapData = new BitmapData(size, size, false);
		var rect:Rectangle = new Rectangle(0, 0, size / 2, size / 2);
		bmd.fillRect(rect, 0xff0000);
		rect.x = size / 2;
		bmd.fillRect(rect, 0xffffff);
		rect.y = size / 2;
		bmd.fillRect(rect, 0xff0000);
		rect.x = 0;
		bmd.fillRect(rect, 0xffffff);
		this.defaultBitmapAsset = new BitmapAsset();
		this.defaultBitmapAsset.name = "none";
		this.defaultBitmapAsset.content = bmd;
		if (this._generatePreview)
		{
			makeBitmapPreview(this.defaultBitmapAsset);
		}
		
		#if starling
		var texture:Texture;
		texture = Texture.fromBitmapData(bmd, false);// , false, 1, Context3DTextureFormat
		this.defaultStarlingTextureAsset = new StarlingTextureAsset();
		this.defaultStarlingTextureAsset.name = "none";
		this.defaultStarlingTextureAsset.content = texture;
		this.defaultStarlingTextureAsset.preview = this.defaultBitmapAsset.preview;
		
		this.starlingTextureCollection = new ArrayCollection<StarlingTextureAsset>();
		this.starlingAtlasCollection = new ArrayCollection<StarlingAtlasAsset>();
		#end
		#end
		
		initBinaries();
		initBitmaps();
		initMovieClips();
		initSounds();
		initTexts();
	}
	
	public function reset():Void
	{
		resetBinaries();
		resetBitmaps();
		resetSounds();
		resetTexts();
		#if starling
		resetStarlingAtlases();
		resetStarlingTextures();
		#end
	}
	
	public function load(completeCallback:Void->Void):Void
	{
		this._loadCompleteCallback = completeCallback;
		
		this._loadStack = [];
		this._loadStack.push(loadBinaries);
		this._loadStack.push(loadBitmaps);
		this._loadStack.push(loadSounds);
		this._loadStack.push(loadTexts);
		
		loadNext();
	}
	
	private function loadNext():Void
	{
		if (this._loadStack.length != 0)
		{
			var func:Void->Void = this._loadStack.pop();
			func();
		}
		else
		{
			if (this._loadCompleteCallback != null)
			{
				this._loadCompleteCallback();
			}
		}
	}
	
	public function excludePath(path:String):Void
	{
		this._excludedPaths.set(path, path);
	}
	
	public function isValidExtension(fileExtension:String):Bool
	{
		return this._registeredExtensions.exists(fileExtension);
	}
	
	public function getAssetTypeForExtension(fileExtension:String):String
	{
		return this._registeredExtensions.get(fileExtension);
	}
	
	/**
	   
	   @param	fileExtension	should be lowercase, AssetLib will automatically register the uppercase version of the extension
	   @param	assetType
	**/
	public function registerExtension(fileExtension:String, assetType:String):Void
	{
		this._registeredExtensions.set(fileExtension, assetType);
		this._registeredExtensions.set(fileExtension.toUpperCase(), assetType);
	}
	
	/**
	   
	   @param	fileExtension	should be lowercase, AssetLib will automatically unregister the uppercase version of the extension
	**/
	public function unregisterExtension(fileExtension:String):Void
	{
		this._registeredExtensions.remove(fileExtension);
		this._registeredExtensions.remove(fileExtension.toUpperCase());
	}
	
	//####################################################################################################
	// BINARIES
	//####################################################################################################
	private function initBinaries():Void
	{
		var asset:BinaryAsset;
		var bytes:ByteArray;
		var strList:Array<String> = Assets.list(AssetType.BINARY);
		//trace("AssetLib initBinaries " + strList);
		for (id in strList)
		{
			if (this._excludedPaths.exists(Path.directory(id)))
			{
				continue;
			}
			
			asset = BinaryAsset.fromPool();
			asset.path = id;
			asset.name = Path.withoutDirectory(id);
			try
			{
				if (this._debug) trace("try " + id);
				bytes = Assets.getBytes(id);
				asset.content = bytes;
				asset.source = AssetSource.ASSETS_EMBEDDED;
				asset.isLoaded = true;
			}
			catch (e)
			{
				if (this._debug) trace("catch " + id);
				asset.source = AssetSource.ASSETS;
				asset.isLoaded = false;
			}
			addBinary(asset);
		}
	}
	
	private function resetBinaries():Void
	{
		var assetsToRemove:Array<BinaryAsset> = [];
		for (asset in this.binaryList)
		{
			if (asset.source == AssetSource.EXTERNAL)
			{
				assetsToRemove.push(asset);
			}
		}
		
		for (asset in assetsToRemove)
		{
			removeBinary(asset);
		}
	}
	
	public function addBinary(asset:BinaryAsset):Void
	{
		this.binaryList.push(asset);
		this._binaryMap[asset.path] = asset;
		#if valeditor
		this.binaryCollection.add(asset);
		#end
		if (asset.content != null) this._binaryToAsset.set(asset.content, asset);
	}
	
	public function removeBinary(asset:BinaryAsset):Void
	{
		this.binaryList.remove(asset);
		this._binaryMap.remove(asset.path);
		#if valeditor
		this.binaryCollection.remove(asset);
		#end
		if (asset.content != null) this._binaryToAsset.remove(asset.content);
		
		asset.pool();
	}
	
	public function createBinary(path:String, bytes:ByteArray):Void
	{
		var asset:BinaryAsset = BinaryAsset.fromPool();
		path = Path.normalize(path);
		asset.path = path;
		asset.name = Path.withoutDirectory(path);
		asset.content = bytes;
		asset.source = AssetSource.EXTERNAL;
		asset.isLoaded = true;
		addBinary(asset);
	}
	
	public function getBinaryFromByteArray(bytes:ByteArray):BinaryAsset
	{
		return this._binaryToAsset.get(bytes);
	}
	
	public function getBinaryFromPath(path:String):BinaryAsset
	{
		return this._binaryMap[path];
	}
	
	private function loadBinaries():Void
	{
		var idList:Array<String> = new Array<String>();
		for (asset in this.binaryList)
		{
			if (!asset.isLoaded && asset.source == AssetSource.ASSETS)
			{
				idList.push(asset.path);
			}
		}
		
		var loader:AssetLoader<ByteArray> = new AssetLoader<ByteArray>(idList, Assets.loadBytes, loadBinariesComplete);
		loader.start();
	}
	
	private function loadBinariesComplete():Void
	{
		var bytes:ByteArray;
		for (asset in this.binaryList)
		{
			if (!asset.isLoaded && asset.source == AssetSource.ASSETS)
			{
				try
				{
					bytes = Assets.getBytes(asset.path);
					asset.content = bytes;
					asset.isLoaded = true;
					this._binaryToAsset.set(bytes, asset);
				}
				catch (e)
				{
					// do nothing
				}
			}
		}
		
		loadNext();
	}
	
	public function updateBinary(asset:BinaryAsset, path:String, data:ByteArray):Void
	{
		this._binaryMap.remove(asset.path);
		if (asset.content != null)
		{
			this._binaryToAsset.remove(asset.content);
			asset.content = null;
		}
		
		path = Path.normalize(path);
		asset.name = path.substr(path.lastIndexOf("/") + 1);
		asset.content = data;
		if (asset.content != null) this._binaryToAsset.set(asset.content, asset);
		this._binaryMap.set(asset.path, asset);
		
		#if valeditor
		updateBinaryItem(asset);
		#end
		
		asset.update();
	}
	
	#if valeditor
	public function updateBinaryItem(asset:BinaryAsset):Void
	{
		this.binaryCollection.updateAt(this.binaryCollection.indexOf(asset));
	}
	#end
	//####################################################################################################
	//\BINARIES
	//####################################################################################################
	
	//####################################################################################################
	// BITMAPS
	//####################################################################################################
	private function initBitmaps():Void
	{
		var asset:BitmapAsset;
		var bmd:BitmapData;
		var strList:Array<String> = Assets.list(AssetType.IMAGE);
		if (_debug) trace("AssetLib initBitmaps " + strList);
		for (id in strList)
		{
			if (this._excludedPaths.exists(Path.directory(id)))
			{
				continue;
			}
			
			asset = BitmapAsset.fromPool();
			asset.path = id;
			asset.name = Path.withoutDirectory(id);
			try
			{
				if (this._debug) trace("try " + id);
				bmd = Assets.getBitmapData(id);
				asset.content = bmd;
				asset.source = AssetSource.ASSETS_EMBEDDED;
				if (this._generatePreview) makeBitmapPreview(asset);
				asset.isLoaded = true;
			}
			catch (e)
			{
				if (this._debug) trace("catch " + id);
				asset.source = AssetSource.ASSETS;
				asset.isLoaded = false;
			}
			addBitmap(asset);
		}
	}
	
	private function resetBitmaps():Void
	{
		var assetsToRemove:Array<BitmapAsset> = [];
		for (asset in this.bitmapList)
		{
			if (asset.source == AssetSource.EXTERNAL)
			{
				assetsToRemove.push(asset);
			}
		}
		
		for (asset in assetsToRemove)
		{
			removeBitmap(asset);
		}
	}
	
	public function addBitmap(asset:BitmapAsset):Void
	{
		this.bitmapList.push(asset);
		this._bitmapMap[asset.path] = asset;
		#if valeditor
		this.bitmapCollection.add(asset);
		#end
		if (asset.content != null) this._bitmapDataToAsset.set(asset.content, asset);
	}
	
	public function removeBitmap(asset:BitmapAsset):Void
	{
		this.bitmapList.remove(asset);
		this._bitmapMap.remove(asset.path);
		#if valeditor
		this.bitmapCollection.remove(asset);
		#end
		if (asset.content != null)
		{
			this._bitmapDataToAsset.remove(asset.content);
			asset.content.dispose();
			asset.content = null;
		}
		if (asset.preview != null)
		{
			asset.preview.dispose();
			asset.preview = null;
		}
		
		asset.pool();
	}
	
	public function createBitmap(path:String, bmd:BitmapData, data:Bytes):Void
	{
		var asset:BitmapAsset = BitmapAsset.fromPool();
		path = Path.normalize(path);
		asset.path = path;
		asset.name = path.substr(path.lastIndexOf("/") + 1);
		asset.content = bmd;
		asset.source = AssetSource.EXTERNAL;
		asset.data = data;
		if (this._generatePreview) makeBitmapPreview(asset);
		asset.isLoaded = true;
		addBitmap(asset);
	}
	
	public function getBitmapFromBitmapData(bmd:BitmapData):BitmapAsset
	{
		if (bmd == this.defaultBitmapAsset.content) return this.defaultBitmapAsset;
		return this._bitmapDataToAsset.get(bmd);
	}
	
	public function getBitmapFromPath(path:String):BitmapAsset
	{
		return this._bitmapMap[path];
	}
	
	private function loadBitmaps():Void
	{
		var idList:Array<String> = new Array<String>();
		for (asset in this.bitmapList)
		{
			if (!asset.isLoaded && asset.source == AssetSource.ASSETS)
			{
				idList.push(asset.path);
			}
		}
		
		var loader:AssetLoader<BitmapData> = new AssetLoader<BitmapData>(idList, Assets.loadBitmapData, loadBitmapsComplete);
		loader.start();
	}
	
	private function loadBitmapsComplete():Void
	{
		var bmd:BitmapData;
		for (asset in bitmapList)
		{
			if (!asset.isLoaded && asset.source == AssetSource.ASSETS)
			{
				try
				{
					bmd = Assets.getBitmapData(asset.path);
					asset.content = bmd;
					if (this._generatePreview) makeBitmapPreview(asset);
					asset.isLoaded = true;
					this._bitmapDataToAsset.set(bmd, asset);
				}
				catch (e)
				{
					// do nothing
				}
			}
		}
		
		loadNext();
	}
	
	private function makeBitmapPreview(asset:BitmapAsset):Void
	{
		if (asset.content.width > this._previewRect.width || asset.content.height > this._previewRect.height)
		{
			ScaleUtil.fitRectangle(asset.content.rect, this._previewRect, this._rect);
		}
		else
		{
			this._rect.copyFrom(asset.content.rect);
			this._rect.x += (this._previewRect.width - this._rect.width) / 2;
			this._rect.y += (this._previewRect.height - this._rect.height) / 2;
		}
		
		var bmd:BitmapData;
		if (asset.content.transparent)
		{
			bmd = new BitmapData(Math.ceil(this._rect.width), Math.ceil(this._rect.height), true, 0x00ffffff);
		}
		else
		{
			bmd = new BitmapData(Math.ceil(this._rect.width), Math.ceil(this._rect.height), false, 0x000000);
		}
		var scale = bmd.width / asset.content.width;
		this._matrix.identity();
		this._matrix.scale(scale, scale);
		bmd.draw(asset.content, this._matrix, null, null, null, true);
		asset.preview = bmd;
	}
	
	public function updateBitmap(asset:BitmapAsset, path:String, bmd:BitmapData, data:Bytes):Void
	{
		this._bitmapMap.remove(asset.path);
		
		if (asset.content != null)
		{
			this._bitmapDataToAsset.remove(asset.content);
			asset.content.dispose();
			asset.content = null;
		}
		if (asset.preview != null)
		{
			asset.preview.dispose();
			asset.preview = null;
		}
		
		path = Path.normalize(path);
		asset.path = path;
		asset.name = path.substr(path.lastIndexOf("/") + 1);
		asset.content = bmd;
		asset.data = data;
		if (asset.content != null) this._bitmapDataToAsset.set(asset.content, asset);
		if (this._generatePreview) makeBitmapPreview(asset);
		this._bitmapMap.set(asset.path, asset);
		
		#if valeditor
		updateBitmapItem(asset);
		#end
		
		asset.update();
	}
	
	#if valeditor
	public function updateBitmapItem(asset:BitmapAsset):Void
	{
		this.bitmapCollection.updateAt(this.bitmapCollection.indexOf(asset));
	}
	#end
	//####################################################################################################
	//\BITMAPS
	//####################################################################################################
	
	//####################################################################################################
	// MOVIE CLIPS
	//####################################################################################################
	private function initMovieClips():Void
	{
		var strList:Array<String> = Assets.list(AssetType.MOVIE_CLIP);
	}
	//####################################################################################################
	//\MOVIE CLIPS
	//####################################################################################################
	
	//####################################################################################################
	// SOUNDS
	//####################################################################################################
	private function initSounds():Void
	{
		var asset:SoundAsset;
		var sound:Sound;
		var strList:Array<String> = Assets.list(AssetType.SOUND);
		if (_debug) trace("AssetLib initSounds " + strList);
		for (id in strList)
		{
			if (this._excludedPaths.exists(Path.directory(id)))
			{
				continue;
			}
			
			asset = SoundAsset.fromPool();
			asset.path = id;
			asset.name = Path.withoutDirectory(id);
			try
			{
				sound = Assets.getSound(id);
				asset.content = sound;
				asset.source = AssetSource.ASSETS_EMBEDDED;
				asset.isLoaded = true;
			}
			catch (e)
			{
				asset.source = AssetSource.ASSETS;
				asset.isLoaded = false;
			}
			addSound(asset);
		}
	}
	
	private function resetSounds():Void
	{
		var assetsToRemove:Array<SoundAsset> = [];
		for (asset in this.soundList)
		{
			if (asset.source == AssetSource.EXTERNAL)
			{
				assetsToRemove.push(asset);
			}
		}
		
		for (asset in assetsToRemove)
		{
			removeSound(asset);
		}
	}
	
	public function addSound(asset:SoundAsset):Void
	{
		this.soundList.push(asset);
		this._soundMap[asset.path] = asset;
		#if valeditor
		this.soundCollection.add(asset);
		#end
		if (asset.content != null) this._soundToAsset.set(asset.content, asset);
	}
	
	public function removeSound(asset:SoundAsset):Void
	{
		this.soundList.remove(asset);
		this._soundMap.remove(asset.path);
		#if valeditor
		this.soundCollection.remove(asset);
		#end
		if (asset.content != null) this._soundToAsset.remove(asset.content);
		
		asset.pool();
	}
	
	public function createSound(path:String, sound:Sound, data:Bytes):Void
	{
		var asset:SoundAsset = SoundAsset.fromPool();
		path = Path.normalize(path);
		asset.path = path;
		asset.name = Path.withoutDirectory(path);
		asset.content = sound;
		asset.source = AssetSource.EXTERNAL;
		asset.data = data;
		asset.isLoaded = true;
		addSound(asset);
	}
	
	public function getSoundFromPath(path:String):SoundAsset
	{
		return this._soundMap[path];
	}
	
	public function getSoundFromSound(sound:Sound):SoundAsset
	{
		return this._soundToAsset.get(sound);
	}
	
	private function loadSounds():Void
	{
		var idList:Array<String> = new Array<String>();
		for (asset in this.soundList)
		{
			if (!asset.isLoaded && asset.source == AssetSource.ASSETS)
			{
				idList.push(asset.path);
			}
		}
		
		var loader:AssetLoader<Sound> = new AssetLoader<Sound>(idList, Assets.loadSound, loadSoundsComplete);
		loader.start();
	}
	
	private function loadSoundsComplete():Void
	{
		var sound:Sound;
		for (asset in this.soundList)
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
				catch (e)
				{
					// do nothing
				}
			}
		}
		
		loadNext();
	}
	
	public function updateSound(asset:SoundAsset, path:String, sound:Sound, data:Bytes):Void
	{
		this._soundMap.remove(asset.path);
		if (asset.content != null)
		{
			this._soundToAsset.remove(asset.content);
			asset.content = null;
		}
		
		path = Path.normalize(path);
		asset.name = path.substr(path.lastIndexOf("/") + 1);
		asset.content = sound;
		asset.data = data;
		if (asset.content != null) this._soundToAsset.set(asset.content, asset);
		this._soundMap.set(asset.path, asset);
		
		#if valeditor
		updateSoundItem(asset);
		#end
		
		asset.update();
	}
	
	#if valeditor
	public function updateSoundItem(asset:SoundAsset):Void
	{
		this.soundCollection.updateAt(this.soundCollection.indexOf(asset));
	}
	#end
	//####################################################################################################
	//\SOUNDS
	//####################################################################################################
	
	//####################################################################################################
	// TEXTS
	//####################################################################################################
	private function initTexts():Void
	{
		var asset:TextAsset;
		var text:String;
		var strList:Array<String> = Assets.list(AssetType.TEXT);
		if (_debug) trace("AssetLib initTexts " + strList);
		for (id in strList)
		{
			if (this._excludedPaths.exists(Path.directory(id)))
			{
				continue;
			}
			
			asset = TextAsset.fromPool();
			asset.path = id;
			asset.name = Path.withoutDirectory(id);
			try
			{
				text = Assets.getText(id);
				asset.content = text;
				asset.source = AssetSource.ASSETS_EMBEDDED;
				asset.isLoaded = true;
			}
			catch (e)
			{
				asset.source = AssetSource.ASSETS;
				asset.isLoaded = false;
			}
			addText(asset);
		}
	}
	
	private function resetTexts():Void
	{
		var assetsToRemove:Array<TextAsset> = [];
		for (asset in this.textList)
		{
			if (asset.source == AssetSource.EXTERNAL)
			{
				assetsToRemove.push(asset);
			}
		}
		
		for (asset in assetsToRemove)
		{
			removeText(asset);
		}
	}
	
	public function addText(asset:TextAsset):Void
	{
		this.textList.push(asset);
		this._textMap[asset.path] = asset;
		#if valeditor
		this.textCollection.add(asset);
		#end
		if (asset.content != null) this._textToAsset.set(asset.content, asset);
	}
	
	public function removeText(asset:TextAsset):Void
	{
		this.textList.remove(asset);
		this._textMap.remove(asset.path);
		#if valeditor
		this.textCollection.remove(asset);
		#end
		if (asset.content != null) this._textToAsset.remove(asset.content);
		
		asset.pool();
	}
	
	public function createText(path:String, text:String):Void
	{
		var asset:TextAsset = TextAsset.fromPool();
		path = Path.normalize(path);
		asset.path = path;
		asset.name = Path.withoutDirectory(path);
		asset.content = text;
		asset.source = AssetSource.EXTERNAL;
		asset.isLoaded = true;
		addText(asset);
	}
	
	public function getTextFromPath(path:String):TextAsset
	{
		return this._textMap[path];
	}
	
	public function getTextFromText(text:String):TextAsset
	{
		return this._textToAsset[text];
	}
	
	private function loadTexts():Void
	{
		var idList:Array<String> = new Array<String>();
		for (asset in this.textList)
		{
			if (!asset.isLoaded && asset.source == AssetSource.ASSETS)
			{
				idList.push(asset.path);
			}
		}
		
		var loader:AssetLoader<String> = new AssetLoader<String>(idList, Assets.loadText, loadTextsComplete);
		loader.start();
	}
	
	private function loadTextsComplete():Void
	{
		var text:String;
		for (asset in this.textList)
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
				catch (e)
				{
					// do nothing
				}
			}
		}
		
		loadNext();
	}
	
	public function updateText(asset:TextAsset, path:String, text:String):Void
	{
		this._textMap.remove(asset.path);
		if (asset.content != null)
		{
			this._textToAsset.remove(asset.content);
			asset.content = null;
		}
		
		path = Path.normalize(path);
		asset.name = path.substr(path.lastIndexOf("/") + 1);
		asset.content = text;
		if (asset.content != null) this._textToAsset.set(asset.content, asset);
		this._textMap.set(asset.path, asset);
		
		#if valeditor
		updateTextItem(asset);
		#end
		
		asset.update();
	}
	
	#if valeditor
	public function updateTextItem(asset:TextAsset):Void
	{
		this.textCollection.updateAt(this.textCollection.indexOf(asset));
	}
	#end
	//####################################################################################################
	//\TEXTS
	//####################################################################################################
	
	//####################################################################################################
	// STARLING TEXTURES
	//####################################################################################################
	#if starling
	private function resetStarlingTextures():Void
	{
		var assetsToRemove:Array<StarlingTextureAsset> = [];
		for (asset in this.starlingTextureList)
		{
			if (asset.source == AssetSource.EXTERNAL)
			{
				assetsToRemove.push(asset);
			}
		}
		
		for (asset in assetsToRemove)
		{
			removeStarlingTexture(asset);
		}
	}
	
	public function addStarlingTexture(asset:StarlingTextureAsset):Void
	{
		this.starlingTextureList.push(asset);
		this._starlingTextureMap[asset.path] = asset;
		#if valeditor
		this.starlingTextureCollection.add(asset);
		#end
		if (asset.content != null) this._starlingTextureToAsset.set(asset.content, asset);
	}
	
	public function removeStarlingTexture(asset:StarlingTextureAsset):Void
	{
		this.starlingTextureList.remove(asset);
		this._starlingTextureMap.remove(asset.path);
		#if valeditor
		this.starlingTextureCollection.remove(asset);
		#end
		if (asset.content != null) 
		{
			this._starlingTextureToAsset.remove(asset.content);
			asset.content.dispose();
		}
		if (asset.preview != asset.bitmapAsset.preview)
		{
			asset.preview.dispose();
		}
		
		asset.pool();
	}
	
	public function createStarlingTexture(path:String, texture:Texture, textureParams:TextureCreationParameters, bitmapAsset:BitmapAsset, ?name:String, ?preview:BitmapData, ?atlasAsset:StarlingAtlasAsset):Void
	{
		var asset:StarlingTextureAsset = StarlingTextureAsset.fromPool();
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
		asset.atlasAsset = atlasAsset;
		asset.bitmapAsset = bitmapAsset;
		asset.textureParams = textureParams;
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
	
	public function getStarlingTextureAssetFromPath(path:String):StarlingTextureAsset
	{
		return this._starlingTextureMap[path];
	}
	
	public function getStarlingTextureAssetFromTexture(texture:Texture):StarlingTextureAsset
	{
		if (texture == this.defaultStarlingTextureAsset.content) return this.defaultStarlingTextureAsset;
		return this._starlingTextureToAsset.get(texture);
	}
	
	public function updateStarlingTexture(asset:StarlingTextureAsset, bitmapAsset:BitmapAsset, ?path:String, ?texture:Texture, ?textureParams:TextureCreationParameters, ?name:String, ?preview:BitmapData, ?atlasAsset:StarlingAtlasAsset):Void
	{
		this._starlingTextureMap.remove(asset.path);
		if (asset.content != null)
		{
			this._starlingTextureToAsset.remove(asset.content);
		}
		
		if (asset.content != null)
		{
			asset.content.dispose();
			asset.content = null;
		}
		
		if (path == null)
		{
			path = bitmapAsset.path;
		}
		//else
		//{
			//path = Path.normalize(path);
		//}
		asset.path = path;
		if (name == null)
		{
			asset.name = Path.withoutDirectory(path);
		}
		else
		{
			asset.name = name;
		}
		
		if (texture == null)
		{
			if (textureParams != null)
			{
				texture = Texture.fromBitmapData(bitmapAsset.content, textureParams.generateMipMaps, textureParams.optimizeForRenderToTexture, textureParams.scale, textureParams.format, textureParams.forcePotTexture);
			}
			else
			{
				texture = Texture.fromBitmapData(bitmapAsset.content);
			}
		}
		
		if (asset.isFromAtlas)
		{
			if (asset.preview != null)
			{
				asset.preview.dispose();
				asset.preview = null;
			}
		}
		
		asset.content = texture;
		asset.atlasAsset = atlasAsset;
		asset.bitmapAsset = bitmapAsset;
		asset.textureParams = textureParams;
		if (preview == null)
		{
			asset.preview = bitmapAsset.preview;
		}
		else
		{
			asset.preview = preview;
		}
		
		this._starlingTextureMap.set(asset.path, asset);
		this._starlingTextureToAsset.set(asset.content, asset);
		#if valeditor
		updateStarlingTextureItem(asset);
		#end
		
		asset.update();
	}
	
	#if valeditor
	public function updateStarlingTextureItem(asset:StarlingTextureAsset):Void
	{
		this.starlingTextureCollection.updateAt(this.starlingTextureCollection.indexOf(asset));
	}
	#end
	
	#end
	//####################################################################################################
	//\STARLING TEXTURES
	//####################################################################################################
	
	//####################################################################################################
	// STARLING ATLASES
	//####################################################################################################
	#if starling
	private function resetStarlingAtlases():Void
	{
		var assetsToRemove:Array<StarlingAtlasAsset> = [];
		for (asset in this.starlingAtlasList)
		{
			if (asset.source == AssetSource.EXTERNAL)
			{
				assetsToRemove.push(asset);
			}
		}
		
		for (asset in assetsToRemove)
		{
			removeStarlingAtlas(asset);
		}
	}
	
	public function addStarlingAtlas(asset:StarlingAtlasAsset):Void
	{
		this.starlingAtlasList.push(asset);
		this._starlingAtlasMap[asset.path] = asset;
		#if valeditor
		this.starlingAtlasCollection.add(asset);
		#end
		if (asset.content != null) 
		{
			this._starlingAtlasToAsset.set(asset.content, asset);
			this._starlingAtlasTextureToAsset.set(asset.content.texture, asset);
			
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
				
				#if valeditor
				if (this._generatePreview)
				{
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
					
					scale = ScaleUtil.scaleToFit(texWidth, texHeight, UIConfig.ASSET_PREVIEW_WIDTH, UIConfig.ASSET_PREVIEW_HEIGHT);
					preview = new BitmapData(Math.ceil(texWidth * scale), Math.ceil(texHeight * scale), true, 0x00ffffff);
					
					this._rect.setTo(0, 0, texWidth, texHeight);
					this._matrix.identity();
					this._matrix.translate(-subTexture.region.left, -subTexture.region.top);
					this._matrix.scale(scale, scale);
					preview.draw(asset.bitmapAsset.content, this._matrix, null, null, this._rect, true);
				}
				#end
				
				createStarlingTexture(asset.path + ValEdit.STARLING_SUBTEXTURE_MARKER + name, subTexture, null, asset.bitmapAsset, name, preview, asset);
			}
		}
	}
	
	public function updateStarlingAtlas(asset:StarlingAtlasAsset):Void
	{
		var oldAtlas:TextureAtlas = asset.content;
		var oldNames:Vector<String> = oldAtlas.getNames();
		var texture:Texture = Texture.fromBitmapData(asset.bitmapAsset.content, asset.textureParams.generateMipMaps, asset.textureParams.optimizeForRenderToTexture, asset.textureParams.scale, asset.textureParams.format, asset.textureParams.forcePotTexture);
		var newAtlas:TextureAtlas = new TextureAtlas(texture, asset.textAsset.content);
		var newNames:Vector<String> = newAtlas.getNames();
		var textureAsset:StarlingTextureAsset;
		var index:Int;
		var newPath:String = asset.bitmapAsset.path;
		var path:String;
		var subTexture:SubTexture;
		var preview:BitmapData = null;
		var scale:Float;
		var texWidth:Float;
		var texHeight:Float;
		
		for (name in oldNames)
		{
			index = newNames.indexOf(name);
			if (index != -1)
			{
				// remove name from new names
				newNames.splice(index, 1);
				// update texture asset
				path = asset.path + ValEdit.STARLING_SUBTEXTURE_MARKER + name;
				textureAsset = getStarlingTextureAssetFromPath(path);
				
				subTexture = cast newAtlas.getTexture(name);
				
				#if valeditor
				if (this._generatePreview)
				{
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
					
					scale = ScaleUtil.scaleToFit(texWidth, texHeight, UIConfig.ASSET_PREVIEW_WIDTH, UIConfig.ASSET_PREVIEW_HEIGHT);
					preview = new BitmapData(Math.ceil(texWidth * scale), Math.ceil(texHeight * scale), true, 0x00ffffff);
					
					this._rect.setTo(0, 0, texWidth, texHeight);
					this._matrix.identity();
					this._matrix.translate(-subTexture.region.left, -subTexture.region.top);
					this._matrix.scale(scale, scale);
					preview.draw(asset.bitmapAsset.content, this._matrix, null, null, this._rect, true);
				}
				#end
				
				path = newPath + ValEdit.STARLING_SUBTEXTURE_MARKER + name;
				updateStarlingTexture(textureAsset, asset.bitmapAsset, path, subTexture, null, name, preview, asset);
			}
			else
			{
				// remove texture asset
				path = asset.path + ValEdit.STARLING_SUBTEXTURE_MARKER + name;
				textureAsset = getStarlingTextureAssetFromPath(path);
				removeStarlingTexture(textureAsset);
			}
		}
		
		for (name in newNames)
		{
			subTexture = cast asset.content.getTexture(name);
			
			#if valeditor
			if (this._generatePreview)
			{
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
				
				scale = ScaleUtil.scaleToFit(texWidth, texHeight, UIConfig.ASSET_PREVIEW_WIDTH, UIConfig.ASSET_PREVIEW_HEIGHT);
				preview = new BitmapData(Math.ceil(texWidth * scale), Math.ceil(texHeight * scale), true, 0x00ffffff);
				
				this._rect.setTo(0, 0, texWidth, texHeight);
				this._matrix.identity();
				this._matrix.translate(-subTexture.region.left, -subTexture.region.top);
				this._matrix.scale(scale, scale);
				preview.draw(asset.bitmapAsset.content, this._matrix, null, null, this._rect, true);
			}
			#end
			
			createStarlingTexture(asset.path + ValEdit.STARLING_SUBTEXTURE_MARKER + name, subTexture, null, asset.bitmapAsset, name, preview, asset);
		}
		
		this._starlingAtlasMap.remove(asset.path);
		this._starlingAtlasToAsset.remove(oldAtlas);
		this._starlingTextureToAsset.remove(oldAtlas.texture);
		
		asset.path = newPath;
		asset.name = Path.withoutDirectory(newPath);
		asset.content = newAtlas;
		
		this._starlingAtlasMap.set(asset.path, asset);
		this._starlingAtlasToAsset.set(asset.content, asset);
		this._starlingAtlasTextureToAsset.set(asset.content.texture, asset);
		
		updateStarlingAtlasItem(asset);
	}
	
	public function removeStarlingAtlas(asset:StarlingAtlasAsset):Void
	{
		this.starlingAtlasList.remove(asset);
		this._starlingAtlasMap.remove(asset.path);
		this._starlingAtlasTextureToAsset.remove(asset.content.texture);
		this._starlingAtlasToAsset.remove(asset.content);
		#if valeditor
		this.starlingAtlasCollection.remove(asset);
		#end
		if (asset.content != null)
		{
			this._starlingAtlasToAsset.remove(asset.content);
			this._starlingAtlasTextureToAsset.remove(asset.content.texture);
			
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
			
			asset.content.dispose();
		}
		
		asset.pool();
	}
	
	public function createStarlingAtlas(path:String, atlas:TextureAtlas, textureParams:TextureCreationParameters, bitmapAsset:BitmapAsset, textAsset:TextAsset):Void
	{
		var asset:StarlingAtlasAsset = StarlingAtlasAsset.fromPool();
		path = Path.normalize(path);
		asset.path = path;
		asset.name = Path.withoutDirectory(path);
		asset.content = atlas;
		asset.preview = bitmapAsset.preview;
		asset.bitmapAsset = bitmapAsset;
		asset.textAsset = textAsset;
		asset.textureParams = textureParams;
		asset.source = AssetSource.EXTERNAL;
		asset.isLoaded = true;
		addStarlingAtlas(asset);
	}
	
	public function getStarlingAtlasAssetFromAtlas(atlas:TextureAtlas):StarlingAtlasAsset
	{
		return this._starlingAtlasToAsset.get(atlas);
	}
	
	public function getStarlingAtlasAssetFromPath(path:String):StarlingAtlasAsset
	{
		return this._starlingAtlasMap[path];
	}
	
	public function getStarlingAtlasAssetFromTexture(texture:Texture):StarlingAtlasAsset
	{
		return this._starlingAtlasTextureToAsset.get(texture);
	}
	
	#if valeditor
	public function updateStarlingAtlasItem(asset:StarlingAtlasAsset):Void
	{
		this.starlingAtlasCollection.updateAt(this.starlingAtlasCollection.indexOf(asset));
	}
	#end
	
	#end
	//####################################################################################################
	//\STARLING ATLASES
	//####################################################################################################
	
}