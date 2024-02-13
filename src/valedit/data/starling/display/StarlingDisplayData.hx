package valedit.data.starling.display;
import starling.display.BlendMode;
import starling.display.DisplayObject;
import starling.textures.TextureSmoothing;
import starling.utils.Align;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedFunction;
import valedit.value.ExposedNote;
import valedit.value.ExposedObject;
import valedit.value.ExposedObjectReference;
import valedit.value.ExposedSelect;
import valedit.value.ExposedString;
import valedit.value.extra.FunctionCallExtra;
import valedit.value.starling.ExposedStarlingTexture;

/**
 * ...
 * @author Matse
 */
class StarlingDisplayData 
{

	static public function exposeDisplayObject(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var func:ExposedFunction;
		var object:ExposedObject;
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
			select.add("ADD", BlendMode.ADD);
			select.add("AUTO", BlendMode.AUTO);
			select.add("BELOW", BlendMode.BELOW);
			select.add("ERASE", BlendMode.ERASE);
			select.add("MASK", BlendMode.MASK);
			select.add("MULTIPLY", BlendMode.MULTIPLY);
			select.add("NONE", BlendMode.NONE);
			select.add("NORMAL", BlendMode.NORMAL);
			select.add("SCREEN", BlendMode.SCREEN);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("mask"))
		{
			objectRef = new ExposedObjectReference("mask");
			objectRef.addClass(DisplayObject);
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
	
	static public function exposeDisplayObjectInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObject(collection);
		collection.setVisibleAll(false);
		applyDisplayObjectInstance(collection);
		
		return collection;
	}
	
	static private function applyDisplayObjectInstance(collection:ExposedCollection):Void
	{
		collection.setVisibleArray([
			"name",
			"x",
			"y",
			"width",
			"height",
			"scaleX",
			"scaleY",
			"alpha",
			"rotation",
			"skewX",
			"skewY",
			"blendMode",
			"mask",
			"maskInverted",
			"visible"
		], true);
	}
	
	static public function exposeDisplayObjectTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObject(collection);
		collection.setVisibleAll(false);
		applyDisplayObjectTemplate(collection);
		
		return collection;
	}
	
	static private function applyDisplayObjectTemplate(collection:ExposedCollection):Void
	{
		collection.setVisibleArray([
			"pivotX",
			"pivotY",
			"touchable",
			"useHandCursor",
			"alignPivot"
		], true);
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
	
	static public function exposeDisplayObjectContainerInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObjectContainer(collection);
		collection.setVisibleAll(false);
		applyDisplayObjectContainerInstance(collection);
		
		return collection;
	}
	
	static private function applyDisplayObjectContainerInstance(collection:ExposedCollection):Void
	{
		applyDisplayObjectInstance(collection);
	}
	
	static public function exposeDisplayObjectContainerTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObjectContainer(collection);
		collection.setVisibleAll(false);
		applyDisplayObjectContainerTemplate(collection);
		
		return collection;
	}
	
	static private function applyDisplayObjectContainerTemplate(collection:ExposedCollection):Void
	{
		applyDisplayObjectTemplate(collection);
		collection.setVisibleArray(["touchGroup"], true);
	}
	
	static public function exposeImage(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeMesh(collection, groupName);
		
		return collection;
	}
	
	static public function exposeImageInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeImage(collection);
		collection.setVisibleAll(false);
		applyImageInstance(collection);
		
		return collection;
	}
	
	static private function applyImageInstance(collection:ExposedCollection):Void
	{
		applyMeshInstance(collection);
	}
	
	static public function exposeImageTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeImage(collection);
		collection.setVisibleAll(false);
		applyImageTemplate(collection);
		
		return collection;
	}
	
	static private function applyImageTemplate(collection:ExposedCollection):Void
	{
		applyMeshTemplate(collection);
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
			func.addParameter(new ExposedFloatDrag("width"));
			func.addParameter(new ExposedFloatDrag("height"));
			collection.addValueAfter(func, "alignPivot", groupName);
		}
		
		return collection;
	}
	
	static public function exposeMeshInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeMesh(collection);
		collection.setVisibleAll(false);
		applyMeshInstance(collection);
		
		return collection;
	}
	
	static private function applyMeshInstance(collection:ExposedCollection):Void
	{
		applyDisplayObjectInstance(collection);
		collection.setVisibleArray([
			"color"
		], true);
	}
	
	static public function exposeMeshTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeMesh(collection);
		collection.setVisibleAll(false);
		applyMeshTemplate(collection);
		
		return collection;
	}
	
	static private function applyMeshTemplate(collection:ExposedCollection):Void
	{
		applyDisplayObjectTemplate(collection);
		collection.setVisibleArray([
			"texture",
			"textureSmoothing",
			"textureRepeat",
			"pixelSnapping",
			"readjustSize"
		], true);
	}
	
	static public function exposeQuad(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeMesh(collection, groupName);
		
		return collection;
	}
	
	static public function exposeQuadInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeQuad(collection);
		collection.setVisibleAll(false);
		applyQuadInstance(collection);
		
		return collection;
	}
	
	static private function applyQuadInstance(collection:ExposedCollection):Void
	{
		applyMeshInstance(collection);
	}
	
	static public function exposeQuadTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeQuad(collection);
		collection.setVisibleAll(false);
		applyQuadTemplate(collection);
		
		return collection;
	}
	
	static private function applyQuadTemplate(collection:ExposedCollection):Void
	{
		applyMeshTemplate(collection);
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
	
	static public function exposeSpriteInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeSprite(collection);
		collection.setVisibleAll(false);
		applySpriteInstance(collection);
		
		return collection;
	}
	
	static private function applySpriteInstance(collection:ExposedCollection):Void
	{
		applyDisplayObjectContainerInstance(collection);
	}
	
	static public function exposeSpriteTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeSprite(collection);
		collection.setVisibleAll(false);
		applySpriteTemplate(collection);
		
		return collection;
	}
	
	static private function applySpriteTemplate(collection:ExposedCollection):Void
	{
		applyDisplayObjectContainerTemplate(collection);
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
	
	static public function exposeSprite3DInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeSprite3D(collection);
		collection.setVisibleAll(false);
		applySprite3DInstance(collection);
		
		return collection;
	}
	
	static private function applySprite3DInstance(collection:ExposedCollection):Void
	{
		applyDisplayObjectContainerInstance(collection);
		collection.setVisibleArray([
			"z",
			"rotationX",
			"rotationY",
			"rotationZ",
			"scaleZ"
		], true);
	}
	
	static public function exposeSprite3DTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeSprite3D(collection);
		collection.setVisibleAll(false);
		applySprite3DTemplate(collection);
		
		return collection;
	}
	
	static private function applySprite3DTemplate(collection:ExposedCollection):Void
	{
		applyDisplayObjectContainerTemplate(collection);
		collection.setVisibleArray([
			"pivotZ"
		], true);
	}
	
}