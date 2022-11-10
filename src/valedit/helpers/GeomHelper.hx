package valedit.helpers;
import valedit.ExposedCollection;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloat;
import valedit.value.ExposedFloatRange;
import valedit.value.ExposedObject;

/**
 * ...
 * @author Matse
 */
class GeomHelper 
{
	/**
	   
	   @param	collection
	   @return
	**/
	static public function exposeColorTransform(collection:ExposedCollection = null):ExposedCollection
	{
		var colorVal:ExposedColor;
		var floatVal:ExposedFloat;
		var floatRange:ExposedFloatRange;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("color"))
		{
			colorVal = new ExposedColor("color");
			collection.addValue(colorVal);
		}
		
		if (!collection.hasValue("redMultiplier"))
		{
			floatVal = new ExposedFloat("redMultiplier");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("redOffset"))
		{
			floatRange = new ExposedFloatRange("redOffset", -255, 255);
			collection.addValue(floatRange);
		}
		
		if (!collection.hasValue("greenMultiplier"))
		{
			floatVal = new ExposedFloat("greenMultiplier");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("greenOffset"))
		{
			floatRange = new ExposedFloatRange("greenOffset", -255, 255);
			collection.addValue(floatRange);
		}
		
		if (!collection.hasValue("blueMultiplier"))
		{
			floatVal = new ExposedFloat("blueMultiplier");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("blueOffset"))
		{
			floatRange = new ExposedFloatRange("blueOffset", -255, 255);
			collection.addValue(floatRange);
		}
		
		if (!collection.hasValue("alphaMultiplier"))
		{
			floatVal = new ExposedFloat("alphaMultiplier");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("alphaOffset"))
		{
			floatRange = new ExposedFloatRange("alphaOffset", -255, 255);
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
		var floatVal:ExposedFloat;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("a"))
		{
			floatVal = new ExposedFloat("a");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("b"))
		{
			floatVal = new ExposedFloat("b");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("c"))
		{
			floatVal = new ExposedFloat("c");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("d"))
		{
			floatVal = new ExposedFloat("d");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("tx"))
		{
			floatVal = new ExposedFloat("tx");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("ty"))
		{
			floatVal = new ExposedFloat("ty");
			collection.addValue(floatVal);
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
		var floatVal:ExposedFloat;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("x"))
		{
			floatVal = new ExposedFloat("x");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("y"))
		{
			floatVal = new ExposedFloat("y");
			collection.addValue(floatVal);
		}
		
		return collection;
	}
	
	/**
	   
	   @param	collection
	   @return
	**/
	static public function exposeRectangle(collection:ExposedCollection = null):ExposedCollection
	{
		var floatVal:ExposedFloat;
		var objVal:ExposedObject;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("x"))
		{
			floatVal = new ExposedFloat("x");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("y"))
		{
			floatVal = new ExposedFloat("y");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("width"))
		{
			floatVal = new ExposedFloat("width");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("height"))
		{
			floatVal = new ExposedFloat("height");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("top"))
		{
			floatVal = new ExposedFloat("top");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("bottom"))
		{
			floatVal = new ExposedFloat("bottom");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("left"))
		{
			floatVal = new ExposedFloat("left");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("right"))
		{
			floatVal = new ExposedFloat("right");
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("topLeft"))
		{
			objVal = new ExposedObject("topLeft");
			collection.addValue(objVal);
		}
		
		if (!collection.hasValue("bottomRight"))
		{
			objVal = new ExposedObject("bottomRight");
			collection.addValue(objVal);
		}
		
		if (!collection.hasValue("size"))
		{
			objVal = new ExposedObject("size");
			collection.addValue(objVal);
		}
		
		return collection;
	}
	
	/**
	   
	   @param	collection
	   @return
	**/
	static public function exposeTransform(collection:ExposedCollection = null):ExposedCollection
	{
		var objVal:ExposedObject;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("colorTransform"))
		{
			objVal = new ExposedObject("colorTransform", true, true);
			collection.addValue(objVal);
		}
		
		if (!collection.hasValue("matrix"))
		{
			objVal = new ExposedObject("matrix", true, true);
			collection.addValue(objVal);
		}
		
		return collection;
	}
	
}