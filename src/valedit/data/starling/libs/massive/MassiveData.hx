package valedit.data.starling.libs.massive;
import starling.utils.Align;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloat;
import valedit.value.ExposedFloatRange;
import valedit.value.ExposedFunction;
import valedit.value.ExposedGroup;
import valedit.value.ExposedSelect;
import valedit.value.extra.FunctionCallExtra;

/**
 * ...
 * @author Matse
 */
class MassiveData 
{

	static private function exposeDisplayData(collection:ExposedCollection, useGroups:Bool = true):ExposedCollection
	{
		var group:ExposedGroup;
		var groupName:String = null;
		
		var bool:ExposedBool;
		var float:ExposedFloat;
		var floatRange:ExposedFloatRange;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (useGroups)
		{
			groupName = "Properties";
			group = collection.getGroup(groupName);
			if (group == null)
			{
				group = new ExposedGroup(groupName);
				collection.addValue(group);
			}
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
		
		if (!collection.hasValue("offsetX"))
		{
			float = new ExposedFloat("offsetX");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("offsetY"))
		{
			float = new ExposedFloat("offsetY");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("rotation"))
		{
			float = new ExposedFloat("rotation");
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
		
		if (!collection.hasValue("colorRed"))
		{
			floatRange = new ExposedFloatRange("colorRed", null, -1, 10, 0.1);
			collection.addValue(floatRange, groupName);
		}
		
		if (!collection.hasValue("colorGreen"))
		{
			floatRange = new ExposedFloatRange("colorGreen", null, -1, 10, 0.1);
			collection.addValue(floatRange, groupName);
		}
		
		if (!collection.hasValue("colorBlue"))
		{
			floatRange = new ExposedFloatRange("colorBlue", null, -1, 10, 0.1);
			collection.addValue(floatRange, groupName);
		}
		
		if (!collection.hasValue("colorAlpha"))
		{
			floatRange = new ExposedFloatRange("colorAlpha", null, 0, 1, 0.1);
			collection.addValue(floatRange, groupName);
		}
		
		if (!collection.hasValue("visible"))
		{
			bool = new ExposedBool("visible");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeFrame(collection:ExposedCollection = null, useGroups:Bool = true):ExposedCollection
	{
		var group:ExposedGroup;
		var groupName:String = null;
		
		var float:ExposedFloat;
		var func:ExposedFunction;
		var select:ExposedSelect;
		
		var funcExtra:FunctionCallExtra;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (useGroups)
		{
			groupName = "Properties";
			group = collection.getGroup(groupName);
			if (group == null)
			{
				group = new ExposedGroup(groupName);
				collection.addValue(group);
			}
		}
		
		if (!collection.hasValue("pivotX"))
		{
			float = new ExposedFloat("pivotX");
			funcExtra = new FunctionCallExtra("pivotUpdate");
			float.extras.add(funcExtra);
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("pivotY"))
		{
			float = new ExposedFloat("pivotY");
			funcExtra = new FunctionCallExtra("pivotUpdate");
			float.extras.add(funcExtra);
			collection.addValue(float, groupName);
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
			
			collection.addValue(func);
		}
		
		return collection;
	}
	
	static public function exposeImageData(collection:ExposedCollection = null, useGroups:Bool = true):ExposedCollection
	{
		var group:ExposedGroup;
		var groupName:String = null;
		
		var bool:ExposedBool;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (useGroups)
		{
			groupName = "Properties";
			group = collection.getGroup(groupName);
			if (group == null)
			{
				group = new ExposedGroup(groupName);
				collection.addValue(group);
			}
		}
		
		exposeDisplayData(collection, useGroups);
		
		if (!collection.hasValue("invertX"))
		{
			bool = new ExposedBool("invertX");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("invertY"))
		{
			bool = new ExposedBool("invertY");
			collection.addValue(bool, groupName);
		}
		
		return collection
	}
	
	static public function exposeQuadData(collection:ExposedCollection = null, useGroups:Bool = true):ExposedCollection
	{
		var group:ExposedGroup;
		var groupName:String = null;
		
		var float:ExposedFloat;
		var func:ExposedFunction;
		var select:ExposedSelect;
		
		var funcExtra:FunctionCallExtra;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (useGroups)
		{
			groupName = "Properties";
			group = collection.getGroup(groupName);
			if (group == null)
			{
				group = new ExposedGroup(groupName);
				collection.addValue(group);
			}
		}
		
		exposeDisplayData(collection, useGroups);
		
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
			funcExtra = new FunctionCallExtra("pivotUpdate");
			float.extras.add(funcExtra);
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("pivotY"))
		{
			float = new ExposedFloat("pivotY");
			funcExtra = new FunctionCallExtra("pivotUpdate");
			float.extras.add(funcExtra);
			collection.addValue(float, groupName);
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
			
			collection.addValue(func);
		}
		
		return collection;
	}
	
}