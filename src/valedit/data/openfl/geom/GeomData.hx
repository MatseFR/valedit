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
	/**
	   
	   @param	collection
	   @return
	**/
	static public function exposeColorTransform(collection:ExposedCollection = null):ExposedCollection
	{
		var color:ExposedColor;
		var floatRange:ExposedFloatRange;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color);
		}
		
		if (!collection.hasValue("redMultiplier"))
		{
			floatRange = new ExposedFloatRange("redMultiplier", null, 0, 1, 0.01, 2, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange);
		}
		
		if (!collection.hasValue("redOffset"))
		{
			floatRange = new ExposedFloatRange("redOffset", null, -255, 255, 1, 0, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange);
		}
		
		if (!collection.hasValue("greenMultiplier"))
		{
			floatRange = new ExposedFloatRange("greenMultiplier", null, 0, 1, 0.01, 2, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange);
		}
		
		if (!collection.hasValue("greenOffset"))
		{
			floatRange = new ExposedFloatRange("greenOffset", null, -255, 255, 1, 0, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange);
		}
		
		if (!collection.hasValue("blueMultiplier"))
		{
			floatRange = new ExposedFloatRange("blueMultiplier", null, 0, 1, 0.01, 2, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange);
		}
		
		if (!collection.hasValue("blueOffset"))
		{
			floatRange = new ExposedFloatRange("blueOffset", null, -255, 255, 1, 0, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange);
		}
		
		if (!collection.hasValue("alphaMultiplier"))
		{
			floatRange = new ExposedFloatRange("alphaMultiplier", null, 0, 1, 0.01, 0, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange);
		}
		
		if (!collection.hasValue("alphaOffset"))
		{
			floatRange = new ExposedFloatRange("alphaOffset", null, -255, 255, 1, 0, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange);
		}
		
		return collection;
	}
	
	/**
	   
	   @param	collection
	   @param	useGroups
	   @param	includeSubGroups
	   @return
	**/
	static public function exposeMatrix(collection:ExposedCollection = null, useGroups:Bool = true, includeSubGroups:Bool = false):ExposedCollection
	{
		var float:ExposedFloat;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("a"))
		{
			float = new ExposedFloat("a");
			collection.addValue(float);
		}
		
		if (!collection.hasValue("b"))
		{
			float = new ExposedFloat("b");
			collection.addValue(float);
		}
		
		if (!collection.hasValue("c"))
		{
			float = new ExposedFloat("c");
			collection.addValue(float);
		}
		
		if (!collection.hasValue("d"))
		{
			float = new ExposedFloat("d");
			collection.addValue(float);
		}
		
		if (!collection.hasValue("tx"))
		{
			float = new ExposedFloat("tx");
			collection.addValue(float);
		}
		
		if (!collection.hasValue("ty"))
		{
			float = new ExposedFloat("ty");
			collection.addValue(float);
		}
		
		return collection;
	}
	
	/**
	   
	   @param	collection
	   @param	useGroups
	   @param	includeSubGroups
	   @return
	**/
	static public function exposePoint(collection:ExposedCollection = null, useGroups:Bool = true, includeSubGroups:Bool = false):ExposedCollection
	{
		var float:ExposedFloat;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("x"))
		{
			float = new ExposedFloat("x");
			collection.addValue(float);
		}
		
		if (!collection.hasValue("y"))
		{
			float = new ExposedFloat("y");
			collection.addValue(float);
		}
		
		return collection;
	}
	
	/**
	   
	   @param	collection
	   @return
	**/
	static public function exposeRectangle(collection:ExposedCollection = null):ExposedCollection
	{
		var float:ExposedFloat;
		var obj:ExposedObject;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("x"))
		{
			float = new ExposedFloat("x");
			collection.addValue(float);
		}
		
		if (!collection.hasValue("y"))
		{
			float = new ExposedFloat("y");
			collection.addValue(float);
		}
		
		if (!collection.hasValue("width"))
		{
			float = new ExposedFloat("width");
			collection.addValue(float);
		}
		
		if (!collection.hasValue("height"))
		{
			float = new ExposedFloat("height");
			collection.addValue(float);
		}
		
		if (!collection.hasValue("top"))
		{
			float = new ExposedFloat("top");
			collection.addValue(float);
		}
		
		if (!collection.hasValue("bottom"))
		{
			float = new ExposedFloat("bottom");
			collection.addValue(float);
		}
		
		if (!collection.hasValue("left"))
		{
			float = new ExposedFloat("left");
			collection.addValue(float);
		}
		
		if (!collection.hasValue("right"))
		{
			float = new ExposedFloat("right");
			collection.addValue(float);
		}
		
		if (!collection.hasValue("topLeft"))
		{
			obj = new ExposedObject("topLeft");
			collection.addValue(obj);
		}
		
		if (!collection.hasValue("bottomRight"))
		{
			obj = new ExposedObject("bottomRight");
			collection.addValue(obj);
		}
		
		if (!collection.hasValue("size"))
		{
			obj = new ExposedObject("size");
			collection.addValue(obj);
		}
		
		return collection;
	}
	
	/**
	   
	   @param	collection
	   @return
	**/
	static public function exposeTransform(collection:ExposedCollection = null):ExposedCollection
	{
		var obj:ExposedObject;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("colorTransform"))
		{
			obj = new ExposedObject("colorTransform", null, true, true);
			collection.addValue(obj);
		}
		
		if (!collection.hasValue("matrix"))
		{
			obj = new ExposedObject("matrix", null, true, true);
			collection.addValue(obj);
		}
		
		return collection;
	}
	
}