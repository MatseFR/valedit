package valedit.data.starling.util;
import openfl.display3D.Context3DTextureFormat;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedSelect;

/**
 * ...
 * @author Matse
 */
class StarlingUtilData 
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
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("format"))
		{
			select = new ExposedSelect("format");
			select.add("BGR_PACKED", Context3DTextureFormat.BGR_PACKED);
			select.add("BGRA", Context3DTextureFormat.BGRA);
			select.add("BGRA_PACKED", Context3DTextureFormat.BGRA_PACKED);
			select.add("COMPRESSED", Context3DTextureFormat.COMPRESSED);
			select.add("COMPRESSED_ALPHA", Context3DTextureFormat.COMPRESSED_ALPHA);
			select.add("RGBA_HALF_FLOAT", Context3DTextureFormat.RGBA_HALF_FLOAT);
			collection.addValue(select);
		}
		
		if (!collection.hasValue("forcePotTexture"))
		{
			bool = new ExposedBool("forcePotTexture");
			collection.addValue(bool);
		}
		
		return collection;
	}
	
}