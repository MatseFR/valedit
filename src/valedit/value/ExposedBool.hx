package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedBool extends ExposedValue 
{
	
	/**
	   
	   @param	propertyName
	   @param	name
	**/
	public function new(propertyName:String, name:String = null) 
	{
		super(propertyName, name);
		this.defaultValue = false;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var bool:ExposedBool = new ExposedBool(this.propertyName, this.name);
		super.clone_internal(bool, copyValue);
		return bool;
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