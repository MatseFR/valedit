package valedit.data.openfl.filters;
import openfl.filters.BitmapFilterQuality;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloat;
import valedit.value.ExposedFloatRange;
import valedit.value.ExposedGroup;
import valedit.value.ExposedIntRange;
import valedit.value.ExposedSelect;

/**
 * ...
 * @author Matse
 */
class FilterData 
{

	static public function exposeBlurFilter(collection:ExposedCollection = null):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		var floatRange:ExposedFloatRange;
		var intRange:ExposedIntRange;
		var group:ExposedGroup;
		
		group = new ExposedGroup("BlurFilter properties");
		collection.addValue(group);
		
		floatRange = new ExposedFloatRange("blurX", null, 0, 255, 0.1, 2, 75, 25);
		group.addValue(floatRange);
		
		floatRange = new ExposedFloatRange("blurY", null, 0, 255, 0.1, 2, 75, 25);
		group.addValue(floatRange);
		
		intRange = new ExposedIntRange("quality", null, 0, 16, 1, 75, 25);
		group.addValue(intRange);
		
		return collection;
	}
	
	static public function exposeDropShadowFilter(collection:ExposedCollection = null):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		var bool:ExposedBool;
		var float:ExposedFloat;
		var floatRange:ExposedFloatRange;
		var intRange:ExposedIntRange;
		var color:ExposedColor;
		var group:ExposedGroup;
		
		group = new ExposedGroup("DropShadowFilter properties");
		collection.addValue(group);
		
		floatRange = new ExposedFloatRange("angle", null, 0, 360, 1, 2, 75, 25);
		group.addValue(floatRange);
		
		floatRange = new ExposedFloatRange("blurX", null, 0, 255, 1, 2, 75, 25);
		group.addValue(floatRange);
		
		floatRange = new ExposedFloatRange("blurY", null, 0, 255, 1, 2, 75, 25);
		group.addValue(floatRange);
		
		floatRange = new ExposedFloatRange("strength", null, 0, 255, 1, 2, 75, 25);
		group.addValue(floatRange);
		
		floatRange = new ExposedFloatRange("alpha", null, 0, 1, 0.01, 2, 75, 25);
		group.addValue(floatRange);
		
		float = new ExposedFloat("distance");
		group.addValue(float);
		
		color = new ExposedColor("color", null);
		group.addValue(color);
		
		bool = new ExposedBool("hideObject");
		group.addValue(bool);
		
		bool = new ExposedBool("inner");
		group.addValue(bool);
		
		bool = new ExposedBool("knockout");
		group.addValue(bool);
		
		intRange = new ExposedIntRange("quality", null, 0, 16, 1, 75, 25);
		group.addValue(intRange);
		
		return collection;
	}
	
	static public function exposeGlowFilter(collection:ExposedCollection = null):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		var bool:ExposedBool;
		var floatRange:ExposedFloatRange;
		var color:ExposedColor;
		var select:ExposedSelect;
		var group:ExposedGroup;
		
		group = new ExposedGroup("GlowFilter properties");
		collection.addValue(group);
		
		color = new ExposedColor("color", null);
		group.addValue(color);
		
		floatRange = new ExposedFloatRange("alpha", null, 0, 1, 0.01, 2, 75, 25);
		group.addValue(floatRange);
		
		floatRange = new ExposedFloatRange("blurX", null, 0, 255, 1, 2, 75, 25);
		group.addValue(floatRange);
		
		floatRange = new ExposedFloatRange("blurY", null, 0, 255, 1, 2, 75, 25);
		group.addValue(floatRange);
		
		floatRange = new ExposedFloatRange("strength", null, 0, 255, 1, 2, 75, 25);
		group.addValue(floatRange);
		
		select = new ExposedSelect("quality");
		select.add("LOW", BitmapFilterQuality.LOW);
		select.add("MEDIUM", BitmapFilterQuality.MEDIUM);
		select.add("HIGH", BitmapFilterQuality.HIGH);
		group.addValue(select);
		
		bool = new ExposedBool("inner");
		group.addValue(bool);
		
		bool = new ExposedBool("knockout");
		group.addValue(bool);
		
		return collection;
	}
	
}