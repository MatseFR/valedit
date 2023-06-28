package valedit.data.valeditor;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
#if desktop
import valedit.value.ExposedFilePath;
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
		var filePath:ExposedFilePath;
		#end
		
		if (collection == null) collection = new ExposedCollection();
		
		#if desktop
		if (!collection.hasValue("fullPath"))
		{
			filePath = new ExposedFilePath("fullPath", "export path", false);
			collection.addValue(filePath, groupName);
		}
		#end
		
		if (!collection.hasValue("exportAssets"))
		{
			bool = new ExposedBool("exportAssets", "include assets");
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("useSimpleJSON"))
		{
			bool = new ExposedBool("useSimpleJSON", "simple JSON");
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("useZIP"))
		{
			bool = new ExposedBool("useZIP", "ZIP");
			#if !desktop
			bool.isEditable = false;
			#end
			collection.addValue(bool);
		}
		
		return collection;
	}
	
}