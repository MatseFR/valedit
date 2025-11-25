package valedit.data.starling.display;
#if starling
import starling.display.ButtonState;
import starling.display.Mesh;
import starling.geom.Polygon;
import starling.display.BlendMode;
import starling.display.DisplayObject;
import starling.textures.TextureSmoothing;
import starling.utils.Align;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedFunction;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedNote;
import valedit.value.ExposedObject;
import valedit.value.ExposedObjectReference;
import valedit.value.ExposedSelect;
import valedit.value.ExposedString;
import valedit.value.extra.FunctionCallExtra;
import valedit.value.starling.ExposedStarlingTexture;
import valeditor.editor.visibility.ClassValueVisibility;
import valeditor.editor.visibility.ClassVisibilityCollection;

/**
 * ...
 * @author Matse
 */
class StarlingDisplayData 
{
	
	static public function exposeButton(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var func:ExposedFunction;
		var obj:ExposedObject;
		var select:ExposedSelect;
		var str:ExposedString;
		var texture:ExposedStarlingTexture;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObjectContainer(collection, groupName);
		
		if (!collection.hasValue("abortDistance"))
		{
			floatDrag = new ExposedFloatDrag("abortDistance", null, 0.0);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alphaWhenDisabled"))
		{
			floatDrag = new ExposedFloatDrag("alphaWhenDisabled", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alphaWhenDown"))
		{
			floatDrag = new ExposedFloatDrag("alphaWhenDown", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("disabledState"))
		{
			texture = new ExposedStarlingTexture("disabledState");
			collection.addValue(texture, groupName);
		}
		
		if (!collection.hasValue("downState"))
		{
			texture = new ExposedStarlingTexture("downState");
			collection.addValue(texture, groupName);
		}
		
		if (!collection.hasValue("enabled"))
		{
			bool = new ExposedBool("enabled");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("minHitAreaSize"))
		{
			floatDrag = new ExposedFloatDrag("minHitAreaSize");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("overlay"))
		{
			obj = new ExposedObject("overlay");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("overState"))
		{
			texture = new ExposedStarlingTexture("overState");
			collection.addValue(texture, groupName);
		}
		
		if (!collection.hasValue("pixelSnapping"))
		{
			bool = new ExposedBool("pixelSnapping");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("scale9grid"))
		{
			obj = new ExposedObject("scale9grid");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("scaleWhenDown"))
		{
			floatDrag = new ExposedFloatDrag("scaleWhenDown");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("scaleWhenOver"))
		{
			floatDrag = new ExposedFloatDrag("scaleWhenOver");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("state"))
		{
			select = new ExposedSelect("state");
			select.add(ButtonState.DISABLED);
			select.add(ButtonState.DOWN);
			select.add(ButtonState.OVER);
			select.add(ButtonState.UP);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("style"))
		{
			obj = new ExposedObject("style");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("text"))
		{
			str = new ExposedString("text");
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("textBounds"))
		{
			obj = new ExposedObject("textBounds");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("textFormat"))
		{
			obj = new ExposedObject("textFormat");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("textStyle"))
		{
			obj = new ExposedObject("textStyle");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("textureSmoothing"))
		{
			select = new ExposedSelect("textureSmoothing");
			select.add(TextureSmoothing.NONE);
			select.add(TextureSmoothing.BILINEAR);
			select.add(TextureSmoothing.TRILINEAR);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("upState"))
		{
			texture = new ExposedStarlingTexture("upState");
			collection.addValue(texture, groupName);
		}
		
		if (!collection.hasValue("readjustSize"))
		{
			func = new ExposedFunction("readjustSize");
			collection.addValue(func, groupName);
		}
		
		return collection;
	}
	
	static public function exposeButtonConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var str:ExposedString;
		var texture:ExposedStarlingTexture;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("upState"))
		{
			texture = new ExposedStarlingTexture("upState");
			texture.isMandatory = true;
			collection.addValue(texture, groupName);
		}
		
		if (!collection.hasValue("text"))
		{
			str = new ExposedString("text");
			str.isMandatory = true;
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("downState"))
		{
			texture = new ExposedStarlingTexture("downState");
			collection.addValue(texture, groupName);
		}
		
		if (!collection.hasValue("overState"))
		{
			texture = new ExposedStarlingTexture("overState");
			collection.addValue(texture, groupName);
		}
		
		if (!collection.hasValue("disabledState"))
		{
			texture = new ExposedStarlingTexture("disabledState");
			collection.addValue(texture, groupName);
		}
		
		return collection;
	}
	
	static public function exposeCanvas(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var func:ExposedFunction;
		var intDrag:ExposedIntDrag;
		var objRef:ExposedObjectReference;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("beginFill"))
		{
			func = new ExposedFunction("beginFill");
			color = new ExposedColor("color");
			func.addParameter(color);
			floatDrag = new ExposedFloatDrag("alpha", null, 0.0, 1.0, 0.01);
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("endFill"))
		{
			func = new ExposedFunction("endFill");
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("clear"))
		{
			func = new ExposedFunction("clear");
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("drawCircle"))
		{
			func = new ExposedFunction("drawCircle");
			floatDrag = new ExposedFloatDrag("x");
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("y");
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("radius");
			func.addParameter(floatDrag);
			intDrag = new ExposedIntDrag("numSides", null, -1);
			func.addParameter(intDrag);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("drawEllipse"))
		{
			func = new ExposedFunction("drawEllipse");
			floatDrag = new ExposedFloatDrag("x");
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("y");
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("width");
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("height");
			func.addParameter(floatDrag);
			intDrag = new ExposedIntDrag("numSides", null, -1);
			func.addParameter(intDrag);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("drawPolygon"))
		{
			func = new ExposedFunction("drawPolygon");
			objRef = new ExposedObjectReference("polygon");
			objRef.allowClass(Polygon);
			func.addParameter(objRef);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("drawRectangle"))
		{
			func = new ExposedFunction("drawRectangle");
			floatDrag = new ExposedFloatDrag("x");
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("y");
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("width");
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("height");
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		return collection;
	}

	static public function exposeDisplayObject(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var func:ExposedFunction;
		//var object:ExposedObject;
		var objectRef:ExposedObjectReference;
		var select:ExposedSelect;
		var string:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("name"))
		{
			string = new ExposedString("name");
			collection.addValue(string, groupName);
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
		
		if (!collection.hasValue("width"))
		{
			floatDrag = new ExposedFloatDrag("width");
			floatDrag.isTweenable = false; // don't tween width since it will become messy with rotation, scaleX will be used instead
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			floatDrag = new ExposedFloatDrag("height");
			floatDrag.isTweenable = false; // don't tween height since it will become messy with rotation, scaleY will be used instead
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("pivotX"))
		{
			floatDrag = new ExposedFloatDrag("pivotX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("pivotY"))
		{
			floatDrag = new ExposedFloatDrag("pivotY");
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
		
		if (!collection.hasValue("rotation"))
		{
			floatDrag = new ExposedFloatDrag("rotation", null, null, null, 0.01);
			floatDrag.isAbsolute = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("skewX"))
		{
			floatDrag = new ExposedFloatDrag("skewX", null, null, null, 0.005, 0.001);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("skewY"))
		{
			floatDrag = new ExposedFloatDrag("skewY", null, null, null, 0.005, 0.001);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blendMode"))
		{
			select = new ExposedSelect("blendMode");
			select.add(BlendMode.ADD);
			select.add(BlendMode.AUTO);
			select.add(BlendMode.BELOW);
			select.add(BlendMode.ERASE);
			select.add(BlendMode.MASK);
			select.add(BlendMode.MULTIPLY);
			select.add(BlendMode.NONE);
			select.add(BlendMode.NORMAL);
			select.add(BlendMode.SCREEN);
			//select.add("ADD", BlendMode.ADD);
			//select.add("AUTO", BlendMode.AUTO);
			//select.add("BELOW", BlendMode.BELOW);
			//select.add("ERASE", BlendMode.ERASE);
			//select.add("MASK", BlendMode.MASK);
			//select.add("MULTIPLY", BlendMode.MULTIPLY);
			//select.add("NONE", BlendMode.NONE);
			//select.add("NORMAL", BlendMode.NORMAL);
			//select.add("SCREEN", BlendMode.SCREEN);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("mask"))
		{
			objectRef = new ExposedObjectReference("mask");
			objectRef.allowClass(DisplayObject);
			collection.addValue(objectRef, groupName);
		}
		
		if (!collection.hasValue("maskInverted"))
		{
			bool = new ExposedBool("maskInverted");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("touchable"))
		{
			bool = new ExposedBool("touchable");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("useHandCursor"))
		{
			bool = new ExposedBool("useHandCursor");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("visible"))
		{
			bool = new ExposedBool("visible");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("alignPivot"))
		{
			func = new ExposedFunction("alignPivot", "align pivot");
			
			select = new ExposedSelect("horizontal align");
			select.add("center", Align.CENTER);
			select.add("left", Align.LEFT);
			select.add("right", Align.RIGHT);
			func.addParameter(select);
			
			select = new ExposedSelect("vertical align");
			select.add("center", Align.CENTER);
			select.add("top", Align.TOP);
			select.add("bottom", Align.BOTTOM);
			func.addParameter(select);
			
			collection.addValue(func, groupName);
		}
		
		// this should not be needed since all values are accessible from the object itself + it resets pivotX/pivotY to 0
		//if (!collection.hasValue("transformationMatrix"))
		//{
			//object = new ExposedObject("transformationMatrix", null, false, true);
			//collection.addValue(object, groupName);
		//}
		
		return collection;
	}
	
	static public function getDisplayObjectVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		collection.add(ClassValueVisibility.fromPool("name"));
		collection.add(ClassValueVisibility.fromPool("x"));
		collection.add(ClassValueVisibility.fromPool("y"));
		collection.add(ClassValueVisibility.fromPool("width"));
		collection.add(ClassValueVisibility.fromPool("height"));
		collection.add(ClassValueVisibility.fromPool("scaleX"));
		collection.add(ClassValueVisibility.fromPool("scaleY"));
		collection.add(ClassValueVisibility.fromPool("pivotX", true, false));
		collection.add(ClassValueVisibility.fromPool("pivotY", true, false));
		collection.add(ClassValueVisibility.fromPool("alpha"));
		collection.add(ClassValueVisibility.fromPool("rotation"));
		collection.add(ClassValueVisibility.fromPool("skewX"));
		collection.add(ClassValueVisibility.fromPool("skewY"));
		collection.add(ClassValueVisibility.fromPool("blendMode"));
		collection.add(ClassValueVisibility.fromPool("mask"));
		collection.add(ClassValueVisibility.fromPool("maskInverted"));
		collection.add(ClassValueVisibility.fromPool("visible"));
		collection.add(ClassValueVisibility.fromPool("touchable", true, false));
		collection.add(ClassValueVisibility.fromPool("useHandCursor", true, false));
		collection.add(ClassValueVisibility.fromPool("alignPivot", true, false));
		
		return collection;
	}
	
	static public function exposeDisplayObjectContainer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObject(collection, groupName);
		
		if (!collection.hasValue("touchGroup"))
		{
			bool = new ExposedBool("touchGroup");
			collection.addValueAfter(bool, "touchable", groupName);
		}
		
		return collection;
	}
	
	static public function getDisplayObjectContainerVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getDisplayObjectVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("touchGroup", true, false));
		
		return collection;
	}
	
	static public function exposeImage(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeMesh(collection, groupName);
		
		return collection;
	}
	
	static public function getImageVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getMeshVisibility(collection);
		
		return collection;
	}
	
	static public function exposeImageConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var texture:ExposedStarlingTexture;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("texture"))
		{
			texture = new ExposedStarlingTexture("texture");
			collection.addValue(texture, groupName);
		}
		
		return collection;
	}
	
