package valedit.data.starling.extensions;
import valedit.value.ExposedFloatDrag;

/**
 * ...
 * @author Matse
 */
class StarlingColorArgbData 
{

	static public function exposeColorArgb(collection:ExposedCollection = null, groupName:String = null):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		floatDrag = new ExposedFloatDrag("red", null, 0.0, 1.0, 0.01);
		collection.addValue(floatDrag, groupName);
		
		floatDrag = new ExposedFloatDrag("green", null, 0.0, 1.0, 0.01);
		collection.addValue(floatDrag, groupName);
		
		floatDrag = new ExposedFloatDrag("blue", null, 0.0, 1.0, 0.01);
		collection.addValue(floatDrag, groupName);
		
		floatDrag = new ExposedFloatDrag("alpha", null, 0.0, 1.0, 0.01);
		collection.addValue(floatDrag, groupName);
		
		return collection;
	}
	
}