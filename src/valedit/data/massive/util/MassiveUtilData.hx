package valedit.data.massive.util;
import valedit.ExposedCollection;
import valedit.value.ExposedFloatDrag;

/**
 * ...
 * @author Matse
 */
class MassiveUtilData 
{

	static public function exposeMassiveTint(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("red"))
		{
			floatDrag = new ExposedFloatDrag("red", null, -10.0, 10.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("green"))
		{
			floatDrag = new ExposedFloatDrag("green", null, -10.0, 10.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blue"))
		{
			floatDrag = new ExposedFloatDrag("blue", null, -10.0, 10.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, -10.0, 10.0, 0.005);
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
}