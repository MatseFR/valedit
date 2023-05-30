package valedit;
import haxe.Constraints.Function;
import ui.IInteractiveObject;
import valedit.util.PropertyMap;

/**
 * ...
 * @author Matse
 */
class ValEditClassSettings 
{
	public var interactiveFactory:ValEditObject->IInteractiveObject;
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
		//if (propertyMap == null) propertyMap = new PropertyMap();
		//if (proxyPropertyMap == null) proxyPropertyMap = new PropertyMap();
		//this.propertyMap = propertyMap;
		//this.proxyPropertyMap = propertyMap;
	}
	
}