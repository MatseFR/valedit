package valedit.value;

import openfl.errors.Error;
import valedit.ExposedValue;
import valedit.ValEditObject;

/**
 * ...
 * @author Matse
 */
class ExposedObjectReference extends ExposedValue 
{
	/** if false, current object won't be available for selection. Default is false */
	public var allowSelfReference:Bool;
	public var classList(default, null):Array<String>;
	
	private var _valEditObjectReference:ValEditObject;
	
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
		var reference:ExposedObjectReference = new ExposedObjectReference(this.propertyName, this.name, this.classList.copy(), this.allowSelfReference);
		super.clone_internal(reference, copyValue);
		return reference;
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