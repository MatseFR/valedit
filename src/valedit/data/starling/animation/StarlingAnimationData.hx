package valedit.data.starling.animation;
import starling.animation.Transitions;
import starling.animation.Tween;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObjectReference;
import valedit.value.ExposedSelect;

/**
 * ...
 * @author Matse
 */
class StarlingAnimationData 
{
	static public function exposeDelayedCall(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("currentTime"))
		{
			floatDrag = new ExposedFloatDrag("currentTime");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("isComplete"))
		{
			bool = new ExposedBool("isComplete");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("repeatCount"))
		{
			intDrag = new ExposedIntDrag("repeatCount");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("totalTime"))
		{
			floatDrag = new ExposedFloatDrag("totalTime");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeJuggler(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("timeScale"))
		{
			floatDrag = new ExposedFloatDrag("timeScale", null, null, null, 0.25);
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTween(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var objRef:ExposedObjectReference;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("currentTime"))
		{
			floatDrag = new ExposedFloatDrag("currentTime");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("delay"))
		{
			floatDrag = new ExposedFloatDrag("delay", null, 0.0, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("isComplete"))
		{
			bool = new ExposedBool("isComplete");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("nextTween"))
		{
			objRef = new ExposedObjectReference("nextTween");
			objRef.allowClass(Tween);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("progress"))
		{
			floatDrag = new ExposedFloatDrag("progress");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("repeatCount"))
		{
			intDrag = new ExposedIntDrag("repeatCount");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("repeatDelay"))
		{
			floatDrag = new ExposedFloatDrag("repeatDelay", null, 0.0, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("reverse"))
		{
			bool = new ExposedBool("reverse");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("roundToInt"))
		{
			bool = new ExposedBool("roundToInt");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("target"))
		{
			objRef = new ExposedObjectReference("target");
			objRef.isReadOnly = true;
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("totalTime"))
		{
			floatDrag = new ExposedFloatDrag("totalTime");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("transition"))
		{
			select = new ExposedSelect("transition");
			select.add(Transitions.EASE_IN);
			select.add(Transitions.EASE_IN_BACK);
			select.add(Transitions.EASE_IN_BOUNCE);
			select.add(Transitions.EASE_IN_ELASTIC);
			select.add(Transitions.EASE_IN_OUT);
			select.add(Transitions.EASE_IN_OUT_BACK);
			select.add(Transitions.EASE_IN_OUT_BOUNCE);
			select.add(Transitions.EASE_IN_OUT_ELASTIC);
			select.add(Transitions.EASE_OUT);
			select.add(Transitions.EASE_OUT_BACK);
			select.add(Transitions.EASE_OUT_BOUNCE);
			select.add(Transitions.EASE_OUT_ELASTIC);
			select.add(Transitions.EASE_OUT_IN);
			select.add(Transitions.EASE_OUT_IN_BACK);
			select.add(Transitions.EASE_OUT_IN_BOUNCE);
			select.add(Transitions.EASE_OUT_IN_ELASTIC);
			collection.addValue(select, groupName);
		}
		
		return collection;
	}
	
}