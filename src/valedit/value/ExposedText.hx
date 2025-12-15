package valedit.value;

import valedit.asset.Asset;
import valedit.asset.TextAsset;
import valedit.value.base.ExposedValue;
import valedit.value.base.ExposedValueWithAsset;

/**
 * ...
 * @author Matse
 */
class ExposedText extends ExposedValueWithAsset 
{
	static private var _POOL:Array<ExposedText> = new Array<ExposedText>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null#if valeditor, maxChars:Int = 0, restrict:String = null#end):ExposedText
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name#if valeditor, maxChars, restrict#end);
		return new ExposedText(propertyName, name#if valeditor, maxChars, restrict#end);
	}
	
	#if valeditor
	public var liveTyping:Bool = true;
	/* 0 = unlimited */
	public var maxChars:Int = 0;
	public var restrict:String = null;
	#end
	
	private var _textAsset:TextAsset;
	
	/**
	   
	   @param	propertyName
	   @param	name
	   @param	maxChars
	   @param	restrict
	**/
	public function new(propertyName:String, name:String = null#if valeditor, maxChars:Int = 0, restrict:String = null#end) 
	{
		super(propertyName, name);
		#if valeditor
		this.maxChars = maxChars;
		this.restrict = restrict;
		#end
		this.defaultValue = "";
	}
	
	override public function clear():Void 
	{
		super.clear();
		
		this._textAsset = null;
		
		#if valeditor
		this.liveTyping = true;
		#end
		this.defaultValue = "";
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String#if valeditor, maxChars:Int, restrict:String#end):ExposedText
	{
		setNames(propertyName, name);
		#if valeditor
		this.maxChars = maxChars;
		this.restrict = restrict;
		#end
		return this;
	}
	
	private function getAssetFromValue(value:Dynamic):Asset
	{
		return ValEdit.assetLib.getTextFromText(value);
	}
	
	override function setValue(value:Dynamic):Dynamic
	{
		if (this._asset != null)
		{
			this._textAsset = cast this._asset;
			return super.setValue(this._textAsset.content);
		}
		else
		{
			return super.setValue(value);
		}
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var text:ExposedText = fromPool(this.propertyName, this.name#if valeditor, this.maxChars, this.restrict#end);
		#if valeditor
		text.liveTyping = this.liveTyping;
		#end
		clone_internal(text, copyValue);
		return text;
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
		if (this._textAsset != null)
		{
			json.asset = this._textAsset.path;
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
		var data:Dynamic;
		if (this._textAsset != null)
		{
			data = {asset:this._textAsset.path};
		}
		else
		{
			data = {value:this.value};
		}
		#if valeditor
		data.lastChanged = this.lastChanged;
		data.lastModified = this.lastModified;
		#end
		Reflect.setField(json, this.propertyName, data);
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		if (this._textAsset != null)
		{
			Reflect.setField(json, this.propertyName, this._textAsset.path);
		}
		else
		{
			super.toJSONSimple(json);
		}
	}
	
}