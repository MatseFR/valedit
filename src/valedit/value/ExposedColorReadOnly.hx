package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedColorReadOnly extends ExposedValue 
{

	public function new(propertyName:String, name:String=null) 
	{
		super(propertyName, name);
		
	}
	
	override public function applyToObject(object:Dynamic):Void 
	{
		// nothing
	}
	
	override public function clone():ExposedValue 
	{
		var color:ExposedColorReadOnly = new ExposedColorReadOnly(this.propertyName, this.name);
		super.clone_internal(color);
		return color;
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		return null;
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		// nothing
	}
	
}