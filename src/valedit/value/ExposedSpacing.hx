package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedSpacing extends ExposedValue 
{

	public function new(name:String = "") 
	{
		super(name);
		this._isRealValue = false;
	}
	
	override public function clone():ExposedValue 
	{
		var space:ExposedSpacing = new ExposedSpacing(this.name);
		return space;
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		return super.toJSON(json);
	}
	
}