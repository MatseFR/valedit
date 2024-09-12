package valedit.value;

import valedit.asset.Asset;
import valedit.asset.BitmapAsset;
import valedit.value.base.ExposedValue;
import valedit.value.base.ExposedValueWithAsset;

/**
 * ...
 * @author Matse
 */
class ExposedBitmapData extends ExposedValueWithAsset 
{
	static private var _POOL:Array<ExposedBitmapData> = new Array<ExposedBitmapData>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null):ExposedBitmapData
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name);
		return new ExposedBitmapData(propertyName, name);
	}
	
	private var _bmpAsset:BitmapAsset;
	
	public function new(propertyName:String, name:String=null) 
	{
		super(propertyName, name);
	}
	
	override public function clear():Void 
	{
		super.clear();
		
		this._bmpAsset = null;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String):ExposedBitmapData
	{
		setNames(propertyName, name);
		return this;
	}
	
	private function getAssetFromValue(value:Dynamic):Asset
	{
		return ValEdit.assetLib.getBitmapFromBitmapData(value);
	}
	
	override function setValue(value:Dynamic):Dynamic
	{
		if (this._asset != null)
		{
			this._bmpAsset = cast this._asset;
			return super.setValue(this._bmpAsset.content);
		}
		else
		{
			return super.setValue(value);
		}
	}
	
	 public function clone(copyValue:Bool = false):ExposedValue 
	{
		var bmd:ExposedBitmapData = fromPool(this.propertyName, this.name);
		clone_internal(bmd, copyValue);
		return bmd;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		if (json.asset != null)
		{
			this.value = ValEdit.assetLib.getBitmapFromPath(json.asset);
		}
		super.fromJSON(json);
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		if (this._bmpAsset != null)
		{
			json.asset = this._bmpAsset.path;
		}
		return super.toJSON(json);
	}
	
	override public function fromJSONSave(json:Dynamic):Void 
	{
		this.value = ValEdit.assetLib.getBitmapFromPath(json.value);
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
		if (this._bmpAsset != null)
		{
			var data:Dynamic = {value:this._bmpAsset.path};
			#if valeditor
			data.lastChanged = this.lastChanged;
			data.lastModified = this.lastModified;
			#end
			Reflect.setField(json, this.propertyName, data);
		}
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		if (this._bmpAsset != null)
		{
			Reflect.setField(json, this.propertyName, this._bmpAsset.path);
		}
	}
	
}