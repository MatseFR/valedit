package valedit.data.starling.display;
import starling.display.BlendMode;
import starling.display.DisplayObject;
import starling.textures.TextureSmoothing;
import starling.utils.Align;
import valeditor.ui.feathers.variant.TextInputVariant;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloat;
import valedit.value.ExposedFloatRange;
import valedit.value.ExposedFunction;
import valedit.value.ExposedNote;
import valedit.value.ExposedObject;
import valedit.value.ExposedObjectReference;
import valedit.value.ExposedSelect;
import valedit.value.ExposedString;
import valedit.value.NumericMode;
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
		var floatRange:ExposedFloatRange;
		var float:ExposedFloat;
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
			float = new ExposedFloat("x");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("y"))
		{
			float = new ExposedFloat("y");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("width"))
		{
			float = new ExposedFloat("width");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			float = new ExposedFloat("height");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("pivotX"))
		{
			float = new ExposedFloat("pivotX");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("pivotY"))
		{
			float = new ExposedFloat("pivotY");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("scaleX"))
		{
			float = new ExposedFloat("scaleX");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("scaleY"))
		{
			float = new ExposedFloat("scaleY");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("alpha"))
		{
			floatRange = new ExposedFloatRange("alpha", null, 0, 1, 0.01, 2, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange, groupName);
		}
		
		if (!collection.hasValue("rotation"))
		{
			float = new ExposedFloat("rotation");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("skewX"))
		{
			float = new ExposedFloat("skewX");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("skewY"))
		{
			float = new ExposedFloat("skewY");
			collection.addValue(float, groupName);
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
		
		if (!collection.hasValue("transformationMatrix"))
		{
			object = new ExposedObject("transformationMatrix", null, true, true);
			collection.addValue(object, groupName);
		}
		
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
	
	static public function exposeImage(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeMesh(collection, groupName);
		
		return collection;
	}
	
	static public function exposeImageConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var texture:ExposedStarlingTexture;
		
		if (collection == null) collection = new ExposedCollection();
		
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
			func.addParameter(new ExposedFloat("width"));
			func.addParameter(new ExposedFloat("height"));
			collection.addValueAfter(func, "alignPivot", groupName);
		}
		
		return collection;
	}
	
	static public function exposeQuad(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeMesh(collection, groupName);
		
		return collection;
	}
	
	static public function exposeQuadConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var float:ExposedFloat;
		var color:ExposedColor;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("width"))
		{
			float = new ExposedFloat("width", null, 2, NumericMode.Positive);
			float.defaultValue = 100;
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			float = new ExposedFloat("height", null, 2, NumericMode.Positive);
			float.defaultValue = 100;
			collection.addValue(float, groupName);
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
	
	static public function exposeSprite3D(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var float:ExposedFloat;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObjectContainer(collection, groupName);
		
		if (!collection.hasValue("z"))
		{
			float = new ExposedFloat("z");
			collection.addValueAfter(float, "y", groupName);
		}
		
		if (!collection.hasValue("pivotZ"))
		{
			float = new ExposedFloat("pivotZ");
			collection.addValueAfter(float, "pivotY", groupName);
		}
		
		if (!collection.hasValue("rotationX"))
		{
			float = new ExposedFloat("rotationX");
			collection.addValueAfter(float, "rotation", groupName);
			collection.removeValueByName("rotation");
		}
		
		if (!collection.hasValue("rotationY"))
		{
			float = new ExposedFloat("rotationY");
			collection.addValueAfter(float, "rotationX", groupName);
		}
		
		if (!collection.hasValue("rotationZ"))
		{
			float = new ExposedFloat("rotationZ");
			collection.addValueAfter(float, "rotationY", groupName);
		}
		
		if (!collection.hasValue("scaleZ"))
		{
			float = new ExposedFloat("scaleZ");
			collection.addValueAfter(float, "scaleY", groupName);
		}
		
		return collection;
	}
	
}