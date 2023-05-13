package valedit.data.openfl.geom;
import ui.feathers.variant.TextInputVariant;
import valedit.ExposedCollection;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloat;
import valedit.value.ExposedFloatRange;
import valedit.value.ExposedObject;

/**
 * ...
 * @author Matse
 */
class GeomData 
{
	
	static public function exposeColorTransform(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var color:ExposedColor;
		var floatRange:ExposedFloatRange;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("redMultiplier"))
		{
			floatRange = new ExposedFloatRange("redMultiplier", null, 0, 1, 0.01, 2, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange, groupName);
		}
		
		if (!collection.hasValue("redOffset"))
		{
			floatRange = new ExposedFloatRange("redOffset", null, -255, 255, 1, 0, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange, groupName);
		}
		
		if (!collection.hasValue("greenMultiplier"))
		{
			floatRange = new ExposedFloatRange("greenMultiplier", null, 0, 1, 0.01, 2, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange, groupName);
		}
		
		if (!collection.hasValue("greenOffset"))
		{
			floatRange = new ExposedFloatRange("greenOffset", null, -255, 255, 1, 0, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange, groupName);
		}
		
		if (!collection.hasValue("blueMultiplier"))
		{
			floatRange = new ExposedFloatRange("blueMultiplier", null, 0, 1, 0.01, 2, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange, groupName);
		}
		
		if (!collection.hasValue("blueOffset"))
		{
			floatRange = new ExposedFloatRange("blueOffset", null, -255, 255, 1, 0, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange, groupName);
		}
		
		if (!collection.hasValue("alphaMultiplier"))
		{
			floatRange = new ExposedFloatRange("alphaMultiplier", null, 0, 1, 0.01, 0, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange, groupName);
		}
		
		if (!collection.hasValue("alphaOffset"))
		{
			floatRange = new ExposedFloatRange("alphaOffset", null, -255, 255, 1, 0, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange, groupName);
		}
		
		return collection;
	}
	
	static public function exposeMatrix(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var float:ExposedFloat;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("a"))
		{
			float = new ExposedFloat("a");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("b"))
		{
			float = new ExposedFloat("b");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("c"))
		{
			float = new ExposedFloat("c");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("d"))
		{
			float = new ExposedFloat("d");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("tx"))
		{
			float = new ExposedFloat("tx");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("ty"))
		{
			float = new ExposedFloat("ty");
			collection.addValue(float, groupName);
		}
		
		return collection;
	}
	
	static public function exposePoint(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var float:ExposedFloat;
		
		if (collection == null) collection = new ExposedCollection();
		
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
		
		return collection;
	}
	
	static public function exposeRectangle(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var float:ExposedFloat;
		var obj:ExposedObject;
		
		if (collection == null) collection = new ExposedCollection();
		
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
		
		if (!collection.hasValue("top"))
		{
			float = new ExposedFloat("top");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("bottom"))
		{
			float = new ExposedFloat("bottom");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("left"))
		{
			float = new ExposedFloat("left");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("right"))
		{
			float = new ExposedFloat("right");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("topLeft"))
		{
			obj = new ExposedObject("topLeft");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("bottomRight"))
		{
			obj = new ExposedObject("bottomRight");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("size"))
		{
			obj = new ExposedObject("size");
			collection.addValue(obj, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTransform(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var obj:ExposedObject;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("colorTransform"))
		{
			obj = new ExposedObject("colorTransform", null, true, true);
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("matrix"))
		{
			obj = new ExposedObject("matrix", null, true, true);
			collection.addValue(obj, groupName);
		}
		
		return collection;
	}
	
}