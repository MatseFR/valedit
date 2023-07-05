package valedit.data.starling.styles;
import starling.styles.DistanceFieldStyle;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedFunction;
import valedit.value.ExposedSelect;
import valedit.value.starling.ExposedStarlingTexture;

/**
 * ...
 * @author Matse
 */
class StarlingStylesData 
{

	static public function exposeDistanceFieldStyle(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var func:ExposedFunction;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, 0, 1, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("mode"))
		{
			select = new ExposedSelect("mode");
			select.add("basic", DistanceFieldStyle.MODE_BASIC);
			select.add("glow", DistanceFieldStyle.MODE_GLOW);
			select.add("outline", DistanceFieldStyle.MODE_OUTLINE);
			select.add("shadow", DistanceFieldStyle.MODE_SHADOW);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("multiChannel"))
		{
			bool = new ExposedBool("multiChannel");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("outerAlphaStart"))
		{
			floatDrag = new ExposedFloatDrag("outerAlphaStart", null, 0, 1, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("outerAlphaEnd"))
		{
			floatDrag = new ExposedFloatDrag("outerAlphaEnd", null, 0, 1, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("outerColor"))
		{
			color = new ExposedColor("outerColor");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("outerThreshold"))
		{
			floatDrag = new ExposedFloatDrag("outerThreshold");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("shadowOffsetX"))
		{
			floatDrag = new ExposedFloatDrag("shadowOffsetX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("shadowOffsetY"))
		{
			floatDrag = new ExposedFloatDrag("shadowOffsetY");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("softness"))
		{
			floatDrag = new ExposedFloatDrag("softness");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("threshold"))
		{
			floatDrag = new ExposedFloatDrag("threshold");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("setupBasic"))
		{
			func = new ExposedFunction("setupBasic");
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("setupDropShadow"))
		{
			func = new ExposedFunction("setupDropShadow");
			floatDrag = new ExposedFloatDrag("blur", null, 0, null, 0.05);
			floatDrag.defaultValue = 0.2;
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("offsetX");
			floatDrag.defaultValue = 2.0;
			func.addParameter(floatDrag);
			floatDrag = new ExposedFloatDrag("offsetY");
			floatDrag.defaultValue = 2.0;
			color = new ExposedColor("color");
			color.defaultValue = 0x0;
			func.addParameter(color);
			floatDrag = new ExposedFloatDrag("alpha", null, 0, 1, 0.05);
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("setupGlow"))
		{
			func = new ExposedFunction("setupGlow");
			floatDrag = new ExposedFloatDrag("blur", null, 0, null, 0.05);
			floatDrag.defaultValue = 0.2;
			func.addParameter(floatDrag);
			color = new ExposedColor("color");
			color.defaultValue = 0xffff00;
			func.addParameter(color);
			floatDrag = new ExposedFloatDrag("alpha", null, 0, 1, 0.05);
			floatDrag.defaultValue = 0.5;
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("setupOutline"))
		{
			func = new ExposedFunction("setupOutline");
			// width:Number = 0.25, color:uint = 0x0, alpha:Number = 1.0
			floatDrag = new ExposedFloatDrag("width", null, 0, 1, 0.05);
			floatDrag.defaultValue = 0.25;
			func.addParameter(floatDrag);
			color = new ExposedColor("color")
			color.defaultValue = 0x0;
			func.addParameter(color);
			floatDrag = new ExposedFloatDrag("alpha", null, 0, 1, 0.05);
			floatDrag.defaultValue = 1.0;
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		return collection;
	}
	
	static public function exposeDistanceFieldStyleConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("softness"))
		{
			floatDrag = new ExposedFloatDrag("softness");
			floatDrag.defaultValue = 0.125;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("threshold"))
		{
			floatDrag = new ExposedFloatDrag("threshold");
			floatDrag.defaultValue = 0.5;
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeMeshStyle(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var select:ExposedSelect;
		var texture:ExposedStarlingTexture;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color, groupName);
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
		
		return collection;
	}
	
	static public function exposeMeshStyleConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		return collection;
	}
	
}