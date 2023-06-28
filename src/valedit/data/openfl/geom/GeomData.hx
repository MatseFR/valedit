package valedit.data.openfl.geom;
import valedit.ExposedCollection;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloat;
import valedit.value.ExposedFloatDrag;
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
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("redMultiplier"))
		{
			floatDrag = new ExposedFloatDrag("redMultiplier", null, 0, 1, 0.005);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("redOffset"))
		{
			floatDrag = new ExposedFloatDrag("redOffset", null, -255, 255);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("greenMultiplier"))
		{
			floatDrag = new ExposedFloatDrag("greenMultiplier", null, 0, 1, 0.005);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("greenOffset"))
		{
			floatDrag = new ExposedFloatDrag("greenOffset", null, -255, 255);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blueMultiplier"))
		{
			floatDrag = new ExposedFloatDrag("blueMultiplier", null, 0, 1, 0.005);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blueOffset"))
		{
			floatDrag = new ExposedFloatDrag("blueOffset", null, -255, 255);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alphaMultiplier"))
		{
			floatDrag = new ExposedFloatDrag("alphaMultiplier", null, 0, 1, 0.005);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alphaOffset"))
		{
			floatDrag = new ExposedFloatDrag("alphaOffset", null, -255, 255);
			collection.addValue(floatDrag);
		}
		
		return collection;
	}
	
	static public function exposeMatrix(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("a"))
		{
			floatDrag = new ExposedFloatDrag("a");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("b"))
		{
			floatDrag = new ExposedFloatDrag("b");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("c"))
		{
			floatDrag = new ExposedFloatDrag("c");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("d"))
		{
			floatDrag = new ExposedFloatDrag("d");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("tx"))
		{
			floatDrag = new ExposedFloatDrag("tx");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("ty"))
		{
			floatDrag = new ExposedFloatDrag("ty");
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeMatrixConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("a"))
		{
			floatDrag = new ExposedFloatDrag("a");
			floatDrag.defaultValue = 1;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("b"))
		{
			floatDrag = new ExposedFloatDrag("b");
			floatDrag.defaultValue = 0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("c"))
		{
			floatDrag = new ExposedFloatDrag("c");
			floatDrag.defaultValue = 0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("d"))
		{
			floatDrag = new ExposedFloatDrag("d");
			floatDrag.defaultValue = 1;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("tx"))
		{
			floatDrag = new ExposedFloatDrag("tx");
			floatDrag.defaultValue = 0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("ty"))
		{
			floatDrag = new ExposedFloatDrag("ty");
			floatDrag.defaultValue = 0;
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposePoint(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
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
		
		return collection;
	}
	
	static public function exposePointConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("x"))
		{
			floatDrag = new ExposedFloatDrag("x");
			floatDrag.defaultValue = 0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("y"))
		{
			floatDrag = new ExposedFloatDrag("y");
			floatDrag.defaultValue = 0;
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeRectangle(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var obj:ExposedObject;
		
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
		
		if (!collection.hasValue("top"))
		{
			floatDrag = new ExposedFloatDrag("top");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("bottom"))
		{
			floatDrag = new ExposedFloatDrag("bottom");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("left"))
		{
			floatDrag = new ExposedFloatDrag("left");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("right"))
		{
			floatDrag = new ExposedFloatDrag("right");
			collection.addValue(floatDrag, groupName);
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
	
	static public function exposeRectangleConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("x"))
		{
			floatDrag = new ExposedFloatDrag("x");
			floatDrag.defaultValue = 0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("y"))
		{
			floatDrag = new ExposedFloatDrag("x");
			floatDrag.defaultValue = 0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("width"))
		{
			floatDrag = new ExposedFloatDrag("width");
			floatDrag.defaultValue = 0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			floatDrag = new ExposedFloatDrag("height");
			floatDrag.defaultValue = 0;
			collection.addValue(floatDrag, groupName);
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