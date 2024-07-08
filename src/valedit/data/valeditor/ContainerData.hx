package valedit.data.valeditor;
import juggler.animation.Transitions;
import openfl.display.BlendMode;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloat;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedSelect;
import valedit.value.base.ExposedValue;
import valeditor.editor.visibility.ClassValueVisibility;
import valeditor.editor.visibility.ClassVisibilityCollection;

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
		var select:ExposedSelect;
		
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
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, 0, 1, 0.005);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("rotation"))
		{
			floatDrag = new ExposedFloatDrag("rotation", null, null, null, 0.5);
			floatDrag.isAbsolute = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blendMode"))
		{
			select = new ExposedSelect("blendMode");
			select.add("ADD", BlendMode.ADD);
			select.add("ALPHA", BlendMode.ALPHA);
			select.add("DARKEN", BlendMode.DARKEN);
			select.add("DIFFERENCE", BlendMode.DIFFERENCE);
			select.add("ERASE", BlendMode.ERASE);
			select.add("HARDLIGHT", BlendMode.HARDLIGHT);
			select.add("INVERT", BlendMode.INVERT);
			select.add("LAYER", BlendMode.LAYER);
			select.add("LIGHTEN", BlendMode.LIGHTEN);
			select.add("MULTIPLY", BlendMode.MULTIPLY);
			select.add("NORMAL", BlendMode.NORMAL);
			select.add("OVERLAY", BlendMode.OVERLAY);
			select.add("SCREEN", BlendMode.SCREEN);
			select.add("SHADER", BlendMode.SHADER);
			select.add("SUBTRACT", BlendMode.SUBTRACT);
			collection.addValue(select, groupName);
		}
		
		#if starling
		if (!collection.hasValue("blendModeStarling"))
		{
			select = new ExposedSelect("blendModeStarling");
			select.add("ADD", starling.display.BlendMode.ADD);
			select.add("AUTO", starling.display.BlendMode.AUTO);
			select.add("BELOW", starling.display.BlendMode.BELOW);
			select.add("ERASE", starling.display.BlendMode.ERASE);
			select.add("MASK", starling.display.BlendMode.MASK);
			select.add("MULTIPLY", starling.display.BlendMode.MULTIPLY);
			select.add("NONE", starling.display.BlendMode.NONE);
			select.add("NORMAL", starling.display.BlendMode.NORMAL);
			select.add("SCREEN", starling.display.BlendMode.SCREEN);
			collection.addValue(select, groupName);
		}
		#end
		
		if (!collection.hasValue("scaleX"))
		{
			floatDrag = new ExposedFloatDrag("scaleX", null, null, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("scaleY"))
		{
			floatDrag = new ExposedFloatDrag("scaleY", null, null, null, 0.05);
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
		
		//if (!collection.hasValue("frameIndex"))
		//{
			//intDrag = new ExposedIntDrag("frameIndex", null, 0);
			//collection.addValue(intDrag, groupName);
		//}
		
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
	
	static public function getValEditContainerVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		collection.add(ClassValueVisibility.fromPool("autoPlay"));
		collection.add(ClassValueVisibility.fromPool("cameraX"));
		collection.add(ClassValueVisibility.fromPool("cameraY"));
		collection.add(ClassValueVisibility.fromPool("x"));
		collection.add(ClassValueVisibility.fromPool("y"));
		collection.add(ClassValueVisibility.fromPool("alpha"));
		collection.add(ClassValueVisibility.fromPool("rotation"));
		collection.add(ClassValueVisibility.fromPool("blendMode"));
		#if starling
		collection.add(ClassValueVisibility.fromPool("blendModeStarling"));
		#end
		collection.add(ClassValueVisibility.fromPool("scaleX"));
		collection.add(ClassValueVisibility.fromPool("scaleY"));
		collection.add(ClassValueVisibility.fromPool("frameRate"));
		collection.add(ClassValueVisibility.fromPool("numFrames"));
		//collection.add(ClassValueVisibility.fromPool("frameIndex"));
		collection.add(ClassValueVisibility.fromPool("numFrames"));
		collection.add(ClassValueVisibility.fromPool("loop"));
		collection.add(ClassValueVisibility.fromPool("reverse"));
		collection.add(ClassValueVisibility.fromPool("numLoops"));
		collection.add(ClassValueVisibility.fromPool("visible"));
		
		return collection;
	}
	
	static public function exposeValEditorContainer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeValEditContainer(collection, groupName);
		
		return collection;
	}
	
	static public function getValEditorContainerVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getValEditContainerVisibility(collection);
		
		return collection;
	}
	
	static public function exposeValEditorContainerRoot(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		var value:ExposedValue;
		
		exposeValEditorContainer(collection, groupName);
		
		value = collection.getValue("alpha");
		collection.removeValue(value);
		value.pool();
		
		value = collection.getValue("x");
		collection.removeValue(value);
		value.pool();
		
		value = collection.getValue("y");
		collection.removeValue(value);
		value.pool();
		
		value = collection.getValue("rotation");
		collection.removeValue(value);
		value.pool();
		
		value = collection.getValue("blendMode");
		collection.removeValue(value);
		value.pool();
		
		#if starling
		value = collection.getValue("blendModeStarling");
		collection.removeValue(value);
		value.pool();
		#end
		
		value = collection.getValue("scaleX");
		collection.removeValue(value);
		value.pool();
		
		value = collection.getValue("scaleY");
		collection.removeValue(value);
		value.pool();
		
		value = collection.getValue("visible");
		collection.removeValue(value);
		value.pool();
		
		return collection;
	}
	
	static public function getValEditorContainerRootVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		var visibility:ClassValueVisibility;
		
		getValEditorContainerVisibility(collection);
		
		visibility = collection.get("alpha");
		collection.remove(visibility);
		visibility.pool();
		
		visibility = collection.get("x");
		collection.remove(visibility);
		visibility.pool();
		
		visibility = collection.get("y");
		collection.remove(visibility);
		visibility.pool();
		
		visibility = collection.get("rotation");
		collection.remove(visibility);
		visibility.pool();
		
		visibility = collection.get("blendMode");
		collection.remove(visibility);
		visibility.pool();
		
		#if starling
		visibility = collection.get("blendModeStarling");
		collection.remove(visibility);
		visibility.pool();
		#end
		
		visibility = collection.get("scaleX");
		collection.remove(visibility);
		visibility.pool();
		
		visibility = collection.get("scaleY");
		collection.remove(visibility);
		visibility.pool();
		
		visibility = collection.get("visible");
		collection.remove(visibility);
		visibility.pool();
		
		return collection;
	}
	
	static public function exposeValEditKeyFrame(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var float:ExposedFloat;
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
		
		if (!collection.hasValue("duration"))
		{
			float = new ExposedFloat("duration", null, 4);
			float.isReadOnly = true;
			collection.addValue(float, groupName);
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