package valedit.value;

import valedit.asset.Asset;
import valedit.asset.BinaryAsset;
import valedit.value.base.ExposedValue;
import valedit.value.base.ExposedValueWithAsset;

/**
 * ...
 * @author Matse
 */
class ExposedByteArray extends ExposedValueWithAsset 
{
	static private var _POOL:Array<ExposedByteArray> = new Array<ExposedByteArray>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null):ExposedByteArray
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name);
		return new ExposedByteArray(propertyName, name);
	}
	
	private var _byteAsset:BinaryAsset;
	
	public function new(propertyName:String, name:String=null) 
	{
		super(propertyName, name);
	}
	
	private function getAssetFromValue(value:Dynamic):Asset
	{
		return ValEdit.assetLib.getBinaryFromByteArray(value);
	}
	
	override public function clear():Void 
	{
		super.clear();
		
		this._byteAsset = null;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String):ExposedByteArray
	{
		setNames(propertyName, name);
		return this;
	}
	
	override function setValue(value:Dynamic):Dynamic
	{
		if (this._asset != null)
		{
			this._byteAsset = cast this._asset;
			return super.setValue(this._byteAsset.content);
		}
		else
		{
			return super.setValue(value);
		}
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var bytes:ExposedByteArray = fromPool(this.propertyName, this.name);
		clone_internal(bytes, copyValue);
		return bytes;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		if (json.asset != null)
		{
			this.value = ValEdit.assetLib.getBitmapFromPath(json.asset);
		}
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		if (this._byteAsset != null)
		{
			json.asset = this._byteAsset.path;
		}
		return super.toJSON(json);
	}
	
	override public function fromJSONSave(json:Dynamic):Void 
	{
		this.value = ValEdit.assetLib.getBinaryFromPath(json.asset);
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
		if (this._byteAsset != null)
		{
			var data:Dynamic = {asset:this._byteAsset.path};
			#if valeditor
			data.lastChanged = this.lastChanged;
			data.lastModified = this.lastModified;
			#end
			Reflect.setField(json, this.propertyName, data);
		}
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		if (this._byteAsset != null)
		{
			Reflect.setField(json, this.propertyName, this._byteAsset.path);
		}
	}
	
}