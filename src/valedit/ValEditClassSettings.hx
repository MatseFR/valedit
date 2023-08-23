package valedit;
import haxe.Constraints.Function;
import valedit.utils.PropertyMap;

/**
 * ...
 * @author Matse
 */
class ValEditClassSettings 
{
	static private var _POOL:Array<ValEditClassSettings> = new Array<ValEditClassSettings>();
	
	static public function fromPool():ValEditClassSettings
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new ValEditClassSettings();
	}
	
	/** external/static function of type Dynamic->DisplayObjectContainer->Void to call instead of doing a simple addChild
	 *  This is only useful if isDisplayObject is set to true */
	public var addToDisplayFunction:Function;
	
	/** name of the object's DisplayObjectContainer->Void function to call instead of doing a simple addChild */
	public var addToDisplayFunctionName:String;
	
	/** constructor collection */
	public var constructorCollection:ExposedCollection;
	
	/** if not null, this function will be used to create objects from this class
	 *  make sure the function's signature matches the constructorCollection (if any) */
	public var creationFunction:Function;
	
	/** external/static function of type Dynamic->Void to call on object creation */
	public var creationInitFunction:Function;
	
	/** name of the object's function to call on object creation */
	public var creationInitFunctionName:String;
	
	/** displayObjectType is only useful if isDisplayObject is set to true */
	public var displayObjectType:Int = DisplayObjectType.NONE;
	
	/** external/static function of type Dynamic->Void to call on object destruction */
	public var disposeFunction:Function;
	
	/** name of the object's function to call on object destruction */
	public var disposeFunctionName:String;
	
	/** @default false **/
	public var isDisplayObject:Bool;
	
	/** object collection */
	public var objectCollection:ExposedCollection;
	
	public var propertyMap:PropertyMap;
	
	/** external/static function of type Dynamic->DisplayObjectContainer->Void
	 *  This is only useful is isDisplayObject is set to true */
	public var removeFromDisplayFunction:Function;
	
	/** name of the object's function */
	public var removeFromDisplayFunctionName:String;
	
	/** template collection */
	public var templateCollection:ExposedCollection;

	public function new()
	{
		
	}
	
	public function clear():Void
	{
		this.addToDisplayFunction = null;
		this.addToDisplayFunctionName = null;
		this.constructorCollection = null;
		this.creationFunction = null;
		this.creationInitFunction = null;
		this.creationInitFunctionName = null;
		this.displayObjectType = DisplayObjectType.UNKNOWN;
		this.disposeFunction = null;
		this.disposeFunctionName = null;
		this.isDisplayObject = false;
		this.objectCollection = null;
		this.propertyMap = null;
		this.removeFromDisplayFunction = null;
		this.removeFromDisplayFunctionName = null;
		this.templateCollection = null;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
}