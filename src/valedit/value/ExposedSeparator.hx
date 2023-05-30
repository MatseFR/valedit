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
	
	override public function applyToObject(object:Dynamic):Void 
	{
		// nothing
	}
	
	override public function readValue(dispatchEventIfChange:Bool = true):Void 
	{
		// nothing
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var separator:ExposedSeparator = new ExposedSeparator(this.name);
		return separator;
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