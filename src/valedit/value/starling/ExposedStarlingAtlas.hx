package valedit.value.starling;

import valedit.ExposedValue;
import valedit.asset.starling.StarlingAtlasAsset;

/**
 * ...
 * @author Matse
 */
class ExposedStarlingAtlas extends ExposedValue 
{
	override function set_value(value:Dynamic):Dynamic 
	{
		if (Std.isOfType(value, StarlingAtlasAsset))
		{
			var asset:StarlingAtlasAsset = cast value;
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
		var atlas:ExposedStarlingAtlas = new ExposedStarlingAtlas(this.propertyName, this.name);
		super.clone_internal(atlas);
		return atlas;
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