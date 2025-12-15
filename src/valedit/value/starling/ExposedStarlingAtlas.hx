package valedit.value.starling;

import valedit.asset.Asset;
import valedit.asset.starling.StarlingAtlasAsset;
import valedit.value.base.ExposedValue;
import valedit.value.base.ExposedValueWithAsset;

/**
 * ...
 * @author Matse
 */
class ExposedStarlingAtlas extends ExposedValueWithAsset 
{
	static private var _POOL:Array<ExposedStarlingAtlas> = new Array<ExposedStarlingAtlas>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null):ExposedStarlingAtlas
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name);
		return new ExposedStarlingAtlas(propertyName, name);
	}
	
	private var _atlasAsset:StarlingAtlasAsset;
	
	public function new(propertyName:String, name:String = null)
	{
		super(propertyName, name);
	}
	
	override public function clear():Void 
	{
		super.clear();
		
		this._atlasAsset = null;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String):ExposedStarlingAtlas
	{
		setNames(propertyName, name);
		return this;
	}
	
	private function getAssetFromValue(value:Dynamic):Asset
	{
		return ValEdit.assetLib.getStarlingAtlasAssetFromAtlas(value);
	}
	
	override function setValue(value:Dynamic):Dynamic
	{
		if (this._asset != null)
		{
			this._atlasAsset = cast this._asset;
			return super.setValue(this._atlasAsset.content);
		}
		else
		{
			return super.setValue(value);
		}
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var atlas:ExposedStarlingAtlas = fromPool(this.propertyName, this.name);
		clone_internal(atlas, copyValue);
		return atlas;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		if (json.asset != null)
		{
			this.value = ValEdit.assetLib.getStarlingAtlasAssetFromPath(json.asset);
		}
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		if (this._atlasAsset != null)
		{
			json.asset = this._atlasAsset.path;
		}
		return super.toJSON(json);
	}
	
	override public function fromJSONSave(json:Dynamic):Void 
	{
		this.value = ValEdit.assetLib.getStarlingAtlasAssetFromPath(json.asset);
		#if valeditor
		if (json.lastChanged != null)
		{
			this.lastChanged = json.lastChanged;
		}
		if (json.lastModified != null)
		{
			this.lastModified = json.lastModified;
		}
		#end
	}
	
	override public function toJSONSave(json:Dynamic, includeNotVisible:Bool = false, refValue:ExposedValue = null):Void 
	{
		if (this._atlasAsset != null)
		{
			var data:Dynamic = {asset:this._atlasAsset.path};
			#if valeditor
			data.lastChanged = this.lastChanged;
			data.lastModified = this.lastModified;
			#end
			Reflect.setField(json, this.propertyName, data);
		}
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		if (this._atlasAsset != null)
		{
			Reflect.setField(json, this.propertyName, this._atlasAsset.path);
		}
	}
	
}