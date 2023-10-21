package valedit.value;

import openfl.errors.Error;
import valedit.value.base.ExposedValue;
import valedit.ValEditObject;

/**
 * ...
 * @author Matse
 */
class ExposedObjectReference extends ExposedValue 
{
	static private var _POOL:Array<ExposedObjectReference> = new Array<ExposedObjectReference>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String=null, classList:Array<String> = null, allowSelfReference:Bool = false):ExposedObjectReference
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, classList, allowSelfReference);
		return new ExposedObjectReference(propertyName, name, classList, allowSelfReference);
	}
	
	/** if false, current object won't be available for selection. Default is false */
	public var allowSelfReference:Bool;
	public var classList(default, null):Array<String>;
	
	private var _valEditObjectReference:ValEditObject;
	
	// LOADING
	private var _objectID:String;
	private var _objectClassName:String;
	//\LOADING
	
	override function set_value(value:Dynamic):Dynamic 
	{
		if (Std.isOfType(value, ValEditObject))
		{
			this._valEditObjectReference = cast value;
			return super.set_value(this._valEditObjectReference.object);
		}
		this._valEditObjectReference = null;
		return super.set_value(value);
	}

	public function new(propertyName:String, name:String=null, classList:Array<String> = null, allowSelfReference:Bool = false) 
	{
		super(propertyName, name);
		if (classList == null) classList = new Array<String>();
		this.classList = classList;
		this.allowSelfReference = allowSelfReference;
		this.isNullable = true;
	}
	
	override public function clear():Void 
	{
		super.clear();
		this.classList = null;
		this._valEditObjectReference = null;
		this.isNullable = true;
		this._objectID = null;
		this._objectClassName = null;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, classList:Array<String>, allowSelfReference:Bool):ExposedObjectReference
	{
		setNames(propertyName, name);
		if (classList == null) classList = new Array<String>();
		this.classList = classList;
		this.allowSelfReference = allowSelfReference;
		return this;
	}
	
	public function addClass(clss:Class<Dynamic>):Void
	{
		var className:String = Type.getClassName(clss);
		addClassName(className);
	}
	
	public function addClassName(className:String):Void
	{
		this.classList.push(className);
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var reference:ExposedObjectReference = fromPool(this.propertyName, this.name, this.classList.copy(), this.allowSelfReference);
		super.clone_internal(reference, copyValue);
		return reference;
	}
	
	override public function loadComplete():Void 
	{
		if (this._objectID != null)
		{
			this.value = ValEdit.getObjectWithClassName(this._objectID, this._objectClassName);
		}
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		if (json.value != null)
		{
			this.value = ValEdit.getObjectWithClassName(json.value, json.clss);
		}
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		if (this.value != null)
		{
			if (this._valEditObjectReference != null)
			{
				json.value = this._valEditObjectReference.id;
				json.clss = this._valEditObjectReference.className;
			}
			else
			{
				//var className:String = ValEdit.getObjectClassName(this.value);
				//json.value = ValEdit.getObjectNameWithClassName(this.value, className);
				//json.clss = className;
				
				throw new Error("missing ValEditObject");
			}
		}
		return super.toJSON(json);
	}
	
	override public function fromJSONSave(json:Dynamic):Void 
	{
		this._objectID = json.value;
		this._objectClassName = json.clss;
	}
	
	override public function toJSONSave(json:Dynamic):Void 
	{
		if (this.value != null)
		{
			var data:Dynamic = {value:this._valEditObjectReference.id, clss:this._valEditObjectReference.className};
			Reflect.setField(json, this.propertyName, data);
		}
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		if (this.value != null)
		{
			if (this._valEditObjectReference != null)
			{
				Reflect.setField(json, this.propertyName, this._valEditObjectReference.id);
			}
			else
			{
				//Reflect.setField(json, this.propertyName, ValEdit.getObjectID(this.value));
				
				throw new Error("missing ValEditObject");
			}
		}
	}
	
}