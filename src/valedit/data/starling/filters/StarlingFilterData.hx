package valedit.data.starling.filters;
import openfl.display.BitmapDataChannel;
import openfl.display3D.Context3DTextureFormat;
import starling.filters.FragmentFilter;
import starling.textures.TextureSmoothing;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedFunction;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObject;
import valedit.value.ExposedObjectReference;
import valedit.value.ExposedSelect;
import valedit.value.starling.ExposedStarlingTexture;

/**
 * ...
 * @author Matse
 */
class StarlingFilterData 
{

	static public function exposeBlurFilter(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("blurX"))
		{
			floatDrag = new ExposedFloatDrag("blurX", null, 0, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blurY"))
		{
			floatDrag = new ExposedFloatDrag("blurY", null, 0, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("quality"))
		{
			floatDrag = new ExposedFloatDrag("quality", null, 0, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeBlurFilterConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("blurX"))
		{
			floatDrag = new ExposedFloatDrag("blurX", null, 0, null, 0.05);
			floatDrag.defaultValue = 1.0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blurY"))
		{
			floatDrag = new ExposedFloatDrag("blurY", null, 0, null, 0.05);
			floatDrag.defaultValue = 1.0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("quality"))
		{
			floatDrag = new ExposedFloatDrag("quality", null, 0, null, 0.05);
			floatDrag.defaultValue = 1.0;
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeColorMatrixFilter(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var func:ExposedFunction;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("adjustBrightness"))
		{
			func = new ExposedFunction("adjustBrightness");
			floatDrag = new ExposedFloatDrag("value", null, -1, 1, 0.05);
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("adjustContrast"))
		{
			func = new ExposedFunction("adjustContrast");
			floatDrag = new ExposedFloatDrag("value", null, -1, 1, 0.05);
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("adjustHue"))
		{
			func = new ExposedFunction("adjustHue");
			floatDrag = new ExposedFloatDrag("value", null, -1, 1, 0.05);
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("adjustSaturation"))
		{
			func = new ExposedFunction("adjustSaturation");
			floatDrag = new ExposedFloatDrag("value", null, -1, 1, 0.05);
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("invert"))
		{
			func = new ExposedFunction("invert");
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("reset"))
		{
			func = new ExposedFunction("reset");
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("tint"))
		{
			func = new ExposedFunction("tint");
			color = new ExposedColor("color");
			func.addParameter(color);
			floatDrag = new ExposedFloatDrag("amount", null, 0, 1, 0.05);
			floatDrag.defaultValue = 1.0;
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		return collection;
	}
	
	static public function exposeColorMatrixFilterConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		return collection;
	}
	
	static public function exposeDisplacementMapFilter(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var select:ExposedSelect;
		var texture:ExposedStarlingTexture;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("componentX"))
		{
			select = new ExposedSelect("componentX");
			select.add("red", BitmapDataChannel.RED);
			select.add("green", BitmapDataChannel.GREEN);
			select.add("blue", BitmapDataChannel.BLUE);
			select.add("alpha", BitmapDataChannel.ALPHA);
			select.defaultValue = BitmapDataChannel.RED;
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("componentY"))
		{
			select = new ExposedSelect("componentY");
			select.add("red", BitmapDataChannel.RED);
			select.add("green", BitmapDataChannel.GREEN);
			select.add("blue", BitmapDataChannel.BLUE);
			select.add("alpha", BitmapDataChannel.ALPHA);
			select.defaultValue = BitmapDataChannel.RED;
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("mapRepeat"))
		{
			bool = new ExposedBool("mapRepeat");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("mapScaleX"))
		{
			floatDrag = new ExposedFloatDrag("mapScaleX", null, null, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("mapScaleY"))
		{
			floatDrag = new ExposedFloatDrag("mapScaleY", null, null, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("mapTexture"))
		{
			texture = new ExposedStarlingTexture("mapTexture");
			collection.addValue(texture, groupName);
		}
		
		if (!collection.hasValue("mapX"))
		{
			floatDrag = new ExposedFloatDrag("mapX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("mapY"))
		{
			floatDrag = new ExposedFloatDrag("mapY");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("scaleX"))
		{
			floatDrag = new ExposedFloatDrag("scaleX", null, null, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("scaleY"))
		{
			floatDrag = new ExposedFloatDrag("scaleY", null, null, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeDisplacementMapFilterConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var select:ExposedSelect;
		var texture:ExposedStarlingTexture;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("mapTexture"))
		{
			texture = new ExposedStarlingTexture("mapTexture");
			collection.addValue(texture, groupName);
		}
		
		if (!collection.hasValue("componentX"))
		{
			select = new ExposedSelect("componentX");
			select.add("red", BitmapDataChannel.RED);
			select.add("green", BitmapDataChannel.GREEN);
			select.add("blue", BitmapDataChannel.BLUE);
			select.add("alpha", BitmapDataChannel.ALPHA);
			select.defaultValue = BitmapDataChannel.RED;
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("componentY"))
		{
			select = new ExposedSelect("componentY");
			select.add("red", BitmapDataChannel.RED);
			select.add("green", BitmapDataChannel.GREEN);
			select.add("blue", BitmapDataChannel.BLUE);
			select.add("alpha", BitmapDataChannel.ALPHA);
			select.defaultValue = BitmapDataChannel.RED;
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("scaleX"))
		{
			floatDrag = new ExposedFloatDrag("scaleX", null, null, null, 0.05);
			floatDrag.defaultValue = 0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("scaleY"))
		{
			floatDrag = new ExposedFloatDrag("scaleY", null, null, null, 0.05);
			floatDrag.defaultValue = 0;
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeDropShadowFilter(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, 0, 1, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("angle"))
		{
			floatDrag = new ExposedFloatDrag("angle", null, null, null, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blur"))
		{
			floatDrag = new ExposedFloatDrag("blur", null, null, null, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("distance"))
		{
			floatDrag = new ExposedFloatDrag("distance");
			collection.addValue(floatDrag, groupName);
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
			floatDrag = new ExposedFloatDrag("quality", null, 0, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeDropShadowFilterConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("distance"))
		{
			floatDrag = new ExposedFloatDrag("distance");
			floatDrag.defaultValue = 4.0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("angle"))
		{
			floatDrag = new ExposedFloatDrag("angle", null, null, null, 0.01);
			floatDrag.defaultValue = 0.785;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			color.defaultValue = 0x0;
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, 0, 1, 0.05);
			floatDrag.defaultValue = 0.5;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blur"))
		{
			floatDrag = new ExposedFloatDrag("blur", null, null, null, 0.1);
			floatDrag.defaultValue = 1.0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("quality"))
		{
			floatDrag = new ExposedFloatDrag("quality", null, 0, null, 0.05);
			floatDrag.defaultValue = 0.5;
			collection.addValue(floatDrag, groupName);
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
	
	static public function exposeFilterChain(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var func:ExposedFunction;
		var objectRef:ExposedObjectReference;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("addFilter"))
		{
			func = new ExposedFunction("addFilter");
			objectRef = new ExposedObjectReference("filter");
			objectRef.addClass(FragmentFilter);
			func.addParameter(objectRef);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("removeFilter"))
		{
			func = new ExposedFunction("removeFilter");
			objectRef = new ExposedObjectReference("filter");
			objectRef.addClass(FragmentFilter);
			func.addParameter(objectRef);
			collection.addValue(func, groupName);
		}
		
		return collection;
	}
	
	static public function exposeFilterChainConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		return collection;
	}
	
	static public function exposeFragmentFilter(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var object:ExposedObject;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("alwaysDrawToBackBuffer"))
		{
			bool = new ExposedBool("alwaysDrawToBackBuffer");
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("antiAliasing"))
		{
			intDrag = new ExposedIntDrag("antiAliasing", null, 0, 4, 0.5);
			collection.addValue(intDrag);
		}
		
		if (!collection.hasValue("padding"))
		{
			object = new ExposedObject("padding");
			collection.addValue(object);
		}
		
		if (!collection.hasValue("resolution"))
		{
			floatDrag = new ExposedFloatDrag("resolution", null, 0, 16, 0.05);
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("textureFormat"))
		{
			select = new ExposedSelect("textureFormat");
			select.add("BGR_PACKED", Context3DTextureFormat.BGR_PACKED);
			select.add("BGRA", Context3DTextureFormat.BGRA);
			select.add("BGRA_PACKED", Context3DTextureFormat.BGRA_PACKED);
			select.add("COMPRESSED (ATF)", Context3DTextureFormat.COMPRESSED);
			select.add("COMPRESSED_ALPHA (ATF)", Context3DTextureFormat.COMPRESSED_ALPHA);
			select.add("RGBA_HALF_FLOAT", Context3DTextureFormat.RGBA_HALF_FLOAT);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("textureSmoothing"))
		{
			select = new ExposedSelect("textureSmoothing");
			select.add("BILINEAR", TextureSmoothing.BILINEAR);
			select.add("NONE", TextureSmoothing.NONE);
			select.add("TRILINEAR", TextureSmoothing.TRILINEAR);
			collection.addValue(select, groupName);
		}
		
		return collection;
	}
	
	static public function exposeGlowFilter(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, 0, 1, 0.05);
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("blur"))
		{
			floatDrag = new ExposedFloatDrag("blur", null, null, null, 0.1);
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color);
		}
		
		if (!collection.hasValue("inner"))
		{
			bool = new ExposedBool("inner");
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("knockout"))
		{
			bool = new ExposedBool("knockout");
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("quality"))
		{
			floatDrag = new ExposedFloatDrag("quality", null, 0, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeGlowFilterConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			color.defaultValue = 0xffff00;
			collection.addValue(color);
		}
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, 0, 1, 0.05);
			floatDrag.defaultValue = 1.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("blur"))
		{
			floatDrag = new ExposedFloatDrag("blur", null, null, null, 0.1);
			floatDrag.defaultValue = 1.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("quality"))
		{
			floatDrag = new ExposedFloatDrag("quality", null, 0, null, 0.05);
			floatDrag.defaultValue = 0.5;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("inner"))
		{
			bool = new ExposedBool("inner");
			bool.defaultValue = false;
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("knockout"))
		{
			bool = new ExposedBool("knockout");
			bool.defaultValue = false;
			collection.addValue(bool);
		}
		
		return collection;
	}
	
}