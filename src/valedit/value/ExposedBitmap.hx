package valedit.value;

import openfl.display.Bitmap;
import valedit.ExposedValue;
import valedit.asset.BitmapAsset;

/**
 * ...
 * @author Matse
 */
class ExposedBitmap extends ExposedValue 
{
	override function set_value(value:Dynamic):Dynamic 
	{
		if (Std.isOfType(value, BitmapAsset))
		{
			var asset:BitmapAsset = cast value;
			if (this.value == null)
			{
				return super.set_value(new Bitmap(asset.content));
			}
			else
			{
				cast(this.value, Bitmap).bitmapData = asset.content;
				return value;
			}
		}
		else
		{
			return super.set_value(value);
		}
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
		super.fromJSON(json);
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		return super.toJSON(json);
	}
	
}