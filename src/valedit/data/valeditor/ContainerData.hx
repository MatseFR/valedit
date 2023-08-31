package valedit.data.valeditor;
import juggler.animation.Transitions;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedSelect;

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
		var intDrag:ExposedIntDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("autoPlay"))
		{
			bool = new ExposedBool("autoPlay");
			collection.addValue(bool, groupName);
		}
		
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
		
		if (!collection.hasValue("frameRate"))
		{
			floatDrag = new ExposedFloatDrag("frameRate");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("numFrames"))
		{
			intDrag = new ExposedIntDrag("numFrames", null, 1, null, 1, 1, true, false);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("frameIndex"))
		{
			intDrag = new ExposedIntDrag("frameIndex");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("loop"))
		{
			bool = new ExposedBool("loop");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("reverse"))
		{
			bool = new ExposedBool("reverse");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("numLoops"))
		{
			intDrag = new ExposedIntDrag("numLoops", null, 0);
			collection.addValue(intDrag, groupName);
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
	
	static public function exposeValEditKeyFrame(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("tween"))
		{
			bool = new ExposedBool("tween");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("transition"))
		{
			select = new ExposedSelect("transition", null, Transitions.transitionNames, Transitions.transitionNames);
			collection.addValue(select, groupName);
		}
		
		return collection;
	}
	
	static public function exposeValEditorKeyFrame(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeValEditKeyFrame(collection, groupName);
		
		return collection;
	}
	
}