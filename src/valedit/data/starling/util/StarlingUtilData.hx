package valedit.data.starling.util;
import openfl.display3D.Context3DTextureFormat;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloat;
import valedit.value.ExposedSelect;
import valedit.value.NumericMode;

/**
 * ...
 * @author Matse
 */
class StarlingUtilData 
{
	
	static public function exposeTextureCreationParameters(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var boolVal:ExposedBool;
		var floatVal:ExposedFloat;
		var selectVal:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("generateMipMaps"))
		{
			boolVal = new ExposedBool("generateMipMaps");
			collection.addValue(boolVal, groupName);
		}
		
		if (!collection.hasValue("optimizeForRenderToTexture"))
		{
			boolVal = new ExposedBool("optimizeForRenderToTexture");
			collection.addValue(boolVal, groupName);
		}
		
		if (!collection.hasValue("scale"))
		{
			floatVal = new ExposedFloat("scale", null, 2, NumericMode.Positive);
			collection.addValue(floatVal);
		}
		
		if (!collection.hasValue("format"))
		{
			selectVal = new ExposedSelect("format");
			selectVal.add("BGR_PACKED", Context3DTextureFormat.BGR_PACKED);
			selectVal.add("BGRA", Context3DTextureFormat.BGRA);
			selectVal.add("BGRA_PACKED", Context3DTextureFormat.BGRA_PACKED);
			selectVal.add("COMPRESSED", Context3DTextureFormat.COMPRESSED);
			selectVal.add("COMPRESSED_ALPHA", Context3DTextureFormat.COMPRESSED_ALPHA);
			selectVal.add("RGBA_HALF_FLOAT", Context3DTextureFormat.RGBA_HALF_FLOAT);
			collection.addValue(selectVal);
		}
		
		if (!collection.hasValue("forcePotTexture"))
		{
			boolVal = new ExposedBool("forcePotTexture");
			collection.addValue(boolVal);
		}
		
		return collection;
	}
	
}