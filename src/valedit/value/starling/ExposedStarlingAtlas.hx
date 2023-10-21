package valedit.value.starling;

import valedit.value.base.ExposedValue;
import valedit.asset.AssetLib;
import valedit.asset.starling.StarlingAtlasAsset;

/**
 * ...
 * @author Matse
 */
class ExposedStarlingAtlas extends ExposedValue 
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
	
	private var _asset:StarlingAtlasAsset;
	
	override function set_value(value:Dynamic):Dynamic 
	{
		if (Std.isOfType(value, StarlingAtlasAsset))
		{
			this._asset = cast value;
			return super.set_value(this._asset.content);
		}
		this._asset = null;
		return super.set_value(value);
	}
	
	public function new(propertyName:String, name:String = null)
	{
		super(propertyName, name);
		this.isNullable = true;
	}
	
	override public function clear():Void 
	{
		super.clear();
		this._asset = null;
		this.isNullable = true;
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
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var atlas:ExposedStarlingAtlas = new ExposedStarlingAtlas(this.propertyName, this.name);
		clone_internal(atlas, copyValue);
		return atlas;
	}
	
	override function clone_internal(value:ExposedValue, copyValue:Bool = false):Void 
	{
		if (copyValue && this._asset != null)
		{
			value.value = this._asset;
			copyValue = false;
		}
		super.clone_internal(value, copyValue);
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		if (json.asset != null)
		{
			this.value = AssetLib.getStarlingAtlasAssetFromPath(json.asset);
		}
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		if (this._asset != null)
		{
			json.asset = this._asset.path;
		}
		return super.toJSON(json);
	}
	
	override public function fromJSONSave(json:Dynamic):Void 
	{
		this.value = AssetLib.getStarlingAtlasAssetFromPath(json.asset);
	}
	
	override public function toJSONSave(json:Dynamic):Void 
	{
		if (this._asset != null)
		{
			var data:Dynamic = {asset:this._asset.path};
			Reflect.setField(json, this.propertyName, data);
		}
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		if (this._asset != null)
		{
			Reflect.setField(json, this.propertyName, this._asset.path);
		}
	}
	
}