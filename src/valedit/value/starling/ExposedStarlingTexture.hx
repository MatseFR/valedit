package valedit.value.starling;

import valedit.ExposedValue;
import valedit.asset.AssetLib;
import valedit.asset.starling.StarlingTextureAsset;

/**
 * ...
 * @author Matse
 */
class ExposedStarlingTexture extends ExposedValue 
{
	private var _asset:StarlingTextureAsset;
	
	override function set_value(value:Dynamic):Dynamic 
	{
		if (Std.isOfType(value, StarlingTextureAsset))
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
		var tex:ExposedStarlingTexture = new ExposedStarlingTexture(this.propertyName, this.name);
		super.clone_internal(tex);
		return tex;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		if (json.asset != null)
		{
			this.value = AssetLib.getStarlingTextureAssetFromPath(json.asset);
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