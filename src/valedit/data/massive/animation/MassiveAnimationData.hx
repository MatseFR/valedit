package valedit.data.massive.animation;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObjectReference;
import valedit.value.ExposedString;

/**
 * ...
 * @author Matse
 */
class MassiveAnimationData 
{
	
	static public function exposeAnimation(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("id"))
		{
			str = new ExposedString("id");
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("duration"))
		{
			floatDrag = new ExposedFloatDrag("duration");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("numFrames"))
		{
			intDrag = new ExposedIntDrag("numFrames");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("loop"))
		{
			bool = new ExposedBool("loop");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("numLoops"))
		{
			intDrag = new ExposedIntDrag("numLoops", null, 0);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("loopFrame"))
		{
			intDrag = new ExposedIntDrag("loopFrame", null, 0);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("nextAnimationID"))
		{
			str = new ExposedString("nextAnimationID");
			collection.addValue(str, groupName);
		}
		
		return collection;
	}

	static public function exposeAnimationFrame(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var objectRef:ExposedObjectReference;
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("frame"))
		{
			objectRef = new ExposedObjectReference("frame");
			objectRef.allowClass(massive.data.Frame);
			collection.addValue(objectRef, groupName);
		}
		
		if (!collection.hasValue("timing"))
		{
			floatDrag = new ExposedFloatDrag("timing", null, 0, null, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("event"))
		{
			str = new ExposedString("event");
			collection.addValue(str, groupName)
		}
		
		return collection;
	}
	
}