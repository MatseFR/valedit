package valedit.value;

import valedit.events.ValueEvent;
import valedit.value.base.ExposedValue;
import valedit.asset.AssetLib;
import valedit.asset.TextAsset;

/**
 * ...
 * @author Matse
 */
class ExposedText extends ExposedValue 
{
	static private var _POOL:Array<ExposedText> = new Array<ExposedText>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null, maxChars:Int = 0, restrict:String = null):ExposedText
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, maxChars, restrict);
		return new ExposedText(propertyName, name, maxChars, restrict);
	}
	
	/* 0 = unlimited */
	public var maxChars:Int = 0;
	public var restrict:String = null;
	
	private var _asset:TextAsset;
	
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
		if (Std.isOfType(value, TextAsset))
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
	
	/**
	   
	   @param	propertyName
	   @param	name
	   @param	maxChars
	   @param	restrict
	**/
	public function new(propertyName:String, name:String = null, maxChars:Int = 0, restrict:String = null) 
	{
		super(propertyName, name);
		this.maxChars = maxChars;
		this.restrict = restrict;
		this.defaultValue = "";
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
		
		this.defaultValue = "";
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, maxChars:Int, restrict:String):ExposedText
	{
		setNames(propertyName, name);
		this.maxChars = maxChars;
		this.restrict = restrict;
		return this;
	}
	
	override public function readValue(dispatchEventIfChange:Bool = true):Void 
	{
		var val:String = this.value;
		var asset:TextAsset = null;
		if (val != null)
		{
			asset = ValEdit.assetLib.getTextFromText(val);
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
		var val:String = Reflect.getProperty(object, this.propertyName);
		var asset:TextAsset = null;
		if (val != null)
		{
			asset = ValEdit.assetLib.getTextFromText(val);
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
		var text:ExposedText = new ExposedText(this.propertyName, this.name, this.maxChars, this.restrict);
		clone_internal(text, copyValue);
		return text;
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
			this.value = ValEdit.assetLib.getTextFromPath(json.asset);
		}
		else
		{
			this.value = json.value;
		}
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		if (this._asset != null)
		{
			json.asset = this._asset.path;
		}
		else
		{
			json.value = this.value;
		}
		return super.toJSON(json);
	}
	
	override public function fromJSONSave(json:Dynamic):Void 
	{
		if (json.asset != null)
		{
			this.value = ValEdit.assetLib.getTextFromPath(json.asset);
		}
		else
		{
			this.value = json.value;
		}
	}
	
	override public function toJSONSave(json:Dynamic):Void 
	{
		var data:Dynamic;
		if (this._asset != null)
		{
			data = {asset:this._asset.path};
		}
		else
		{
			data = {value:this.value};
		}
		Reflect.setField(json, this.propertyName, data);
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		if (this._asset != null)
		{
			Reflect.setField(json, this.propertyName, this._asset.path);
		}
		else
		{
			super.toJSONSimple(json);
		}
	}
	
}