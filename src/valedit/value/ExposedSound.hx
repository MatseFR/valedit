package valedit.value;

import valedit.ExposedValue;
import valedit.asset.AssetLib;
import valedit.asset.SoundAsset;

/**
 * ...
 * @author Matse
 */
class ExposedSound extends ExposedValue 
{
	private var _asset:SoundAsset;
	
	override function set_value(value:Dynamic):Dynamic 
	{
		if (Std.isOfType(value, SoundAsset))
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
		var snd:ExposedSound = new ExposedSound(this.propertyName, this.name);
		super.clone_internal(snd);
		return snd;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		if (json.asset != null)
		{
			this.value = AssetLib.getSoundFromPath(json.asset);
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