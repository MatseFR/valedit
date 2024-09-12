package valedit.value;

import valedit.asset.Asset;
import valedit.asset.SoundAsset;
import valedit.value.base.ExposedValue;
import valedit.value.base.ExposedValueWithAsset;

/**
 * ...
 * @author Matse
 */
class ExposedSound extends ExposedValueWithAsset 
{
	static private var _POOL:Array<ExposedSound> = new Array<ExposedSound>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null):ExposedSound
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name);
		return new ExposedSound(propertyName, name);
	}
	
	private var _soundAsset:SoundAsset;
	
	public function new(propertyName:String, name:String=null) 
	{
		super(propertyName, name);
	}
	
	override public function clear():Void 
	{
		super.clear();
		
		this._soundAsset = null;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String):ExposedSound
	{
		setNames(propertyName, name);
		return this;
	}
	
	private function getAssetFromValue(value:Dynamic):Asset
	{
		return ValEdit.assetLib.getSoundFromSound(value);
	}
	
	override function setValue(value:Dynamic):Dynamic 
	{
		if (this._asset != null)
		{
			this._soundAsset = cast this._asset;
			return super.setValue(this._soundAsset.content);
		}
		else
		{
			return super.setValue(value);
		}
	}
	
	public function clone(copyValue:Bool = false):ExposedValue 
	{
		var snd:ExposedSound = fromPool(this.propertyName, this.name);
		clone_internal(snd, copyValue);
		return snd;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		if (json.asset != null)
		{
			this.value = ValEdit.assetLib.getSoundFromPath(json.asset);
		}
		super.fromJSON(json);
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		if (this._soundAsset != null)
		{
			json.asset = this._soundAsset.path;
		}
		return super.toJSON(json);
	}
	
	override public function fromJSONSave(json:Dynamic):Void 
	{
		this.value = ValEdit.assetLib.getSoundFromPath(json.asset);
		#if valeditor
		if (json.lastChanged != null)
		{
			this.lastChanged = json.lastChanged;
		}
		if (json.lastModified != null)
		{
			this.lastModified = json.lastModified;
		}
		#end
	}
	
	override public function toJSONSave(json:Dynamic, includeNotVisible:Bool = false, refValue:ExposedValue = null):Void 
	{
		if (this._soundAsset != null)
		{
			var data:Dynamic = {asset:this._soundAsset.path};
			#if valeditor
			data.lastChanged = this.lastChanged;
			data.lastModified = this.lastModified;
			#end
			Reflect.setField(json, this.propertyName, data);
		}
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		if (this._soundAsset != null)
		{
			Reflect.setField(json, this.propertyName, this._soundAsset.path);
		}
	}
	
}