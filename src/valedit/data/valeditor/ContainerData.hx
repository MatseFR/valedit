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
	
	static private function exposeContainer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
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
		
		if (!collection.hasValue("width"))
		{
			floatDrag = new ExposedFloatDrag("width");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			floatDrag = new ExposedFloatDrag("height");
			collection.addValue(floatDrag, groupName);
		}
		
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
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, 0, 1, 0.005);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("visible"))
		{
			bool = new ExposedBool("visible");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static private function getContainerVisibilities(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = new ClassVisibilityCollection();
		
		if (!collection.has("x")) collection.add(ClassValueVisibility.fromPool("x"));
		if (!collection.has("y")) collection.add(ClassValueVisibility.fromPool("y"));
		if (!collection.has("width")) collection.add(ClassValueVisibility.fromPool("width"));
		if (!collection.has("height")) collection.add(ClassValueVisibility.fromPool("height"));
		if (!collection.has("scaleX")) collection.add(ClassValueVisibility.fromPool("scaleX"));
		if (!collection.has("scaleY")) collection.add(ClassValueVisibility.fromPool("scaleY"));
		if (!collection.has("alpha")) collection.add(ClassValueVisibility.fromPool("alpha"));
		if (!collection.has("visible")) collection.add(ClassValueVisibility.fromPool("visible"));
		
		return collection;
	}
	
	static private function exposeContainerStarling2D(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("rotation"))
		{
			floatDrag = new ExposedFloatDrag("rotation", null, null, null, 0.01);
			floatDrag.isAbsolute = true;
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static private function getContainerStarling2DVisibilities(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = new ClassVisibilityCollection();
		
		if (!collection.has("rotation")) collection.add(ClassValueVisibility.fromPool("rotation"));
		
		return collection;
	}
	
	#if starling
	static private function exposeContainerStarling3D(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("z"))
		{
			floatDrag = new ExposedFloatDrag("z");
			collection.addValueAfter(floatDrag, "y", groupName);
		}
		
		if (!collection.hasValue("rotationX"))
		{
			floatDrag = new ExposedFloatDrag("rotationX", null, null, null, 0.01);
			floatDrag.isAbsolute = true;
			collection.addValueAfter(floatDrag, "height", groupName);
		}
		
		if (!collection.hasValue("rotationY"))
		{
			floatDrag = new ExposedFloatDrag("rotationY", null, null, null, 0.01);
			floatDrag.isAbsolute = true;
			collection.addValueAfter(floatDrag, "rotationX", groupName);
		}
		
		if (!collection.hasValue("rotationZ"))
		{
			floatDrag = new ExposedFloatDrag("rotationZ", null, null, null, 0.01);
			floatDrag.isAbsolute = true;
			collection.addValueAfter(floatDrag, "rotationY", groupName);
		}
		
		if (!collection.hasValue("scaleZ"))
		{
			floatDrag = new ExposedFloatDrag("scaleZ", null, null, null, 0.05);
			collection.addValueAfter(floatDrag, "scaleY", groupName);
		}
		
		//if (!collection.hasValue("pivotZ"))
		//{
			//floatDrag = new ExposedFloatDrag("pivotZ");
			//collection.addValueAfter(floatDrag, "pivotY", groupName);
		//}
		
		return collection;
	}
	
	static private function getContainerStarling3DVisibilities(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = new ClassVisibilityCollection();
		
		if (!collection.has("z")) collection.add(ClassValueVisibility.fromPool("z"));
		if (!collection.has("rotationX")) collection.add(ClassValueVisibility.fromPool("rotationX"));
		if (!collection.has("rotationY")) collection.add(ClassValueVisibility.fromPool("rotationY"));
		if (!collection.has("rotationZ")) collection.add(ClassValueVisibility.fromPool("rotationZ"));
		if (!collection.has("scaleZ")) collection.add(ClassValueVisibility.fromPool("scaleZ"));
		
		return collection;
	}
	#end
	
	static private function exposeContainerOpenFL(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("rotation"))
		{
			floatDrag = new ExposedFloatDrag("rotation", null, null, null, 0.5);
			floatDrag.isAbsolute = true;
			collection.addValueAfter(floatDrag, "height", groupName);
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
			collection.addValueAfter(select, "alpha", groupName);
		}
		
		return collection;
	}
	
	static private function getContainerOpenFLVisibilities(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = new ClassVisibilityCollection();
		
		if (!collection.has("rotation")) collection.add(ClassValueVisibility.fromPool("rotation"));
		if (!collection.has("blendMode")) collection.add(ClassValueVisibility.fromPool("blendMode"));
		
		return collection;
	}
	
	#if starling
	static private function exposeContainerOpenFLStarling(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("rotation"))
		{
			floatDrag = new ExposedFloatDrag("rotation", null, null, null, 0.5);
			floatDrag.isAbsolute = true;
			collection.addValueAfter(floatDrag, "height", groupName);
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
			collection.addValueAfter(select, "alpha", groupName);
		}
		
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
			collection.addValueAfter(select, "blendMode", groupName);
		}
		
		return collection;
	}
	
	static private function getContainerOpenFLStarlingVisibilities(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = new ClassVisibilityCollection();
		
		if (!collection.has("rotation")) collection.add(ClassValueVisibility.fromPool("rotation"));
		if (!collection.has("blendMode")) collection.add(ClassValueVisibility.fromPool("blendMode"));
		if (!collection.has("blendModeStarling")) collection.add(ClassValueVisibility.fromPool("blendModeStarling"));
		
		return collection;
	}
	#end
	
	#if starling
	static private function exposeContainerStarling(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("blendMode"))
		{
			select = new ExposedSelect("blendMode");
			select.add("ADD", starling.display.BlendMode.ADD);
			select.add("AUTO", starling.display.BlendMode.AUTO);
			select.add("BELOW", starling.display.BlendMode.BELOW);
			select.add("ERASE", starling.display.BlendMode.ERASE);
			select.add("MASK", starling.display.BlendMode.MASK);
			select.add("MULTIPLY", starling.display.BlendMode.MULTIPLY);
			select.add("NONE", starling.display.BlendMode.NONE);
			select.add("NORMAL", starling.display.BlendMode.NORMAL);
			select.add("SCREEN", starling.display.BlendMode.SCREEN);
			collection.addValueAfter(select, "alpha", groupName);
		}
		
		return collection;
	}
	
	static private function getContainerStarlingVisibilities(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = new ClassVisibilityCollection();
		
		if (!collection.has("blendMode")) collection.add(ClassValueVisibility.fromPool("blendMode"));
		
		return collection;
	}
	#end
	
	static private function exposeContainerTimeLine(?collection:ExposedCollection, ?groupName:String):ExposedCollection
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
		
		return collection;
	}
	
	static private function getContainerTimeLineVisibilities(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = new ClassVisibilityCollection();
		
		if (!collection.has("autoPlay")) collection.add(ClassValueVisibility.fromPool("autoPlay"));
		if (!collection.has("frameRate")) collection.add(ClassValueVisibility.fromPool("frameRate"));
		if (!collection.has("numFrames")) collection.add(ClassValueVisibility.fromPool("numFrames"));
		if (!collection.has("loop")) collection.add(ClassValueVisibility.fromPool("loop"));
		if (!collection.has("reverse")) collection.add(ClassValueVisibility.fromPool("reverse"));
		if (!collection.has("numLoops")) collection.add(ClassValueVisibility.fromPool("numLoops"));
		
		return collection;
	}
	
	static public function exposeSpriteContainerOpenFL(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeContainer(collection, groupName);
		exposeContainerOpenFL(collection, groupName);
		
		return collection;
	}
	
	static public function getSpriteContainerOpenFLVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getContainerVisibilities(collection);
		getContainerOpenFLVisibilities(collection);
		
		return collection;
	}
	
	#if valeditor
	static public function exposeSpriteContainerOpenFLEditable(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeSpriteContainerOpenFL(collection, groupName);
		
		return collection;
	}
	
	static public function getSpriteContainerOpenFLEditableVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = new ClassVisibilityCollection();
		
		getSpriteContainerOpenFLVisibility(collection);
		
		return collection;
	}
	#end
	
	#if starling
	static public function exposeSpriteContainerStarling(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeContainer(collection, groupName);
		exposeContainerStarling(collection, groupName);
		exposeContainerStarling2D(collection, groupName);
		
		return collection;
	}
	
	static public function getSpriteContainerStarlingVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getContainerVisibilities(collection);
		getContainerStarlingVisibilities(collection);
		getContainerStarling2DVisibilities(collection);
		
		return collection;
	}
	
	#if valeditor
	static public function exposeSpriteContainerStarlingEditable(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeSpriteContainerStarling(collection, groupName);
		
		return collection;
	}
	
	static public function getSpriteContainerStarlingEditableVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = new ClassVisibilityCollection();
		
		getSpriteContainerStarlingVisibility(collection);
		
		return collection;
	}
	#end
	#end
	
	#if starling
	static public function exposeSpriteContainerStarling3D(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeContainer(collection, groupName);
		exposeContainerStarling(collection, groupName);
		exposeContainerStarling3D(collection, groupName);
		
		return collection;
	}
	
	static public function getSpriteContainerStarling3DVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getContainerVisibilities(collection);
		getContainerStarlingVisibilities(collection);
		getContainerStarling3DVisibilities(collection);
		
		return collection;
	}
	
	#if valeditor
	static public function exposeSpriteContainerStarling3DEditable(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeSpriteContainerStarling3D(collection, groupName);
		
		return collection;
	}
	
	static public function getSpriteContainerStarling3DEditableVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = new ClassVisibilityCollection();
		
		getSpriteContainerStarling3DVisibility(collection);
		
		return collection;
	}
	#end
	#end
	
	#if starling
	static public function exposeTimeLineContainerOpenFLStarling(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeContainer(collection, groupName);
		exposeContainerOpenFLStarling(collection, groupName);
		exposeContainerTimeLine(collection, groupName);
		
		return collection;
	}
	
	static public function getTimeLineContainerOpenFLStarlingVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getContainerVisibilities(collection);
		getContainerOpenFLStarlingVisibilities(collection);
		getContainerTimeLineVisibilities(collection);
		
		return collection;
	}
	
	#if valeditor
	static public function exposeTimeLineContainerOpenFLStarlingEditable(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeTimeLineContainerOpenFLStarling(collection, groupName);
		
		return collection;
	}
	
	static public function getTimeLineContainerOpenFLStarlingEditableVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getTimeLineContainerOpenFLStarlingVisibility(collection);
		
		return collection;
	}
	#end
	#end
	
	static public function exposeTimeLineContainerOpenFL(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeContainer(collection, groupName);
		exposeContainerOpenFL(collection, groupName);
		exposeContainerTimeLine(collection, groupName);
		
		return collection;
	}
	
	static public function getTimeLineContainerOpenFLVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = new ClassVisibilityCollection();
		
		getContainerVisibilities(collection);
		getContainerOpenFLVisibilities(collection);
		getContainerTimeLineVisibilities(collection);
		
		return collection;
	}
	
	#if valeditor
	static public function exposeTimeLineContainerOpenFLEditable(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeTimeLineContainerOpenFL(collection, groupName);
		
		return collection;
	}
	
	static public function getTimeLineContainerOpenFLEditableVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = new ClassVisibilityCollection();
		
		getTimeLineContainerOpenFLVisibility(collection);
		
		return collection;
	}
	#end
	
	#if starling
	static public function exposeTimeLineContainerStarling(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeContainer(collection, groupName);
		exposeContainerStarling(collection, groupName);
		exposeContainerStarling2D(collection, groupName);
		exposeContainerTimeLine(collection, groupName);
		
		return collection;
	}
	
	static public function getTimeLineContainerStarlingVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = new ClassVisibilityCollection();
		
		getContainerVisibilities(collection);
		getContainerStarlingVisibilities(collection);
		getContainerStarling2DVisibilities(collection);
		getContainerTimeLineVisibilities(collection);
		
		return collection;
	}
	
	#if valeditor
	static public function exposeTimeLineContainerStarlingEditable(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeTimeLineContainerStarling(collection, groupName);
		
		return collection;
	}
	
	static public function getTimeLineContainerStarlingEditableVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = new ClassVisibilityCollection();
		
		getTimeLineContainerStarlingVisibility(collection);
		
		return collection;
	}
	#end
	#end
	
	#if starling
	static public function exposeTimeLineContainerStarling3D(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeContainer(collection, groupName);
		exposeContainerStarling(collection, groupName);
		exposeContainerStarling3D(collection, groupName);
		exposeContainerTimeLine(collection, groupName);
		
		return collection;
	}
	
	static public function getTimeLineContainerStarling3DVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = new ClassVisibilityCollection();
		
		getContainerVisibilities(collection);
		getContainerStarlingVisibilities(collection);
		getContainerStarling3DVisibilities(collection);
		getContainerTimeLineVisibilities(collection);
		
		return collection;
	}
	
	#if valeditor
	static public function exposeTimeLineContainerStarling3DEditable(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeTimeLineContainerStarling3D(collection, groupName);
		
		return collection;
	}
	
	static public function getTimeLineContainerStarling3DEditableVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = new ClassVisibilityCollection();
		
		getTimeLineContainerStarling3DVisibility(collection);
		
		return collection;
	}
	#end
	#end
	
	static public function exposeValEditorContainerRoot(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		var value:ExposedValue;
		
		exposeTimeLineContainerOpenFLStarlingEditable(collection, groupName);
		
		value = collection.getValue("alpha");
		collection.removeValue(value);
		value.pool();
		
		value = collection.getValue("x");
		value.visible = false;
		
		value = collection.getValue("y");
		value.visible = false;
		
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
		
		getTimeLineContainerOpenFLStarlingEditableVisibility(collection);
		
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