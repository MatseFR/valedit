package valedit.data.starling.utils;
import starling.utils.Padding;
import valedit.ExposedCollection;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedFunction;
import valedit.value.ExposedObjectReference;

/**
 * ...
 * @author Matse
 */
class StarlingUtilsData 
{

	static public function exposePadding(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var func:ExposedFunction;
		var objectRef:ExposedObjectReference;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("bottom"))
		{
			floatDrag = new ExposedFloatDrag("bottom");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("left"))
		{
			floatDrag = new ExposedFloatDrag("left");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("right"))
		{
			floatDrag = new ExposedFloatDrag("right");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("top"))
		{
			floatDrag = new ExposedFloatDrag("top");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("copyFrom"))
		{
			func = new ExposedFunction("copyFrom");
			objectRef = new ExposedObjectReference("padding");
			objectRef.addClass(Padding);
			func.addParameter(objectRef);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("setToSymmetric"))
		{
			func = new ExposedFunction("setToSymmetric");
			floatDrag = new ExposedFloatDrag("horizontal");
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("vertical");
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("setToUniform"))
		{
			func = new ExposedFunction("setToUniform");
			floatDrag = new ExposedFloatDrag("value");
			func.addParameter(floatDrag);
			collection.addValue(func);
		}
		
		return collection;
	}
	
}