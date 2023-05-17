package valedit.value;

import valedit.ExposedValue;
import valedit.asset.AssetLib;
import valedit.asset.TextAsset;

/**
 * ...
 * @author Matse
 */
class ExposedText extends ExposedValue 
{
	/* 0 = unlimited */
	public var maxChars:Int = 0;
	public var restrict:String = null;
	
	private var _asset:TextAsset;
	
	override function set_value(value:Dynamic):Dynamic 
	{
		if (Std.isOfType(value, TextAsset))
		{
			this._asset = cast value;
			return super.set_value(this._asset.content);
		}
		this._asset = null;
		return super.set_value(value);
	}
	
	/**
	   
	   @param	propertyName
	   @param	name
	   @param	maxChars
	   @param	restrict
	**/
	public function new(propertyName:String, name:String=null, maxChars:Int=0, restrict:String=null) 
	{
		super(propertyName, name);
		this.maxChars = maxChars;
		this.restrict = restrict;
		this.defaultValue = "";
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var text:ExposedText = new ExposedText(this.propertyName, this.name, this.maxChars, this.restrict);
		clone_internal(text, copyValue);
		return text;
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
		super.fromJSON(json);
		if (json.asset != null)
		{
			this.value = AssetLib.getTextFromPath(json.asset);
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