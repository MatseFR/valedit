package valedit.helpers;
import openfl.display.BlendMode;
import valedit.ExposedCollection;
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
class DisplayHelper 
{
	
	/**
	   
	   @param	collection
	   @param	useGroups
	   @param	includeSubGroups
	   @return
	**/
	static public function exposeDisplayObject(collection:ExposedCollection = null, useGroups:Bool = true, includeSubGroups:Bool = false):ExposedCollection
	{
		var group:ExposedGroup;
		var groupName:String = null;
		var boolVal:ExposedBool;
		var floatVal:ExposedFloat;
		var floatRange:ExposedFloatRange;
		var listVal:ExposedSelect;
		var objVal:ExposedObject;
		var stringVal:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		if (useGroups)
		{
			groupName = "Properties";
			group = collection.getGroup(groupName, includeSubGroups);
			if (group == null)
			{
				group = new ExposedGroup(groupName, true);
				collection.addValue(group);
			}
		}
		
		if (!collection.hasValue("name"))
		{
			stringVal = new ExposedString("name");
			collection.addValue(stringVal, groupName);
		}
		
		if (!collection.hasValue("x"))
		{
			floatVal = new ExposedFloat("x");
			collection.addValue(floatVal, groupName);
		}
		
		if (!collection.hasValue("y"))
		{
			floatVal = new ExposedFloat("y");
			collection.addValue(floatVal, groupName);
		}
		
		if (!collection.hasValue("width"))
		{
			floatVal = new ExposedFloat("width");
			collection.addValue(floatVal, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			floatVal = new ExposedFloat("height");
			collection.addValue(floatVal, groupName);
		}
		
		if (!collection.hasValue("scaleX"))
		{
			floatVal = new ExposedFloat("scaleX");
			collection.addValue(floatVal, groupName);
		}
		
		if (!collection.hasValue("scaleY"))
		{
			floatVal = new ExposedFloat("scaleY");
			collection.addValue(floatVal, groupName);
		}
		
		if (!collection.hasValue("alpha"))
		{
			floatRange = new ExposedFloatRange("alpha", null, 0, 1, 0.01, 2, 75, 25);
			collection.addValue(floatRange, groupName);
		}
		
		if (!collection.hasValue("rotation"))
		{
			floatRange = new ExposedFloatRange("rotation", null, -180, 180, 1, 2, 75, 25);
			collection.addValue(floatRange, groupName);
		}
		
		if (!collection.hasValue("blendMode"))
		{
			listVal = new ExposedSelect("blendMode");
			listVal.add("ADD", BlendMode.ADD);
			listVal.add("ALPHA", BlendMode.ALPHA);
			listVal.add("DARKEN", BlendMode.DARKEN);
			listVal.add("DIFFERENCE", BlendMode.DIFFERENCE);
			listVal.add("ERASE", BlendMode.ERASE);
			listVal.add("HARDLIGHT", BlendMode.HARDLIGHT);
			listVal.add("INVERT", BlendMode.INVERT);
			listVal.add("LAYER", BlendMode.LAYER);
			listVal.add("LIGHTEN", BlendMode.LIGHTEN);
			listVal.add("MULTIPLY", BlendMode.MULTIPLY);
			listVal.add("NORMAL", BlendMode.NORMAL);
			listVal.add("OVERLAY", BlendMode.OVERLAY);
			listVal.add("SCREEN", BlendMode.SCREEN);
			listVal.add("SHADER", BlendMode.SHADER);
			listVal.add("SUBTRACT", BlendMode.SUBTRACT);
			collection.addValue(listVal, groupName);
		}
		
		if (!collection.hasValue("transform"))
		{
			objVal = new ExposedObject("transform");
			collection.addValue(objVal, groupName);
		}
		
		if (!collection.hasValue("cacheAsBitmap"))
		{
			boolVal = new ExposedBool("cacheAsBitmap");
			collection.addValue(boolVal, groupName);
		}
		
		if (!collection.hasValue("visible"))
		{
			boolVal = new ExposedBool("visible");
			collection.addValue(boolVal, groupName);
		}
		
		return collection;
	}
	
	/**
	   
	   @param	groups
	   @return
	**/
	static public function exposeSprite(collection:ExposedCollection = null, useGroups:Bool = true, includeSubGroups:Bool = false):ExposedCollection
	{
		var boolVal:ExposedBool;
		var groupName:String = useGroups ? "Properties":null;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObject(collection, useGroups, includeSubGroups);
		
		if (!collection.hasValue("buttonMode"))
		{
			boolVal = new ExposedBool("buttonMode");
			collection.addValue(boolVal, groupName);
		}
		
		if (!collection.hasValue("useHandCursor"))
		{
			boolVal = new ExposedBool("useHandCursor");
			collection.addValue(boolVal, groupName);
		}
		
		return collection;
	}
	
}