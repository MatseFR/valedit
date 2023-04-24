package valedit.value;

import valedit.asset.BitmapAsset;
import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedBitmapData extends ExposedValue 
{
	override function set_value(value:Dynamic):Dynamic 
	{
		if (Std.isOfType(value, BitmapAsset))
		{
			var asset:BitmapAsset = cast value;
			return super.set_value(asset.content);
		}
		return super.set_value(value);
	}
	
	public function new(propertyName:String, name:String=null) 
	{
		super(propertyName, name);
		this.defaultValue = null;
	}
	
	override public function clone():ExposedValue 
	{
		var bmd:ExposedBitmapData = new ExposedBitmapData(this.propertyName, this.name);
		super.clone_internal(bmd);
		return bmd;
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