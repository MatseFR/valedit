package valedit.value.base;

/**
 * ...
 * @author Matse
 */
abstract class ExposedValueTweenable extends ExposedValue 
{
	override function set_isTweenable(value:Bool):Bool 
	{
		return this._isTweenable = value;
	}
	
	public function new(propertyName:String, name:String=null) 
	{
		super(propertyName, name);
		this._isTweenable = true;
	}
	
}