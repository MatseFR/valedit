package valedit.value;

import valedit.asset.AssetLib;
import valedit.asset.BitmapAsset;
import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedBitmapData extends ExposedValue 
{
	private var _asset:BitmapAsset;
	
	override function set_value(value:Dynamic):Dynamic 
	{
		if (Std.isOfType(value, BitmapAsset))
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
		this.isNullable = true;
		this.defaultValue = null;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var bmd:ExposedBitmapData = new ExposedBitmapData(this.propertyName, this.name);
		clone_internal(bmd, copyValue);
		return bmd;
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
		if (json.asset != null)
		{
			this.value = AssetLib.getBitmapFromPath(json.asset);
		}
		super.fromJSON(json);
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