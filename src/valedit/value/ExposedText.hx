package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedText extends ExposedValue 
{
	/* 0 = unlimited */
	public var maxChars:Int = 0;
	public var restrict:String = null;
	
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
	
	override public function clone():ExposedValue 
	{
		var text:ExposedText = new ExposedText(this.propertyName, this.name, maxChars, restrict);
		super.clone_internal(text);
		return text;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		this.value = json.value;
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		json.value = this.value;
		return super.toJSON(json);
	}
	
}