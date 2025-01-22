package valedit.data.valeditor;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedIntDrag;

/**
 * ...
 * @author Matse
 */
class ValEditorObjectData 
{

	static public function exposeValEditorObject(collection:ExposedCollection = null, groupName:String = null):ExposedCollection
	{
		var bool:ExposedBool;
		var intDrag:ExposedIntDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		intDrag = new ExposedIntDrag("numKeyFrames");
		intDrag.isReadOnly = true;
		collection.addValue(intDrag, groupName);
		
		bool = new ExposedBool("isExternal");
		bool.isReadOnly = true;
		collection.addValue(bool, groupName);
		
		bool = new ExposedBool("destroyOnCompletion");
		collection.addValue(bool, groupName);
		
		bool = new ExposedBool("restoreValuesOnCompletion");
		collection.addValue(bool, groupName);
		
		return collection;
	}
	
}