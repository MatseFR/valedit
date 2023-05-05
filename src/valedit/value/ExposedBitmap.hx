package valedit.value;

import openfl.display.Bitmap;
import valedit.ExposedValue;
import valedit.asset.AssetLib;
import valedit.asset.BitmapAsset;

/**
 * ...
 * @author Matse
 */
class ExposedBitmap extends ExposedValue 
{
	private var _asset:BitmapAsset;
	
	override function set_value(value:Dynamic):Dynamic 
	{
		if (Std.isOfType(value, BitmapAsset))
		{
			this._asset = cast value;
			if (this.value == null)
			{
				return super.set_value(new Bitmap(this._asset.content));
			}
			else
			{
				cast(this.value, Bitmap).bitmapData = this._asset.content;
				return value;
			}
		}
		this._asset = null;
		return super.set_value(value);
	}
	
	/**
	   
	   @param	propertyName
	   @param	name
	**/
	public function new(propertyName:String, name:String=null) 
	{
		super(propertyName, name);
		this.defaultValue = null;
	}
	
	override public function clone():ExposedValue 
	{
		var bmp:ExposedBitmap = new ExposedBitmap(this.propertyName, this.name);
		super.clone_internal(bmp);
		return bmp;
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