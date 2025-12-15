package valedit.value;

import openfl.display.Bitmap;
import valedit.asset.Asset;
import valedit.asset.BitmapAsset;
import valedit.value.base.ExposedValue;
import valedit.value.base.ExposedValueWithAsset;

/**
 * ...
 * @author Matse
 */
class ExposedBitmap extends ExposedValueWithAsset 
{
	static private var _POOL:Array<ExposedBitmap> = new Array<ExposedBitmap>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName, name:String = null):ExposedBitmap
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name);
		return new ExposedBitmap(propertyName, name);
	}
	
	private var _bmpAsset:BitmapAsset;
	
	/**
	   
	   @param	propertyName
	   @param	name
	**/
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
	
	private function setTo(propertyName:String, name:String = null):ExposedBitmap
	{
		setNames(propertyName, name);
		return this;
	}
	
	private function getAssetFromValue(value:Dynamic):Asset
	{
		return ValEdit.assetLib.getBitmapFromBitmapData(value.bitmapData);
	}
	
	override function setValue(value:Dynamic):Dynamic
	{
		if (this._asset != null)
		{
			this._bmpAsset = cast this._asset;
			if (this.value == null)
			{
				return super.setValue(new Bitmap(this._bmpAsset.content));
			}
			else
			{
				cast(this.value, Bitmap).bitmapData = this._bmpAsset.content;
				return value;
			}
		}
		else
		{
			return super.setValue(value);
		}
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var bmp:ExposedBitmap = fromPool(this.propertyName, this.name);
		clone_internal(bmp, copyValue);
		return bmp;
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
		this.value = ValEdit.assetLib.getBitmapFromPath(json.asset);
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
			var data:Dynamic = {asset:this._bmpAsset.path};
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