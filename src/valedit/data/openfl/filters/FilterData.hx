package valedit.data.openfl.filters;
import openfl.filters.BitmapFilterQuality;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloat;
import valedit.value.ExposedFloatRange;
import valedit.value.ExposedIntRange;
import valedit.value.ExposedSelect;

/**
 * ...
 * @author Matse
 */
class FilterData 
{

	static public function exposeBlurFilter(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		var floatRange:ExposedFloatRange;
		var intRange:ExposedIntRange;
		
		floatRange = new ExposedFloatRange("blurX", null, 0, 255, 0.1, 2);
		collection.addValue(floatRange, groupName);
		
		floatRange = new ExposedFloatRange("blurY", null, 0, 255, 0.1, 2);
		collection.addValue(floatRange, groupName);
		
		intRange = new ExposedIntRange("quality", null, 0, 16, 1);
		collection.addValue(intRange, groupName);
		
		return collection;
	}
	
	static public function exposeDropShadowFilter(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		var bool:ExposedBool;
		var float:ExposedFloat;
		var floatRange:ExposedFloatRange;
		var intRange:ExposedIntRange;
		var color:ExposedColor;
		
		floatRange = new ExposedFloatRange("angle", null, 0, 360, 1, 2);
		collection.addValue(floatRange, groupName);
		
		floatRange = new ExposedFloatRange("blurX", null, 0, 255, 1, 2);
		collection.addValue(floatRange, groupName);
		
		floatRange = new ExposedFloatRange("blurY", null, 0, 255, 1, 2);
		collection.addValue(floatRange, groupName);
		
		floatRange = new ExposedFloatRange("strength", null, 0, 255, 1, 2);
		collection.addValue(floatRange, groupName);
		
		floatRange = new ExposedFloatRange("alpha", null, 0, 1, 0.01, 2);
		collection.addValue(floatRange, groupName);
		
		float = new ExposedFloat("distance");
		collection.addValue(float, groupName);
		
		color = new ExposedColor("color", null);
		collection.addValue(color, groupName);
		
		bool = new ExposedBool("hideObject");
		collection.addValue(bool, groupName);
		
		bool = new ExposedBool("inner");
		collection.addValue(bool, groupName);
		
		bool = new ExposedBool("knockout");
		collection.addValue(bool, groupName);
		
		intRange = new ExposedIntRange("quality", null, 0, 16, 1);
		collection.addValue(intRange, groupName);
		
		return collection;
	}
	
	static public function exposeGlowFilter(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		var bool:ExposedBool;
		var floatRange:ExposedFloatRange;
		var color:ExposedColor;
		var select:ExposedSelect;
		
		color = new ExposedColor("color", null);
		collection.addValue(color, groupName);
		
		floatRange = new ExposedFloatRange("alpha", null, 0, 1, 0.01, 2);
		collection.addValue(floatRange, groupName);
		
		floatRange = new ExposedFloatRange("blurX", null, 0, 255, 1, 2);
		collection.addValue(floatRange, groupName);
		
		floatRange = new ExposedFloatRange("blurY", null, 0, 255, 1, 2);
		collection.addValue(floatRange, groupName);
		
		floatRange = new ExposedFloatRange("strength", null, 0, 255, 1, 2);
		collection.addValue(floatRange, groupName);
		
		select = new ExposedSelect("quality");
		select.add("LOW", BitmapFilterQuality.LOW);
		select.add("MEDIUM", BitmapFilterQuality.MEDIUM);
		select.add("HIGH", BitmapFilterQuality.HIGH);
		collection.addValue(select, groupName);
		
		bool = new ExposedBool("inner");
		collection.addValue(bool, groupName);
		
		bool = new ExposedBool("knockout");
		collection.addValue(bool, groupName);
		
		return collection;
	}
	
}