	static public function exposeMesh(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var func:ExposedFunction;
		var select:ExposedSelect;
		var texture:ExposedStarlingTexture;
		
		var funcExtra:FunctionCallExtra;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObject(collection, groupName);
		
		if (!collection.hasValue("texture"))
		{
			texture = new ExposedStarlingTexture("texture");
			funcExtra = new FunctionCallExtra("readjustSize");
			texture.extras.add(funcExtra);
			collection.addValueAfter(texture, "name", groupName);
		}
		
		if (!collection.hasValue("textureSmoothing"))
		{
			select = new ExposedSelect("textureSmoothing");
			select.add("BILINEAR", TextureSmoothing.BILINEAR);
			select.add("NONE", TextureSmoothing.NONE);
			select.add("TRILINEAR", TextureSmoothing.TRILINEAR);
			collection.addValueAfter(select, "texture", groupName);
		}
		
		if (!collection.hasValue("textureRepeat"))
		{
			bool = new ExposedBool("textureRepeat");
			collection.addValueAfter(bool, "textureSmoothing", groupName);
		}
		
		if (!collection.hasValue("pixelSnapping"))
		{
			bool = new ExposedBool("pixelSnapping");
			collection.addValueAfter(bool, "textureRepeat", groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValueBefore(color, "alignPivot", groupName);
		}
		
		if (!collection.hasValue("readjustSize"))
		{
			func = new ExposedFunction("readjustSize", "readjust size");
			func.addParameter(new ExposedNote("note", "Set width and height to 0 to match texture dimensions"));
			func.addParameter(new ExposedFloatDrag(null, "width"));
			func.addParameter(new ExposedFloatDrag(null, "height"));
			collection.addValueAfter(func, "alignPivot", groupName);
		}
		
		return collection;
	}
	
	static public function getMeshVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getDisplayObjectVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("color"));
		collection.add(ClassValueVisibility.fromPool("texture", true, false));
		collection.add(ClassValueVisibility.fromPool("textureSmoothing", true, false));
		collection.add(ClassValueVisibility.fromPool("textureRepeat", true, false));
		collection.add(ClassValueVisibility.fromPool("pixelSnapping", true, false));
		collection.add(ClassValueVisibility.fromPool("readjustSize", true, false));
		
