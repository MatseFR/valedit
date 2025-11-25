package valedit.data.openfl.filesystem;
#if desktop
import valedit.ExposedCollection;
import valedit.data.openfl.net.OpenFLNetData;
import valedit.value.ExposedBool;
import valedit.value.ExposedObject;
import valedit.value.ExposedPath;
import valedit.value.ExposedString;

/**
 * ...
 * @author Matse
 */
class OpenFLFileSystemData 
{

	static public function exposeFile(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var obj:ExposedObject;
		var path:ExposedPath;
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		OpenFLNetData.exposeFileReference(collection, groupName);
		
		if (!collection.hasValue("exists"))
		{
			bool = new ExposedBool("exists");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("icon"))
		{
			obj = new ExposedObject("icon");
			obj.isReadOnly = true;
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("isDirectory"))
		{
			bool = new ExposedBool("isDirectory");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("isHidden"))
		{
			bool = new ExposedBool("isHidden");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("nativePath"))
		{
			path = new ExposedPath("nativePath");
			collection.addValue(path, groupName);
		}
		
		if (!collection.hasValue("parent"))
		{
			obj = new ExposedObject("parent");
			obj.isReadOnly = true;
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("url"))
		{
			str = new ExposedString("url");
			str.liveTyping = false;
			collection.addValue(str, groupName);
		}
		
		return collection;
	}
	
	static public function exposeFileConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var path:ExposedPath;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("path"))
		{
			path = new ExposedPath("path");
			collection.addValue(path);
		}
		
		return collection;
	}
	
}
#end