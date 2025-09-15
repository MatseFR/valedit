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
	
	/** if not null, this function will be called on collection updates to determine whether that value should be tweened or not */
	public var isTweenableFunction:ExposedValueTweenable->Bool;
	
	public function new(propertyName:String, name:String=null) 
	{
		super(propertyName, name);
		this._isTweenable = true;
	}
	
	override public function clear():Void 
	{
		super.clear();
		
		this.isTweenableFunction = null;
	}
	
}