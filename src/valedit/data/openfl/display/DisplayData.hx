package valedit.data.openfl.display;
import openfl.display.BlendMode;
import openfl.display.PixelSnapping;
import ui.feathers.variant.TextInputVariant;
import valedit.ExposedCollection;
import valedit.value.ExposedBitmapData;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloat;
import valedit.value.ExposedFloatRange;
import valedit.value.ExposedGroup;
import valedit.value.ExposedObject;
import valedit.value.ExposedSelect;
import valedit.value.ExposedString;

/**
 * ...
 * @author Matse
 */
class DisplayData 
{
	
	static public function exposeBitmap(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bmd:ExposedBitmapData;
		var bool:ExposedBool;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObject(collection, groupName);
		
		if (!collection.hasValue("bitmapData"))
		{
			bmd = new ExposedBitmapData("bitmapData");
			collection.addValue(bmd, groupName);
		}
		
		if (!collection.hasValue("pixelSnapping"))
		{
			select = new ExposedSelect("pixelSnapping");
			select.add("ALWAYS", PixelSnapping.ALWAYS);
			select.add("AUTO", PixelSnapping.AUTO);
			select.add("NEVER", PixelSnapping.NEVER);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("smoothing"))
		{
			bool = new ExposedBool("smoothing");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeDisplayObject(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var float:ExposedFloat;
		var floatRange:ExposedFloatRange;
		var obj:ExposedObject;
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
			floatRange = new ExposedFloatRange("rotation", null, -180, 180, 1, 2, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange, groupName);
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
		
		if (!collection.hasValue("transform"))
		{
			obj = new ExposedObject("transform");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("cacheAsBitmap"))
		{
			bool = new ExposedBool("cacheAsBitmap");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("visible"))
		{
			bool = new ExposedBool("visible");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeMovieClip(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeSprite(collection, groupName);
		
		if (!collection.hasValue("enabled"))
		{
			bool = new ExposedBool("enabled");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeSprite(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObject(collection, groupName);
		
		if (!collection.hasValue("buttonMode"))
		{
			bool = new ExposedBool("buttonMode");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("useHandCursor"))
		{
			bool = new ExposedBool("useHandCursor");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
}