package valedit.data.openfl.net;
import valedit.ExposedCollection;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedObject;
import valedit.value.ExposedString;

/**
 * ...
 * @author Matse
 */
class OpenFLNetData 
{

	static public function exposeFileReference(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var obj:ExposedObject;
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("creationDate"))
		{
			obj = new ExposedObject("creationDate");
			obj.isReadOnly = true;
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("creator"))
		{
			str = new ExposedString("creator");
			str.isReadOnly = true;
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("extension"))
		{
			str = new ExposedString("extension");
			str.isReadOnly = true;
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("modificationDate"))
		{
			obj = new ExposedObject("modificationDate");
			obj.isReadOnly = true;
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("name"))
		{
			str = new ExposedString("name");
			str.isReadOnly = true;
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("size"))
		{
			floatDrag = new ExposedFloatDrag("size");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("type"))
		{
			str = new ExposedString("type");
			str.isReadOnly = true;
			collection.addValue(str, groupName);
		}
		
		return collection;
	}
	
}