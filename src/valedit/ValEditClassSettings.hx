package valedit;
import haxe.Constraints.Function;
import valedit.util.PropertyMap;

/**
 * ...
 * @author Matse
 */
class ValEditClassSettings 
{
	public var proxyClass:Class<Dynamic>;
	
	public var propertyMap:PropertyMap;
	public var proxyPropertyMap:PropertyMap;
	
	public var hasRadianRotation:Bool;
	
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