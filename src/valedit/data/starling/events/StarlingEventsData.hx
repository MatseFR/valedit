package valedit.data.starling.events;
import starling.display.DisplayObject;
import starling.events.TouchPhase;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObject;
import valedit.value.ExposedObjectReference;
import valedit.value.ExposedSelect;

/**
 * ...
 * @author Matse
 */
class StarlingEventsData 
{

	static public function exposeTouch(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var obj:ExposedObject;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("cancelled"))
		{
			bool = new ExposedBool("cancelled");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("duration"))
		{
			floatDrag = new ExposedFloatDrag("duration");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("globalX"))
		{
			floatDrag = new ExposedFloatDrag("globalX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("globalY"))
		{
			floatDrag = new ExposedFloatDrag("globalY");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			floatDrag = new ExposedFloatDrag("height");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("id"))
		{
			intDrag = new ExposedIntDrag("id");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("phase"))
		{
			select = new ExposedSelect("phase");
			select.add(TouchPhase.BEGAN);
			select.add(TouchPhase.ENDED);
			select.add(TouchPhase.HOVER);
			select.add(TouchPhase.MOVED);
			select.add(TouchPhase.STATIONARY);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("pressure"))
		{
			floatDrag = new ExposedFloatDrag("pressure", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("previousGlobalX"))
		{
			floatDrag = new ExposedFloatDrag("previousGlobalX");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("previousGlobalY"))
		{
			floatDrag = new ExposedFloatDrag("previousGlobalY");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("startGlobalX"))
		{
			floatDrag = new ExposedFloatDrag("startGlobalX");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("startGlobalY"))
		{
			floatDrag = new ExposedFloatDrag("startGlobalY");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("tapCount"))
		{
			intDrag = new ExposedIntDrag("tapCount", null, 0);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("target"))
		{
			obj = new ExposedObject("target");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("timeStamp"))
		{
			floatDrag = new ExposedFloatDrag("timeStamp");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("width"))
		{
			floatDrag = new ExposedFloatDrag("width");
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTouchData(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("globalX"))
		{
			floatDrag = new ExposedFloatDrag("globalX");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("globalY"))
		{
			floatDrag = new ExposedFloatDrag("globalY");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			floatDrag = new ExposedFloatDrag("height");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("id"))
		{
			intDrag = new ExposedIntDrag("id");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("phase"))
		{
			select = new ExposedSelect("phase");
			select.isReadOnly = true;
			select.add(TouchPhase.BEGAN);
			select.add(TouchPhase.ENDED);
			select.add(TouchPhase.HOVER);
			select.add(TouchPhase.MOVED);
			select.add(TouchPhase.STATIONARY);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("pressure"))
		{
			floatDrag = new ExposedFloatDrag("pressure");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("width"))
		{
			floatDrag = new ExposedFloatDrag("width");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTouchProcessor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var obj:ExposedObject;
		var objRef:ExposedObjectReference;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("discardSystemGestures"))
		{
			bool = new ExposedBool("discardSystemGestures");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("multiTapDistance"))
		{
			floatDrag = new ExposedFloatDrag("multiTapDistance", null, 0.0);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("multiTapTime"))
		{
			floatDrag = new ExposedFloatDrag("multiTapTime", null, 0.0, 3.0, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("numCurrentTouches"))
		{
			intDrag = new ExposedIntDrag("numCurrentTouches");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("root"))
		{
			objRef = new ExposedObjectReference("root");
			objRef.allowClass(DisplayObject);
			collection.addValue(objRef);
		}
		
		if (!collection.hasValue("simulateMultiTouch"))
		{
			bool = new ExposedBool("simulateMultiTouch");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("stage"))
		{
			obj = new ExposedObject("stage");
			collection.addValue(obj, groupName);
		}
		
		return collection;
	}
	
}