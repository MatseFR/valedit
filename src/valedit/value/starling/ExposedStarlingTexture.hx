package valedit.value.starling;

import starling.textures.Texture;
import valedit.asset.starling.StarlingTextureAsset;
import valedit.events.ValueEvent;
import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedStarlingTexture extends ExposedValue 
{
	static private var _POOL:Array<ExposedStarlingTexture> = new Array<ExposedStarlingTexture>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null):ExposedStarlingTexture
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name);
		return new ExposedStarlingTexture(propertyName, name);
	}
	
	private var _asset:StarlingTextureAsset;
	
	override function set_isConstructor(value:Bool):Bool 
	{
		if (this._isConstructor == value) return value;
		
		if (value)
		{
			if (this._asset != null)
			{
				this._asset.unregisterValue(this);
				this._asset.registerConstructorValue(this);
			}
		}
		else
		{
			if (this._asset != null)
			{
				this._asset.unregisterConstructorValue(this);
				this._asset.registerValue(this);
			}
		}
		
		return super.set_isConstructor(value);
	}
	
	override function set_value(value:Dynamic):Dynamic 
	{
		if (Std.isOfType(value, StarlingTextureAsset))
		{
			if (this._asset != value)
			{
				if (this._asset != null)
				{
					if (this._isConstructor)
					{
						this._asset.unregisterConstructorValue(this);
					}
					else
					{
						this._asset.unregisterValue(this);
					}
				}
				this._asset = cast value;
				if (this._isConstructor)
				{
					this._asset.registerConstructorValue(this);
				}
				else
				{
					this._asset.registerValue(this);
				}
			}
			return super.set_value(this._asset.content);
		}
		if (this._asset != null)
		{
			if (this._isConstructor)
			{
				this._asset.unregisterConstructorValue(this);
			}
			else
			{
				this._asset.unregisterValue(this);
			}
			this._asset = null;
		}
		return super.set_value(value);
	}

	public function new(propertyName:String, name:String = null)
	{
		super(propertyName, name);
		this.isNullable = true;
	}
	
	override public function clear():Void 
	{
		if (this._asset != null)
		{
			if (this._isConstructor)
			{
				this._asset.unregisterConstructorValue(this);
			}
			else
			{
				this._asset.unregisterValue(this);
			}
			this._asset = null;
		}
		super.clear();
		
		this.isNullable = true;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String):ExposedStarlingTexture
	{
		setNames(propertyName, name);
		return this;
	}
	
	override public function readValue(dispatchEventIfChange:Bool = true):Void 
	{
		var val:Texture = this.value;
		var asset:StarlingTextureAsset = null;
		if (val != null)
		{
			asset = ValEdit.assetLib.getStarlingTextureAssetFromTexture(val);
		}
		
		if (asset != this._asset)
		{
			if (this._asset != null)
			{
				if (this._isConstructor)
				{
					this._asset.unregisterConstructorValue(this);
				}
				else
				{
					this._asset.unregisterValue(this);
				}
			}
			this._asset = asset;
			if (this._asset != null)
			{
				if (this._isConstructor)
				{
					this._asset.registerConstructorValue(this);
				}
				else
				{
					this._asset.registerValue(this);
				}
			}
		}
		
		if (this._storedValue != val)
		{
			this._storedValue = val;
			if (this._uiControl != null) this._uiControl.updateExposedValue();
			if (dispatchEventIfChange) ValueEvent.dispatch(this, ValueEvent.VALUE_CHANGE, this);
		}
	}
	
	override public function readValueFromObject(object:Dynamic, dispatchEventIfChange:Bool = false):Void 
	{
		var val:Texture = Reflect.getProperty(object, this.propertyName);
		var asset:StarlingTextureAsset = null;
		if (val != null)
		{
			asset = ValEdit.assetLib.getStarlingTextureAssetFromTexture(val);
		}
		
		if (asset != this._asset)
		{
			if (this._asset != null)
			{
				if (this._isConstructor)
				{
					this._asset.unregisterConstructorValue(this);
				}
				else
				{
					this._asset.unregisterValue(this);
				}
			}
			this._asset = asset;
			if (this._asset != null)
			{
				if (this._isConstructor)
				{
					this._asset.registerConstructorValue(this);
				}
				else
				{
					this._asset.registerValue(this);
				}
			}
		}
		
		if (this._storedValue != val)
		{
			this._storedValue = val;
			if (this._uiControl != null) this._uiControl.updateExposedValue();
			if (dispatchEventIfChange) ValueEvent.dispatch(this, ValueEvent.VALUE_CHANGE, this);
		}
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var tex:ExposedStarlingTexture = new ExposedStarlingTexture(this.propertyName, this.name);
		clone_internal(tex, copyValue);
		return tex;
	}
	
	override function cloneValue(toValue:ExposedValue):Void 
	{
		if (this._asset != null)
		{
			toValue.value = this._asset;
		}
		else
		{
			super.cloneValue(toValue);
		}
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		if (json.asset != null)
		{
			this.value = ValEdit.assetLib.getStarlingTextureAssetFromPath(json.asset);
		}
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
	
	override public function fromJSONSave(json:Dynamic):Void 
	{
		this.value = ValEdit.assetLib.getStarlingTextureAssetFromPath(json.asset);
	}
	
	override public function toJSONSave(json:Dynamic):Void 
	{
		if (this._asset != null)
		{
			var data:Dynamic = {asset:this._asset.path};
			Reflect.setField(json, this.propertyName, data);
		}
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		if (this._asset != null)
		{
			Reflect.setField(json, this.propertyName, this._asset.path);
		}
	}
	
}