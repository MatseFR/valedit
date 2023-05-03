package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedSeparator extends ExposedValue 
{

	public function new(name:String="") 
	{
		super(name);
		this._isRealValue = false;
	}
	
	override public function clone():ExposedValue 
	{
		var separator:ExposedSeparator = new ExposedSeparator(this.name);
		return separator;
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		return super.toJSON(json);
	}
	
}