package valedit.data.starling.texture;
#if starling
import openfl.display3D.Context3DTextureFormat;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObject;
import valedit.value.ExposedSelect;

/**
 * ...
 * @author Matse
 */
class StarlingTextureData 
{
	static public function exposeAtfData(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var intDrag:ExposedIntDrag;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("width"))
		{
			intDrag = new ExposedIntDrag("width");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			intDrag = new ExposedIntDrag("height");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("format"))
		{
			select = new ExposedSelect("format");
			select.isReadOnly = true;
			select.add("BGR_PACKED", Context3DTextureFormat.BGR_PACKED);
			select.add("BGRA", Context3DTextureFormat.BGRA);
			select.add("BGRA_PACKED", Context3DTextureFormat.BGRA_PACKED);
			select.add("COMPRESSED (ATF)", Context3DTextureFormat.COMPRESSED);
			select.add("COMPRESSED_ALPHA (ATF)", Context3DTextureFormat.COMPRESSED_ALPHA);
			select.add("RGBA_HALF_FLOAT", Context3DTextureFormat.RGBA_HALF_FLOAT);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("isCubeMap"))
		{
			bool = new ExposedBool("isCubeMap");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("numTextures"))
		{
			intDrag = new ExposedIntDrag("numTextures");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeConcreteTexture(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeTexture(collection, groupName);
		
		if (!collection.hasValue("isPotTexture"))
		{
			bool = new ExposedBool("isPotTexture");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("optimizedForRenderTexture"))
		{
			bool = new ExposedBool("optimizedForRenderTexture");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeRenderTexture(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeSubTexture(collection, groupName);
		
		if (!collection.hasValue("isPersistent"))
		{
			bool = new ExposedBool("isPersistent");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeRenderTextureConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var select:ExposedSelect;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("width"))
		{
			intDrag = new ExposedIntDrag("width");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			intDrag = new ExposedIntDrag("height");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("persistent"))
		{
			bool = new ExposedBool("persistent");
			bool.defaultValue = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("scale"))
		{
			floatDrag = new ExposedFloatDrag("scale", null, -1.0, null, 0.01);
			floatDrag.defaultValue = -1.0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("format"))
		{
			select = new ExposedSelect("format");
			select.defaultValue = Context3DTextureFormat.BGRA;
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
			bool.defaultValue = false;
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeSubTexture(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var obj:ExposedObject;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeTexture(collection, groupName);
		
		if (!collection.hasValue("rotated"))
		{
			bool = new ExposedBool("rotated");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("region"))
		{
			obj = new ExposedObject("region");
			obj.isReadOnly = true;
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("ownsParent"))
		{
			bool = new ExposedBool("ownsParent");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("parent"))
		{
			obj = new ExposedObject("parent");
			obj.isReadOnly = true;
			collection.addValue(obj, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTexture(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var obj:ExposedObject;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("width"))
		{
			floatDrag = new ExposedFloatDrag("width");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			floatDrag = new ExposedFloatDrag("height");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("format"))
		{
			select = new ExposedSelect("format");
			select.isReadOnly = true;
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
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("premultipliedAlpha"))
		{
			bool = new ExposedBool("premultipliedAlpha");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("nativeWidth"))
		{
			floatDrag = new ExposedFloatDrag("nativeWidth");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("nativeHeight"))
		{
			floatDrag = new ExposedFloatDrag("nativeHeight");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("scale"))
		{
			floatDrag = new ExposedFloatDrag("scale");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("frame"))
		{
			obj = new ExposedObject("frame");
			obj.isReadOnly = true;
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("frameWidth"))
		{
			floatDrag = new ExposedFloatDrag("frameWidth");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("frameHeight"))
		{
			floatDrag = new ExposedFloatDrag("frameHeight");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("transformationMatrix"))
		{
			obj = new ExposedObject("transformationMatrix");
			obj.isReadOnly = true;
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("transformationMatrixToRoot"))
		{
			obj = new ExposedObject("transformationMatrixToRoot");
			obj.isReadOnly = true;
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("root"))
		{
			obj = new ExposedObject("root");
			obj.isReadOnly = true;
			collection.addValue(obj, groupName);
		}
		
		return collection;
	}
	
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
#end