package valedit.value;

import valedit.ExposedValue;
import valedit.asset.starling.StarlingTextureAsset;

/**
 * ...
 * @author Matse
 */
class ExposedStarlingTexture extends ExposedValue 
{
	override function set_value(value:Dynamic):Dynamic 
	{
		if (Std.isOfType(value, StarlingTextureAsset))
		{
			var asset:StarlingTextureAsset = cast value;
			return super.set_value(asset.content);
		}
		else
		{
			return super.set_value(value);
		}
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
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		return super.toJSON(json);
	}
	
}