package valedit.data.openfl.geom;
import openfl.geom.Matrix3D;
import openfl.geom.Vector3D;
import valedit.ExposedCollection;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedFunction;
import valedit.value.ExposedObject;
import valedit.value.ExposedObjectReference;

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
			color.isTweenable = false;
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
			floatDrag = new ExposedFloatDrag("a", null, null, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("b"))
		{
			floatDrag = new ExposedFloatDrag("b", null, null, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("c"))
		{
			floatDrag = new ExposedFloatDrag("c", null, null, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("d"))
		{
			floatDrag = new ExposedFloatDrag("d", null, null, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("tx"))
		{
			floatDrag = new ExposedFloatDrag("tx");
			floatDrag.isTweenable = false; // this should be covered by "x" property
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("ty"))
		{
			floatDrag = new ExposedFloatDrag("ty");
			floatDrag.isTweenable = false; // this should be covered by "y" property
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeMatrixConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
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
	
	static public function exposeMatrix3D(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var func:ExposedFunction;
		var object:ExposedObject;
		var objectRef:ExposedObjectReference;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("position"))
		{
			object = new ExposedObject("position");
			collection.addValue(object);
		}
		
		if (!collection.hasValue("append"))
		{
			func = new ExposedFunction("append");
			objectRef = new ExposedObjectReference("lhs");
			objectRef.addClass(Matrix3D);
			func.addParameter(objectRef);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("appendRotation"))
		{
			func = new ExposedFunction("appendRotation");
			floatDrag = new ExposedFloatDrag("degrees", null, null, null, 0.1);
			floatDrag.defaultValue = 0.0;
			func.addParameter(floatDrag);
			objectRef = new ExposedObjectReference("axis");
			objectRef.addClass(Vector3D);
			func.addParameter(objectRef);
			objectRef = new ExposedObjectReference("pivotPoint");
			objectRef.addClass(Vector3D);
			objectRef.isNullable = true;
			func.addParameter(objectRef);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("appendScale"))
		{
			func = new ExposedFunction("appendScale");
			floatDrag = new ExposedFloatDrag("xScale", null, null, null, 0.1);
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("yScale", null, null, null, 0.1);
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("zScale", null, null, null, 0.1);
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("appendTranslation"))
		{
			func = new ExposedFunction("appendTranslation");
			floatDrag = new ExposedFloatDrag("x");
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("y");
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("z");
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("copyFrom"))
		{
			func = new ExposedFunction("copyFrom");
			objectRef = new ExposedObjectReference("other");
			objectRef.addClass(Matrix3D);
			func.addParameter(objectRef);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("identity"))
		{
			func = new ExposedFunction("identity");
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("interpolateTo"))
		{
			func = new ExposedFunction("interpolateTo");
			objectRef = new ExposedObjectReference("toMat");
			objectRef.addClass(Matrix3D);
			func.addParameter(objectRef);
			floatDrag = new ExposedFloatDrag("percent");
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("invert"))
		{
			func = new ExposedFunction("invert");
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("pointAt"))
		{
			func = new ExposedFunction("pointAt");
			objectRef = new ExposedObjectReference("pos");
			objectRef.addClass(Vector3D);
			func.addParameter(objectRef);
			objectRef = new ExposedObjectReference("at");
			objectRef.addClass(Vector3D);
			objectRef.isNullable = true;
			func.addParameter(objectRef);
			objectRef = new ExposedObjectReference("up");
			objectRef.addClass(Vector3D);
			objectRef.isNullable = true;
			func.addParameter(objectRef);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("prepend"))
		{
			func = new ExposedFunction("prepend");
			objectRef = new ExposedObjectReference("rhs");
			objectRef.addClass(Matrix3D);
			func.addParameter(objectRef);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("prependRotation"))
		{
			func = new ExposedFunction("prependRotation");
			floatDrag = new ExposedFloatDrag("degrees", null, null, null, 0.1);
			func.addParameter(floatDrag);
			objectRef = new ExposedObjectReference("axis");
			objectRef.addClass(Vector3D);
			func.addParameter(objectRef);
			objectRef = new ExposedObjectReference("pivotPoint");
			objectRef.addClass(Vector3D);
			objectRef.isNullable = true;
			func.addParameter(objectRef);
			collection.addValue(func);
		}
		
		if (!collection.hasValue("prependScale"))
		{
			func = new ExposedFunction("prependScale");
			floatDrag = new ExposedFloatDrag("xScale", null, null, null, 0.1);
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("yScale", null, null, null, 0.1);
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("zScale", null, null, null, 0.1);
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("prependTranslation"))
		{
			func = new ExposedFunction("prependTranslation");
			floatDrag = new ExposedFloatDrag("x");
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("y");
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("z");
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("transpose"))
		{
			func = new ExposedFunction("transpose");
			collection.addValue(func, groupName);
		}
		
		return collection;
	}
	
	static public function exposePerspectiveProjection(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var object:ExposedObject;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("fieldOfView"))
		{
			floatDrag = new ExposedFloatDrag("fieldOfView", null, 0, 180, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("focalLength"))
		{
			floatDrag = new ExposedFloatDrag("focalLength");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("projectionCenter"))
		{
			object = new ExposedObject("projectionCenter");
			collection.addValue(object, groupName);
		}
		
		return collection;
	}
	
	static public function exposePerspectiveProjectionConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
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
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
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
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
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
	
	static public function exposeVector3D(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var func:ExposedFunction;
		var objectRef:ExposedObjectReference;
		
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
		
		if (!collection.hasValue("z"))
		{
			floatDrag = new ExposedFloatDrag("z");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("w"))
		{
			floatDrag = new ExposedFloatDrag("w");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("copyFrom"))
		{
			func = new ExposedFunction("copyFrom");
			objectRef = new ExposedObjectReference("sourceVector3D");
			objectRef.addClass(Vector3D);
			func.addParameter(objectRef);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("decrementBy"))
		{
			func = new ExposedFunction("decrementBy");
			objectRef = new ExposedObjectReference("a");
			objectRef.addClass(Vector3D);
			func.addParameter(objectRef);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("incrementBy"))
		{
			func = new ExposedFunction("incrementBy");
			objectRef = new ExposedObjectReference("a");
			objectRef.addClass(Vector3D);
			func.addParameter(objectRef);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("negate"))
		{
			func = new ExposedFunction("negate");
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("project"))
		{
			func = new ExposedFunction("project");
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("scaleBy"))
		{
			func = new ExposedFunction("scaleBy");
			floatDrag = new ExposedFloatDrag("s", null, null, null, 0.1);
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		return collection;
	}
	
	static public function exposeVector3DConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("x"))
		{
			floatDrag = new ExposedFloatDrag("x");
			floatDrag.defaultValue = 0.0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("y"))
		{
			floatDrag = new ExposedFloatDrag("y");
			floatDrag.defaultValue = 0.0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("z"))
		{
			floatDrag = new ExposedFloatDrag("z");
			floatDrag.defaultValue = 0.0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("w"))
		{
			floatDrag = new ExposedFloatDrag("w");
			floatDrag.defaultValue = 0.0;
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
}