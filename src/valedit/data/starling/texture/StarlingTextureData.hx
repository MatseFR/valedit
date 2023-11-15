package valedit.data.starling.texture;
import openfl.display3D.Context3DTextureFormat;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedSelect;

/**
 * ...
 * @author Matse
 */
class StarlingTextureData 
{
	
	static public function exposeTextureCreationParameters(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("generateMipMaps"))
		{
			bool = new ExposedBool("generateMipMaps");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("optimizeForRenderToTexture"))
		{
			bool = new ExposedBool("optimizeForRenderToTexture");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("scale"))
		{
			floatDrag = new ExposedFloatDrag("scale", null, null, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("format"))
		{
			select = new ExposedSelect("format");
			select.add("BGR_PACKED", Context3DTextureFormat.BGR_PACKED);
			select.add("BGRA", Context3DTextureFormat.BGRA);
			select.add("BGRA_PACKED", Context3DTextureFormat.BGRA_PACKED);
			select.add("COMPRESSED (ATF)", Context3DTextureFormat.COMPRESSED);
			select.add("COMPRESSED_ALPHA (ATF)", Context3DTextureFormat.COMPRESSED_ALPHA);
			select.add("RGBA_HALF_FLOAT", Context3DTextureFormat.RGBA_HALF_FLOAT);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("forcePotTexture"))
		{
			bool = new ExposedBool("forcePotTexture");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTextureOptions(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("forcePotTexture"))
		{
			bool = new ExposedBool("forcePotTexture");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("format"))
		{
			select = new ExposedSelect("format");
			select.add("BGR_PACKED", Context3DTextureFormat.BGR_PACKED);
			select.add("BGRA", Context3DTextureFormat.BGRA);
			select.add("BGRA_PACKED", Context3DTextureFormat.BGRA_PACKED);
			select.add("COMPRESSED (ATF)", Context3DTextureFormat.COMPRESSED);
			select.add("COMPRESSED_ALPHA (ATF)", Context3DTextureFormat.COMPRESSED_ALPHA);
			select.add("RGBA_HALF_FLOAT", Context3DTextureFormat.RGBA_HALF_FLOAT);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("mipMapping"))
		{
			bool = new ExposedBool("mipMapping");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("optimizeForRenderToTexture"))
		{
			bool = new ExposedBool("optimizeForRenderToTexture");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("premultipliedAlpha"))
		{
			bool = new ExposedBool("premultipliedAlpha");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("scale"))
		{
			floatDrag = new ExposedFloatDrag("scale", null, 0, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTextureOptionsConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var select:ExposedSelect;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("scale"))
		{
			floatDrag = new ExposedFloatDrag("scale", null, 0, null, 0.05);
			floatDrag.defaultValue = 1.0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("mipMapping"))
		{
			bool = new ExposedBool("mipMapping");
			bool.defaultValue = false;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("format"))
		{
			select = new ExposedSelect("format");
			select.add("BGR_PACKED", Context3DTextureFormat.BGR_PACKED);
			select.add("BGRA", Context3DTextureFormat.BGRA);
			select.add("BGRA_PACKED", Context3DTextureFormat.BGRA_PACKED);
			select.add("COMPRESSED (ATF)", Context3DTextureFormat.COMPRESSED);
			select.add("COMPRESSED_ALPHA (ATF)", Context3DTextureFormat.COMPRESSED_ALPHA);
			select.add("RGBA_HALF_FLOAT", Context3DTextureFormat.RGBA_HALF_FLOAT);
			select.defaultValue = Context3DTextureFormat.BGRA;
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("premultipliedAlpha"))
		{
			bool = new ExposedBool("premultipliedAlpha");
			bool.defaultValue = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("forcePotTexture"))
		{
			bool = new ExposedBool("forcePotTexture");
			bool.defaultValue = false;
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
}