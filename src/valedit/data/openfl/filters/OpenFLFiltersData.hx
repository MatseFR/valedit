package valedit.data.openfl.filters;
import openfl.filters.BitmapFilterType;
import openfl.filters.DisplacementMapFilterMode;
import openfl.filters.DisplacementMapFilterMode;
import openfl.geom.Point;
import valedit.ExposedCollection;
import valedit.value.ExposedBitmapData;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObject;
import valedit.value.ExposedSelect;

/**
 * ...
 * @author Matse
 */
class OpenFLFiltersData 
{
	
	static public function exposeBevelFilter(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("angle"))
		{
			floatDrag = new ExposedFloatDrag("angle");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blurX"))
		{
			floatDrag = new ExposedFloatDrag("blurX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blurY"))
		{
			floatDrag = new ExposedFloatDrag("blurY");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("distance"))
		{
			floatDrag = new ExposedFloatDrag("distance");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("highlightAlpha"))
		{
			floatDrag = new ExposedFloatDrag("highlightAlpha", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("highlightColor"))
		{
			color = new  ExposedColor("highlightColor");
			collection.addValue(color, groupName);
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
		}
		
		if (!collection.hasValue("shadowAlpha"))
		{
			floatDrag = new ExposedFloatDrag("shadowAlpha", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("shadowColor"))
		{
			color = new ExposedColor("shadowColor");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("type"))
		{
			select = new ExposedSelect("type");
			select.add(BitmapFilterType.FULL, BitmapFilterType.FULL);
			select.add(BitmapFilterType.INNER, BitmapFilterType.INNER);
			select.add(BitmapFilterType.OUTER, BitmapFilterType.OUTER);
			collection.addValue(select, groupName);
		}
		
		return collection;
	}
	
	static public function exposeBevelFilterConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var select:ExposedSelect;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("distance"))
		{
			floatDrag = new ExposedFloatDrag("distance");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("angle"))
		{
			floatDrag = new ExposedFloatDrag("angle");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("highlightColor"))
		{
			color = new ExposedColor("highlightColor");
			color.defaultValue = 0xffffff;
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("highlightAlpha"))
		{
			floatDrag = new ExposedFloatDrag("highlightAlpha", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("shadowColor"))
		{
			color = new ExposedColor("shadowColor");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("shadowAlpha"))
		{
			floatDrag = new ExposedFloatDrag("shadowAlpha");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blurX"))
		{
			floatDrag = new ExposedFloatDrag("blurX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blurY"))
		{
			floatDrag = new ExposedFloatDrag("blurY");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("strength"))
		{
			floatDrag = new ExposedFloatDrag("strength");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("quality"))
		{
			intDrag = new ExposedIntDrag("quality", null, 0, 16);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("type"))
		{
			select = new ExposedSelect("type");
			select.add(BitmapFilterType.FULL, BitmapFilterType.FULL);
			select.add(BitmapFilterType.INNER, BitmapFilterType.INNER);
			select.add(BitmapFilterType.OUTER, BitmapFilterType.OUTER);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("knockout"))
		{
			bool = new ExposedBool("knockout");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}

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
	
	static public function exposeDisplacementMapFilter(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bmd:ExposedBitmapData;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var obj:ExposedObject;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("componentX"))
		{
			intDrag = new ExposedIntDrag("componentX");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("componentY"))
		{
			intDrag = new ExposedIntDrag("componentY");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("mapBitmap"))
		{
			bmd = new ExposedBitmapData("mapBitmap");
			collection.addValue(bmd, groupName);
		}
		
		if (!collection.hasValue("mapPoint"))
		{
			obj = new ExposedObject("mapPoint");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("mode"))
		{
			select = new ExposedSelect("mode");
			select.add(DisplacementMapFilterMode.CLAMP, DisplacementMapFilterMode.CLAMP);
			select.add(DisplacementMapFilterMode.COLOR, DisplacementMapFilterMode.COLOR);
			select.add(DisplacementMapFilterMode.IGNORE, DisplacementMapFilterMode.IGNORE);
			select.add(DisplacementMapFilterMode.WRAP, DisplacementMapFilterMode.WRAP);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("scaleX"))
		{
			floatDrag = new ExposedFloatDrag("scaleX", null, null, null, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("scaleY"))
		{
			floatDrag = new ExposedFloatDrag("scaleY", null, null, null, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeDisplacementMapFilterConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bmd:ExposedBitmapData;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var obj:ExposedObject;
		var select:ExposedSelect;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("mapBitmap"))
		{
			bmd = new ExposedBitmapData("mapBitmap");
			collection.addValue(bmd, groupName);
		}
		
		if (!collection.hasValue("mapPoint"))
		{
			obj = new ExposedObject("mapPoint");
			obj.autoCreateIfNull = true;
			obj.autoCreationClassName = Type.getClassName(Point);
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("componentX"))
		{
			intDrag = new ExposedIntDrag("componentX");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("componentY"))
		{
			intDrag = new ExposedIntDrag("componentY");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("scaleX"))
		{
			floatDrag = new ExposedFloatDrag("scaleX", null, null, null, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("scaleY"))
		{
			floatDrag = new ExposedFloatDrag("scaleY", null, null, null, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("mode"))
		{
			select = new ExposedSelect("mode");
			select.add(DisplacementMapFilterMode.CLAMP, DisplacementMapFilterMode.CLAMP);
			select.add(DisplacementMapFilterMode.COLOR, DisplacementMapFilterMode.COLOR);
			select.add(DisplacementMapFilterMode.IGNORE, DisplacementMapFilterMode.IGNORE);
			select.add(DisplacementMapFilterMode.WRAP, DisplacementMapFilterMode.WRAP);
			select.defaultValue = DisplacementMapFilterMode.WRAP;
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			color.defaultValue = 0x000000;
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, 0.0, 1.0, 0.01);
			floatDrag.defaultValue = 0.0;
			collection.addValue(floatDrag, groupName);
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