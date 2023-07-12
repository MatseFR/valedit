package valedit.value;

import openfl.display.Bitmap;
import valedit.value.base.ExposedValue;
import valedit.asset.AssetLib;
import valedit.asset.BitmapAsset;

/**
 * ...
 * @author Matse
 */
class ExposedBitmap extends ExposedValue 
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
		this.isNullable = true;
	}
	
	override public function clear():Void 
	{
		super.clear();
		this._asset = null;
		this.isNullable = true;
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
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var bmp:ExposedBitmap = fromPool(this.propertyName, this.name);
		clone_internal(bmp, copyValue);
		return bmp;
	}
	
	override function clone_internal(value:ExposedValue, copyValue:Bool = false):Void 
	{
		if (copyValue && this._asset != null)
		{
			value.value = this._asset;
			copyValue = false;
		}
		super.clone_internal(value, copyValue);
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