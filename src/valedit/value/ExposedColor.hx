package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedColor extends ExposedValue 
{
	
	/**
	   
	   @param	propertyName
	   @param	name
	**/
	public function new(propertyName:String, name:String = null) 
	{
		super(propertyName, name);
		this.defaultValue = 0xffffff;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var color:ExposedColor = new ExposedColor(this.propertyName, this.name);
		super.clone_internal(color, copyValue);
		return color;
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