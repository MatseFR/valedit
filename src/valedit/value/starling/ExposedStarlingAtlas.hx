package valedit.value.starling;

import valedit.ExposedValue;
import valedit.asset.AssetLib;
import valedit.asset.starling.StarlingAtlasAsset;

/**
 * ...
 * @author Matse
 */
class ExposedStarlingAtlas extends ExposedValue 
{
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
	
	public function new(propertyName:String, name:String=null) 
	{
		super(propertyName, name);
		this.defaultValue = null;
	}
	
	override public function clone():ExposedValue 
	{
		var atlas:ExposedStarlingAtlas = new ExposedStarlingAtlas(this.propertyName, this.name);
		super.clone_internal(atlas);
		return atlas;
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
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		if (this._asset != null)
		{
			Reflect.setField(json, this.propertyName, this._asset.path);
		}
	}
	
}