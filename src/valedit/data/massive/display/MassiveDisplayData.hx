package valedit.data.massive.display;
import massive.data.MassiveConstants;
import massive.display.MassiveColorMode;
import massive.display.MassiveRenderMode;
import starling.textures.TextureSmoothing;
import valedit.data.starling.display.StarlingDisplayData;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedSelect;
import valedit.value.ExposedString;
import valedit.value.base.ExposedValue;
import valedit.value.starling.ExposedStarlingTexture;

/**
 * ...
 * @author Matse
 */
class MassiveDisplayData 
{

	static public function exposeMassiveDisplay(?collection:ExposedCollection, ?groupName:String):ExposedCollection
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
		
		if (!collection.hasValue("red"))
		{
			floatDrag = new ExposedFloatDrag("red", null, 0, 10, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("green"))
		{
			floatDrag = new ExposedFloatDrag("green", null, 0, 10, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blue"))
		{
			floatDrag = new ExposedFloatDrag("blue", null, 0, 10, 0.1);
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
			select.add(TextureSmoothing.BILINEAR);
			select.add(TextureSmoothing.NONE);
			select.add(TextureSmoothing.TRILINEAR);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("renderMode"))
		{
			select = new ExposedSelect("renderMode");
			select.choiceListFunction = MassiveRenderMode.getValues;
			select.valueListFunction = MassiveRenderMode.getValues;
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("colorMode"))
		{
			select = new ExposedSelect("colorMode");
			select.choiceListFunction = MassiveColorMode.getValues;
			select.valueListFunction = MassiveColorMode.getValues;
			collection.addValue(select, groupName);
		}
		
		StarlingDisplayData.exposeDisplayObject(collection, groupName);
		
		return collection;
	}
	
	static private function exposeMassiveLayer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var intDrag:ExposedIntDrag;
		var string:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("name"))
		{
			string = new ExposedString("name");
			collection.addValue(string, groupName);
		}
		
		if (!collection.hasValue("numDatas"))
		{
			intDrag = new ExposedIntDrag("numDatas");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("totalDatas"))
		{
			intDrag = new ExposedIntDrag("totalDatas");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("animate"))
		{
			bool = new ExposedBool("animate");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeMassiveImageLayer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeMassiveLayer(collection, groupName);
		
		var value:ExposedValue = collection.getValue("numDatas");
		if (value != null)
		{
			value.isReadOnly = true;
		}
		
		if (!collection.hasValue("textureAnimation"))
		{
			bool = new ExposedBool("textureAnimation");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeMassiveQuadLayer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeMassiveLayer(collection, groupName);
		
		return collection;
	}
	
}