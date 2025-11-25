package valedit.data.starling.geom;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedFunction;
import valedit.value.ExposedIntDrag;

/**
 * ...
 * @author Matse
 */
class StarlingGeomData 
{

	static public function exposePolygon(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var func:ExposedFunction;
		var intDrag:ExposedIntDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("area"))
		{
			floatDrag = new ExposedFloatDrag("area");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("isConvex"))
		{
			bool = new ExposedBool("isConvex");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("isSimple"))
		{
			bool = new ExposedBool("isSimple");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("numTriangles"))
		{
			intDrag = new ExposedIntDrag("numTriangles");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("numVertices"))
		{
			intDrag = new ExposedIntDrag("numVertices", null, 0);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("reverse"))
		{
			func = new ExposedFunction("reverse");
			collection.addValue(func, groupName);
		}
		
		return collection;
	}
	
}