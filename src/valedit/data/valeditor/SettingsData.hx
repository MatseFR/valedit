package valedit.data.valeditor;
import juggler.animation.Transitions;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedSelect;
import valedit.value.ExposedString;
#if desktop
import valedit.value.ExposedPath;
#end

/**
 * ...
 * @author Matse
 */
class SettingsData 
{
	
	static public function exposeExportSettings(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		#if desktop
		var path:ExposedPath;
		#end
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		#if desktop
		if (!collection.hasValue("filePath"))
		{
			path = new ExposedPath("filePath", "export path", "export path");
			collection.addValue(path, groupName);
		}
		#end
		
		if (!collection.hasValue("fileName"))
		{
			str = new ExposedString("fileName", "file name", 0);// , "a-z A-Z 0-9 éèêàâôçùü.-_()");
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("compress"))
		{
			bool = new ExposedBool("compress");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("exportAssets"))
		{
			bool = new ExposedBool("exportAssets", "include assets");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("useSimpleJSON"))
		{
			bool = new ExposedBool("useSimpleJSON", "simple JSON");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("useZIP"))
		{
			bool = new ExposedBool("useZIP", "ZIP");
			#if !desktop
			bool.isEditable = false;
			#end
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeFileSettings(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		#if desktop
		var path:ExposedPath;
		#end
		var select:ExposedSelect;
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		#if desktop
		if (!collection.hasValue("filePath"))
		{
			path = new ExposedPath("filePath", "file path", "file path");
			collection.addValue(path, groupName);
		}
		#end
		
		if (!collection.hasValue("fileName"))
		{
			str = new ExposedString("fileName", "file name", 0);// , "a-z A-Z 0-9 éèêàâôçùü.-_()");
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("compress"))
		{
			bool = new ExposedBool("compress");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("frameRateDefault"))
		{
			floatDrag = new ExposedFloatDrag("frameRateDefault", "default frame rate", 0, 300);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("numFramesDefault"))
		{
			intDrag = new ExposedIntDrag("numFramesDefault", "default num frames", 1, 6000);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("numFramesAutoIncrease"))
		{
			bool = new ExposedBool("numFramesAutoIncrease", "auto increase num frames");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("tweenTransitionDefault"))
		{
			select = new ExposedSelect("tweenTransitionDefault", "default tween transition", Transitions.transitionNames, Transitions.transitionNames);
			collection.addValue(select, groupName);
		}
		
		return collection;
	}
	
}