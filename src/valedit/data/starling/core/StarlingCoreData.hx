package valedit.data.starling.core;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObject;
import valedit.value.ExposedString;

/**
 * ...
 * @author Matse
 */
class StarlingCoreData 
{

	static public function exposeStarling(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var obj:ExposedObject;
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("antiAliasing"))
		{
			intDrag = new ExposedIntDrag("antiAliasing", null, 0, 16);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("contentScaleFactor"))
		{
			floatDrag = new ExposedFloatDrag("contentScaleFactor");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("context"))
		{
			obj = new ExposedObject("context");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("contextValid"))
		{
			bool = new ExposedBool("contextValid");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("discardSystemGestures"))
		{
			bool = new ExposedBool("discardSystemGestures");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("enableErrorChecking"))
		{
			bool = new ExposedBool("enableErrorChecking");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("frameID"))
		{
			intDrag = new ExposedIntDrag("frameID");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("isStarted"))
		{
			bool = new ExposedBool("isStarted");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("juggler"))
		{
			obj = new ExposedObject("juggler");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("nativeOverlay"))
		{
			obj = new ExposedObject("nativeOverlay");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("nativeOverlayBlocksTouches"))
		{
			bool = new ExposedBool("nativeOverlayBlocksTouches");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("nativeStage"))
		{
			obj = new ExposedObject("nativeStage");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("painter"))
		{
			obj = new ExposedObject("painter");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("profile"))
		{
			str = new ExposedString("profile");
			str.isReadOnly = true;
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("root"))
		{
			obj = new ExposedObject("root");
			collection.addValue(obj, groupName);
		}
		
		// TODO : rootClass
		
		if (!collection.hasValue("shareContext"))
		{
			bool = new ExposedBool("shareContext");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("showStats"))
		{
			bool = new ExposedBool("showStats");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("simulateMultiTouch"))
		{
			bool = new ExposedBool("simulateMultiTouch");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("skipUnchangedFrames"))
		{
			bool = new ExposedBool("skipUnchangedFrames");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("stage"))
		{
			obj = new ExposedObject("stage");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("stage3D"))
		{
			obj = new ExposedObject("stage3D");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("supportBrowserZoom"))
		{
			bool = new ExposedBool("supportBrowserZoom");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("supportHighResolutions"))
		{
			bool = new ExposedBool("supportHighResolutions");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("touchProcessor"))
		{
			obj = new ExposedObject("touchProcessor");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("viewPort"))
		{
			obj = new ExposedObject("viewPort");
			collection.addValue(obj, groupName);
		}
		
		return collection;
	}
	
}