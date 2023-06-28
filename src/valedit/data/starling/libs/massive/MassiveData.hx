package valedit.data.starling.libs.massive;
import massive.data.MassiveConstants;
import starling.textures.TextureSmoothing;
import starling.utils.Align;
import valedit.ExposedCollection;
import valedit.data.starling.display.StarlingDisplayData;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedFunction;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObjectReference;
import valedit.value.ExposedSelect;
import valedit.value.ExposedString;
import valedit.value.extra.FunctionCallExtra;
import valedit.value.starling.ExposedStarlingTexture;

/**
 * ...
 * @author Matse
 */
class MassiveData 
{

	static private function exposeDisplayData(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		//var floatRange:ExposedFloatRange;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("x"))
		{
			floatDrag = new ExposedFloatDrag("x");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("y"))
		{
			floatDrag = new ExposedFloatDrag("y");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("offsetX"))
		{
			floatDrag = new ExposedFloatDrag("offsetX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("offsetY"))
		{
			floatDrag = new ExposedFloatDrag("offsetY");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("rotation"))
		{
			floatDrag = new ExposedFloatDrag("rotation", null, null, 0.01);
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
		
		if (!collection.hasValue("colorRed"))
		{
			floatDrag = new ExposedFloatDrag("colorRed", null, -1, 10, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("colorGreen"))
		{
			floatDrag = new ExposedFloatDrag("colorGreen", null, -1, 10, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("colorBlue"))
		{
			floatDrag = new ExposedFloatDrag("colorBlue", null, -1, 10, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("colorAlpha"))
		{
			floatDrag = new ExposedFloatDrag("colorAlpha", null, 0, 1, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("visible"))
		{
			bool = new ExposedBool("visible");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeFrame(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var func:ExposedFunction;
		var select:ExposedSelect;
		
		var funcExtra:FunctionCallExtra;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("pivotX"))
		{
			floatDrag = new ExposedFloatDrag("pivotX");
			funcExtra = new FunctionCallExtra("pivotUpdate");
			floatDrag.extras.add(funcExtra);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("pivotY"))
		{
			floatDrag = new ExposedFloatDrag("pivotY");
			funcExtra = new FunctionCallExtra("pivotUpdate");
			floatDrag.extras.add(funcExtra);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alignPivot"))
		{
			func = new ExposedFunction("alignPivot", "align pivot");
			
			select = new ExposedSelect("horizontal align");
			select.add("center", Align.CENTER);
			select.add("left", Align.LEFT);
			select.add("right", Align.RIGHT);
			func.addParameter(select);
			
			select = new ExposedSelect("vertical align");
			select.add("center", Align.CENTER);
			select.add("top", Align.TOP);
			select.add("bottom", Align.BOTTOM);
			func.addParameter(select);
			
			collection.addValue(func, groupName);
		}
		
		return collection;
	}
	
	static public function exposeFrameProxy(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var func:ExposedFunction;
		var select:ExposedSelect;
		var texture:ExposedStarlingTexture;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("texture"))
		{
			texture = new ExposedStarlingTexture("texture");
			collection.addValue(texture, groupName);
		}
		
		if (!collection.hasValue("pivotX"))
		{
			floatDrag = new ExposedFloatDrag("pivotX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("pivotY"))
		{
			floatDrag = new ExposedFloatDrag("pivotY");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alignPivot"))
		{
			func = new ExposedFunction("alignPivot", "align pivot");
			
			select = new ExposedSelect("horizontal align");
			select.add("center", Align.CENTER);
			select.add("left", Align.LEFT);
			select.add("right", Align.RIGHT);
			func.addParameter(select);
			
			select = new ExposedSelect("vertical align");
			select.add("center", Align.CENTER);
			select.add("top", Align.TOP);
			select.add("bottom", Align.BOTTOM);
			func.addParameter(select);
			
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("width"))
		{
			floatDrag = new ExposedFloatDrag("width", null, 0);
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeImageData(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayData(collection, groupName);
		
		if (!collection.hasValue("invertX"))
		{
			bool = new ExposedBool("invertX");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("invertY"))
		{
			bool = new ExposedBool("invertY");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeImageDataProxy(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("x"))
		{
			floatDrag = new ExposedFloatDrag("x");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("y"))
		{
			floatDrag = new ExposedFloatDrag("y");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("offsetX"))
		{
			floatDrag = new ExposedFloatDrag("offsetX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("offsetY"))
		{
			floatDrag = new ExposedFloatDrag("offsetY");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("rotation"))
		{
			floatDrag = new ExposedFloatDrag("rotation", null, null, null, 0.01);
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
		
		if (!collection.hasValue("visible"))
		{
			bool = new ExposedBool("visible");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("invertX"))
		{
			bool = new ExposedBool("invertX");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("invertY"))
		{
			bool = new ExposedBool("invertY");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	public function exposeImageDataProxyConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var objectRef:ExposedObjectReference;
		
		if (collection == null) collection = new ExposedCollection();
		
		return collection;
	}
	
	static private function exposeMassiveDisplayData(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var select:ExposedSelect;
		var texture:ExposedStarlingTexture;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("autoHandleJuggler"))
		{
			bool = new ExposedBool("autoHandleJuggler");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("bufferSize"))
		{
			intDrag = new ExposedIntDrag("bufferSize", null, 0, MassiveConstants.MAX_QUADS);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("numBuffers"))
		{
			intDrag = new ExposedIntDrag("numBuffers", null, 1, 8);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("colorRed"))
		{
			floatDrag = new ExposedFloatDrag("colorRed", null, 0, 10, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("colorGreen"))
		{
			floatDrag = new ExposedFloatDrag("colorGreen", null, 0, 10, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("colorBlue"))
		{
			floatDrag = new ExposedFloatDrag("colorBlue", null, 0, 10, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("renderOffsetX"))
		{
			floatDrag = new ExposedFloatDrag("renderOffsetX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("renderOffsetY"))
		{
			floatDrag = new ExposedFloatDrag("renderOffsetY");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("texture"))
		{
			texture = new ExposedStarlingTexture("texture");
			collection.addValue(texture, groupName);
		}
		
		if (!collection.hasValue("textureRepeat"))
		{
			bool = new ExposedBool("textureRepeat");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("textureSmoothing"))
		{
			select = new ExposedSelect("textureSmoothing");
			select.add("BILINEAR", TextureSmoothing.BILINEAR);
			select.add("NONE", TextureSmoothing.NONE);
			select.add("TRILINEAR", TextureSmoothing.TRILINEAR);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("useByteArray"))
		{
			bool = new ExposedBool("useByteArray");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("useColor"))
		{
			bool = new ExposedBool("useColor");
			collection.addValue(bool, groupName);
		}
		
		StarlingDisplayData.exposeDisplayObject(collection, groupName);
		
		return collection;
	}
	
	static private function exposeMassiveLayer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var string:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("name"))
		{
			string = new ExposedString("name");
			collection.addValue(string, groupName);
		}
		
		return collection;
	}
	
	static public function exposeMassiveImageLayer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeMassiveLayer(collection, groupName);
		
		return collection;
	}
	
	static public function exposeMassiveQuadLayer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeMassiveLayer(collection, groupName);
		
		return collection;
	}
	
	static public function exposeQuadData(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var func:ExposedFunction;
		var select:ExposedSelect;
		
		var funcExtra:FunctionCallExtra;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayData(collection, groupName);
		
		if (!collection.hasValue("width"))
		{
			floatDrag = new ExposedFloatDrag("width");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			floatDrag = new ExposedFloatDrag("height");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("pivotX"))
		{
			floatDrag = new ExposedFloatDrag("pivotX");
			funcExtra = new FunctionCallExtra("pivotUpdate");
			floatDrag.extras.add(funcExtra);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("pivotY"))
		{
			floatDrag = new ExposedFloatDrag("pivotY");
			funcExtra = new FunctionCallExtra("pivotUpdate");
			floatDrag.extras.add(funcExtra);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alignPivot"))
		{
			func = new ExposedFunction("alignPivot", "align pivot");
			
			select = new ExposedSelect("horizontal align");
			select.add("center", Align.CENTER);
			select.add("left", Align.LEFT);
			select.add("right", Align.RIGHT);
			func.addParameter(select);
			
			select = new ExposedSelect("vertical align");
			select.add("center", Align.CENTER);
			select.add("top", Align.TOP);
			select.add("bottom", Align.BOTTOM);
			func.addParameter(select);
			
			collection.addValue(func, groupName);
		}
		
		return collection;
	}
	
	static public function exposeQuadDataProxy(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("x"))
		{
			floatDrag = new ExposedFloatDrag("x");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("y"))
		{
			floatDrag = new ExposedFloatDrag("y");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("offsetX"))
		{
			floatDrag = new ExposedFloatDrag("offsetX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("offsetY"))
		{
			floatDrag = new ExposedFloatDrag("offsetY");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("width"))
		{
			floatDrag = new ExposedFloatDrag("width");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			floatDrag = new ExposedFloatDrag("height");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("pivotX"))
		{
			floatDrag = new ExposedFloatDrag("pivotX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("pivotY"))
		{
			floatDrag = new ExposedFloatDrag("pivotY");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("rotation"))
		{
			floatDrag = new ExposedFloatDrag("rotation", null, null, null, 0.01);
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
		
		if (!collection.hasValue("visible"))
		{
			bool = new ExposedBool("visible");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeQuadDataProxyConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("width"))
		{
			floatDrag = new ExposedFloatDrag("width");
			floatDrag.defaultValue = 100;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("height"))
		{
			floatDrag = new ExposedFloatDrag("height");
			floatDrag.defaultValue = 100;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color);
		}
		
		return collection;
	}
	
}