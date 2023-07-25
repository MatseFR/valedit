package valedit;
import haxe.Constraints.Function;
import valedit.utils.PropertyMap;

/**
 * ...
 * @author Matse
 */
class ValEditClassSettings 
{
	public var objectDisposeFunctionName:String;
	public var propertyMap:PropertyMap;
	public var hasRadianRotation:Bool;
	
	/**
	   provided function should be like Dynamic->Void
	**/
	public var disposeCustom:Function;
	/**
	   provided function should be like Dynamic->DisplayObjectContainer->Void
	**/
	public var addToDisplayCustom:Function;
	/**
	   provided function should be like Dynamic->DisplayObjectContainer->Void
	**/
	public var removeFromDisplayCustom:Function;

	public function new()
	{
		
	}
	
}