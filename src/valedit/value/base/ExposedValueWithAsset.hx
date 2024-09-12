package valedit.value.base;
import valedit.asset.Asset;
import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
abstract class ExposedValueWithAsset extends ExposedValue 
{
	private var _asset:Asset;
	
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
		if (this._asset != null && this._asset != value)
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
		
		if (Std.isOfType(value, Asset))
		{
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
		else
		{
			this._asset = null;
		}
		
		return setValue(value);
	}
	
	public function new(propertyName:String, name:String=null) 
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
	
	abstract private function getAssetFromValue(value:Dynamic):Asset;
	
	//abstract private function setValue(value:Dynamic):Dynamic;
	
	override public function read(dispatchEventIfChange:Bool = true):Void 
	{
		var val:Dynamic = this.value;
		var asset:Asset = null;
		if (val != null)
		{
			asset = getAssetFromValue(val);
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
		
		updateValueIfDifferent(val, dispatchEventIfChange);
	}
	
	override public function readFromObject(object:Dynamic, dispatchEventIfChange:Bool = false):Void 
	{
		var val:Dynamic = Reflect.getProperty(object, this.propertyName);
		var asset:Asset = null;
		if (val != null)
		{
			asset = getAssetFromValue(val);
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
		
		updateValueIfDifferent(val, dispatchEventIfChange);
	}
	
	override public function cloneValue(toValue:ExposedValue):Void 
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
	
}