		return collection;
	}
	
	static public function exposeMeshBatch(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var func:ExposedFunction;
		var intDrag:ExposedIntDrag;
		var objRef:ExposedObjectReference;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeMesh(collection, groupName);
		
		if (!collection.hasValue("batchable"))
		{
			bool = new ExposedBool("batchable");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("numIndices"))
		{
			intDrag = new ExposedIntDrag("numIndices");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("numVertices"))
		{
			intDrag = new ExposedIntDrag("numVertices");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("addMesh"))
		{
			func = new ExposedFunction("addMesh");
			objRef = new ExposedObjectReference("mesh");
			objRef.allowClass(Mesh);
			func.addParameter(objRef);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("addMeshAt"))
		{
			func = new ExposedFunction("addMeshAt");
			objRef = new ExposedObjectReference("mesh");
			objRef.allowClass(Mesh);
			func.addParameter(objRef);
			intDrag = new ExposedIntDrag("index", null, -1);
			func.addParameter(intDrag);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("clear"))
		{
			func = new ExposedFunction("clear");
			collection.addValue(func, groupName);
		}
		
		return collection;
	}
	
	static public function exposeMovieClip(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var obj:ExposedObject;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeImage(collection, groupName);
		
		if (!collection.hasValue("currentFrame"))
		{
			intDrag = new ExposedIntDrag("currentFrame");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("currentTime"))
		{
			floatDrag = new ExposedFloatDrag("currentTime");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("fps"))
		{
			floatDrag = new ExposedFloatDrag("fps");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("isComplete"))
		{
			bool = new ExposedBool("isComplete");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("isPlaying"))
		{
			bool = new ExposedBool("isPlaying");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("loop"))
		{
			bool = new ExposedBool("loop");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("muted"))
		{
			bool = new ExposedBool("muted");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("numFrames"))
		{
			intDrag = new ExposedIntDrag("numFrames");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("soundTransform"))
		{
			obj = new ExposedObject("soundTransform");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("totalTime"))
		{
			floatDrag = new ExposedFloatDrag("totalTime");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeMovieClipConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		return collection;
	}
	
	static public function exposeQuad(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeMesh(collection, groupName);
		
		return collection;
	}
	
	static public function getQuadVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getMeshVisibility(collection);
		
		return collection;
	}
	
	static public function exposeQuadConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var color:ExposedColor;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("width"))
		{
			floatDrag = new ExposedFloatDrag("width", null, 1);
			floatDrag.defaultValue = 100;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			floatDrag = new ExposedFloatDrag("height", null, 1);
			floatDrag.defaultValue = 100;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color, groupName);
		}
		
		return collection;
	}
	
	static public function exposeSprite(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObjectContainer(collection, groupName);
		
		return collection;
	}
	
	static public function getSpriteVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getDisplayObjectContainerVisibility(collection);
		
		return collection;
	}
	
	static public function exposeSprite3D(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObjectContainer(collection, groupName);
		
		if (!collection.hasValue("z"))
		{
			floatDrag = new ExposedFloatDrag("z");
			collection.addValueAfter(floatDrag, "y", groupName);
		}
		
		if (!collection.hasValue("pivotZ"))
		{
			floatDrag = new ExposedFloatDrag("pivotZ", groupName);
			collection.addValueAfter(floatDrag, "pivotY", groupName);
		}
		
		if (!collection.hasValue("rotationX"))
		{
			floatDrag = new ExposedFloatDrag("rotationX", null, null, null, 0.01);
			collection.addValueAfter(floatDrag, "rotation", groupName);
			collection.removeValueByName("rotation").pool();
		}
		
		if (!collection.hasValue("rotationY"))
		{
			floatDrag = new ExposedFloatDrag("rotationY", null, null, null, 0.01);
			collection.addValueAfter(floatDrag, "rotationX", groupName);
		}
		
		if (!collection.hasValue("rotationZ"))
		{
			floatDrag = new ExposedFloatDrag("rotationZ", null, null, null, 0.01);
			collection.addValueAfter(floatDrag, "rotationY", groupName);
		}
		
		if (!collection.hasValue("scaleZ"))
		{
			floatDrag = new ExposedFloatDrag("scaleZ", null, null, null, 0.05);
			collection.addValueAfter(floatDrag, "scaleY", groupName);
		}
		
		return collection;
	}
	
	static public function getSprite3DVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getDisplayObjectContainerVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("z"));
		collection.add(ClassValueVisibility.fromPool("pivotZ", true, false));
		collection.add(ClassValueVisibility.fromPool("rotationX"));
		collection.add(ClassValueVisibility.fromPool("rotationY"));
		collection.add(ClassValueVisibility.fromPool("rotationZ"));
		collection.add(ClassValueVisibility.fromPool("scaleZ"));
		
		return collection;
	}
	
	static public function exposeStage(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var obj:ExposedObject;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("cameraPosition"))
		{
			obj = new ExposedObject("cameraPosition");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("fieldOfView"))
		{
			floatDrag = new ExposedFloatDrag("fieldOfView", null, 0.0, Math.PI, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("focalLength"))
		{
			floatDrag = new ExposedFloatDrag("focalLength");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("projectionOffset"))
		{
			obj = new ExposedObject("projectionOffset");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("stageHeight"))
		{
			intDrag = new ExposedIntDrag("stageHeight");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("stageWidth"))
		{
			intDrag = new ExposedIntDrag("stageWidth");
			collection.addValue(intDrag, groupName);
		}
		
		return collection;
	}
	
}
#end