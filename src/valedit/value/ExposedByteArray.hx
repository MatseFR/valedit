package valedit.value;

import valedit.ExposedValue;
import valedit.asset.AssetLib;
import valedit.asset.BinaryAsset;

/**
 * ...
 * @author Matse
 */
class ExposedByteArray extends ExposedValue 
{
	private var _asset:BinaryAsset;
	
	override function set_value(value:Dynamic):Dynamic 
	{
		if (Std.isOfType(value, BinaryAsset))
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
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var bytes:ExposedByteArray = new ExposedByteArray(this.propertyName, this.name);
		clone_internal(bytes, copyValue);
		return bytes;
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
			this.value = AssetLib.getBitmapFromPath(json.asset);
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