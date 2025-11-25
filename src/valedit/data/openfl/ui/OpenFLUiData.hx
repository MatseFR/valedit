package valedit.data.openfl.ui;
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
class OpenFLUiData 
{

	static public function exposeGameInputControl(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var obj:ExposedObject;
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("device"))
		{
			obj = new ExposedObject("device");
			obj.isReadOnly = true;
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("id"))
		{
			str = new ExposedString("id");
			str.isReadOnly = true;
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("maxValue"))
		{
			floatDrag = new ExposedFloatDrag("maxValue");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("minValue"))
		{
			floatDrag = new ExposedFloatDrag("minValue");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("value"))
		{
			floatDrag = new ExposedFloatDrag("value");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeGameInputDevice(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var intDrag:ExposedIntDrag;
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("enabled"))
		{
			bool = new ExposedBool("enabled");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("id"))
		{
			str = new ExposedString("id");
			str.isReadOnly = true;
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("name"))
		{
			str = new ExposedString("name");
			str.isReadOnly = true;
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("numControls"))
		{
			intDrag = new ExposedIntDrag("numControls");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("sampleInterval"))
		{
			intDrag = new ExposedIntDrag("sampleInterval", null, 0);
			collection.addValue(intDrag, groupName);
		}
		
		return collection;
	}
	
}