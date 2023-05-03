package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedName extends ExposedValue 
{

	public function new(name:String) 
	{
		super(name);
		this._isRealValue = false;
	}
	
	override public function clone():ExposedValue 
	{
		var name:ExposedName = new ExposedName(this.name);
		return name;
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		return super.toJSON(json);
	}
	
}