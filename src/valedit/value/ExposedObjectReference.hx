package valedit.value;

import valedit.ExposedValue;
import valedit.ValEditObject;

/**
 * ...
 * @author Matse
 */
class ExposedObjectReference extends ExposedValue 
{
	public var classList(default, null):Array<String>;
	
	private var _valEditObject:ValEditObject;
	
	override function set_value(value:Dynamic):Dynamic 
	{
		if (Std.isOfType(value, ValEditObject))
		{
			this._valEditObject = cast value;
			return super.set_value(this._valEditObject.object);
		}
		this._valEditObject = null;
		return super.set_value(value);
	}

	public function new(propertyName:String, name:String=null, classList:Array<String> = null) 
	{
		super(propertyName, name);
		if (classList == null) classList = new Array<String>();
		this.classList = classList;
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
	
	override public function clone():ExposedValue 
	{
		var reference:ExposedObjectReference = new ExposedObjectReference(this.propertyName, this.name);
		super.clone_internal(reference);
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
			if (this._valEditObject != null)
			{
				json.value = this._valEditObject.name;
				json.clss = ValEdit.getObjectClassName(this._valEditObject.object);
			}
			else
			{
				var className:String = ValEdit.getObjectClassName(this.value);
				json.value = ValEdit.getObjectNameWithClassName(this.value, className);
				json.clss = className;
			}
		}
		return super.toJSON(json);
	}
	
}