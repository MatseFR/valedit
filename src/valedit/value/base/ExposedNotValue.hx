package valedit.value.base;

/**
 * ...
 * @author Matse
 */
abstract class ExposedNotValue extends ExposedValue 
{

	public function new(propertyName:String, name:String=null) 
	{
		super(propertyName, name);
		this._isRealValue = false;
	}
	
	override public function applyToObject(object:Dynamic, visibleOnly:Bool = true, applyIfDefaultValue:Bool = false):Void 
	{
		// nothing
	}
	
	override public function read(dispatchEventIfChange:Bool = true):Void 
	{
		// nothing
	}
	
	override public function readFromObject(object:Dynamic, dispatchEventIfChange:Bool = false):Void 
	{
		// nothing
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