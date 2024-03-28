package valedit.data.openfl.filters;
import openfl.filters.BitmapFilterQuality;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloat;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedFloatRange;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedIntRange;
import valedit.value.ExposedSelect;

/**
 * ...
 * @author Matse
 */
class FiltersData 
{

	static public function exposeBlurFilter(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (!collection.hasValue("blurX"))
		{
			floatDrag = new ExposedFloatDrag("blurX", null, 0, 255);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blurY"))
		{
			floatDrag = new ExposedFloatDrag("blurY", null, 0, 255);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("quality"))
		{
			intDrag = new ExposedIntDrag("quality", null, 0, 16);
			collection.addValue(intDrag, groupName);
			
			//select = new ExposedSelect("quality");
			//select.add("LOW", BitmapFilterQuality.LOW);
			//select.add("MEDIUM", BitmapFilterQuality.MEDIUM);
			//select.add("HIGH", BitmapFilterQuality.HIGH);
			//collection.addValue(select, groupName);
		}
		
		return collection;
	}
	
	static public function exposeBlurFilterConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
			collection.useActions = false;
		}
		
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (!collection.hasValue("blurX"))
		{
			floatDrag = new ExposedFloatDrag("blurX", null, 0, 255);
			floatDrag.defaultValue = 4;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blurY"))
		{
			floatDrag = new ExposedFloatDrag("blurY", null, 0, 255);
			floatDrag.defaultValue = 4;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("quality"))
		{
			intDrag = new ExposedIntDrag("quality", null, 0, 16);
			intDrag.defaultValue = 1;
			collection.addValue(intDrag, groupName);
			
			//select = new ExposedSelect("quality");
			//select.add("LOW", BitmapFilterQuality.LOW);
			//select.add("MEDIUM", BitmapFilterQuality.MEDIUM);
			//select.add("HIGH", BitmapFilterQuality.HIGH);
			//collection.addValue(select, groupName);
		}
		
		return collection;
	}
	
	static public function exposeDropShadowFilter(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (!collection.hasValue("angle"))
		{
			floatDrag = new ExposedFloatDrag("angle", null, 0, 360);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blurX"))
		{
			floatDrag = new ExposedFloatDrag("blurX", null, 0, 255);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blurY"))
		{
			floatDrag = new ExposedFloatDrag("blurY", null, 0, 255);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("strength"))
		{
			floatDrag = new ExposedFloatDrag("strength", null, 0, 255);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, 0, 1, 0.005);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("distance"))
		{
			floatDrag = new ExposedFloatDrag("distance");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("hideObject"))
		{
			bool = new ExposedBool("hideObject");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("inner"))
		{
			bool = new ExposedBool("inner");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("knockout"))
		{
			bool = new ExposedBool("knockout");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("quality"))
		{
			intDrag = new ExposedIntDrag("quality", null, 0, 16);
			collection.addValue(intDrag, groupName);
			
			//select = new ExposedSelect("quality");
			//select.add("LOW", BitmapFilterQuality.LOW);
			//select.add("MEDIUM", BitmapFilterQuality.MEDIUM);
			//select.add("HIGH", BitmapFilterQuality.HIGH);
			//collection.addValue(select, groupName);
		}
		
		return collection;
	}
	
	static public function exposeDropShadowFilterConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
			collection.useActions = true;
		}
		
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (!collection.hasValue("distance"))
		{
			floatDrag = new ExposedFloatDrag("distance");
			floatDrag.defaultValue = 4;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("angle"))
		{
			floatDrag = new ExposedFloatDrag("angle", null, 0, 360);
			floatDrag.defaultValue = 45;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			color.defaultValue = 0;
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, 0, 1, 0.005);
			floatDrag.defaultValue = 1;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blurX"))
		{
			floatDrag = new ExposedFloatDrag("blurX", null, 0, 255);
			floatDrag.defaultValue = 4;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blurY"))
		{
			floatDrag = new ExposedFloatDrag("blurY", null, 0, 255);
			floatDrag.defaultValue = 4;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("strength"))
		{
			floatDrag = new ExposedFloatDrag("strength", null, 0, 255);
			floatDrag.defaultValue = 1;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("quality"))
		{
			intDrag = new ExposedIntDrag("quality", null, 0, 16);
			intDrag.defaultValue = 1;
			collection.addValue(intDrag, groupName);
			
			//select = new ExposedSelect("quality");
			//select.add("LOW", BitmapFilterQuality.LOW);
			//select.add("MEDIUM", BitmapFilterQuality.MEDIUM);
			//select.add("HIGH", BitmapFilterQuality.HIGH);
			//collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("inner"))
		{
			bool = new ExposedBool("inner");
			bool.defaultValue = false;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("knockout"))
		{
			bool = new ExposedBool("knockout");
			bool.defaultValue = false;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("hideObject"))
		{
			bool = new ExposedBool("hideObject");
			bool.defaultValue = false;
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeGlowFilter(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var select:ExposedSelect;
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color", null);
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, 0, 1, 0.005);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blurX"))
		{
			floatDrag = new ExposedFloatDrag("blurX", null, 0, 255);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blurY"))
		{
			floatDrag = new ExposedFloatDrag("blurY", null, 0, 255);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("strength"))
		{
			floatDrag = new ExposedFloatDrag("strength", null, 0, 255);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("quality"))
		{
			intDrag = new ExposedIntDrag("quality", null, 0, 16);
			intDrag.defaultValue = 1;
			collection.addValue(intDrag, groupName);
			
			//select = new ExposedSelect("quality");
			//select.add("LOW", BitmapFilterQuality.LOW);
			//select.add("MEDIUM", BitmapFilterQuality.MEDIUM);
			//select.add("HIGH", BitmapFilterQuality.HIGH);
			//collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("inner"))
		{
			bool = new ExposedBool("inner");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("knockout"))
		{
			bool = new ExposedBool("knockout");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeGlowFilterConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
			collection.useActions = false;
		}
		
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var select:ExposedSelect;
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color", null);
			color.defaultValue = 0xff0000;
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, 0, 1, 0.005);
			floatDrag.defaultValue = 1;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blurX"))
		{
			floatDrag = new ExposedFloatDrag("blurX", null, 0, 255);
			floatDrag.defaultValue = 6;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blurY"))
		{
			floatDrag = new ExposedFloatDrag("blurY", null, 0, 255);
			floatDrag.defaultValue = 6;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("strength"))
		{
			floatDrag = new ExposedFloatDrag("strength", null, 0, 255);
			floatDrag.defaultValue = 2;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("quality"))
		{
			intDrag = new ExposedIntDrag("quality", null, 0, 16);
			intDrag.defaultValue = 1;
			collection.addValue(intDrag, groupName);
			
			//select = new ExposedSelect("quality");
			//select.add("LOW", BitmapFilterQuality.LOW);
			//select.add("MEDIUM", BitmapFilterQuality.MEDIUM);
			//select.add("HIGH", BitmapFilterQuality.HIGH);
			//collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("inner"))
		{
			bool = new ExposedBool("inner");
			bool.defaultValue = false;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("knockout"))
		{
			bool = new ExposedBool("knockout");
			bool.defaultValue = false;
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
}