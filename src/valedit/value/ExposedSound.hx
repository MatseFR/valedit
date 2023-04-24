package valedit.value;

import valedit.ExposedValue;
import valedit.asset.SoundAsset;

/**
 * ...
 * @author Matse
 */
class ExposedSound extends ExposedValue 
{
	override function set_value(value:Dynamic):Dynamic 
	{
		if (Std.isOfType(value, SoundAsset))
		{
			var asset:SoundAsset = cast value;
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
		var snd:ExposedSound = new ExposedSound(this.propertyName, this.name);
		super.clone_internal(snd);
		return snd;
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