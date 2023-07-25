package valedit.data.valeditor;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloatDrag;

/**
 * ...
 * @author Matse
 */
class ContainerData 
{

	static public function exposeValEditContainer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("cameraX"))
		{
			floatDrag = new ExposedFloatDrag("cameraX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("cameraY"))
		{
			floatDrag = new ExposedFloatDrag("cameraY");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("x"))
		{
			floatDrag = new ExposedFloatDrag("x");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("y"))
		{
			floatDrag = new ExposedFloatDrag("y");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("visible"))
		{
			bool = new ExposedBool("visible");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeValEditorContainer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeValEditContainer(collection, groupName);
		
		return collection;
	}
	
	static public function exposeValEditFrame(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		return collection;
	}
	
	static public function exposeValEditKeyFrame(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeValEditFrame(collection, groupName);
		
		return collection;
	}
	
	static public function exposeValEditorKeyFrame(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeValEditKeyFrame(collection, groupName);
		
		return collection;
	}
	
}