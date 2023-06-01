package valedit.data.openfl.display;
import openfl.display.BlendMode;
import openfl.display.DisplayObject;
import openfl.display.PixelSnapping;
import openfl.display.StageAlign;
import openfl.display.StageDisplayState;
import openfl.display.StageQuality;
import openfl.display.StageScaleMode;
import ui.feathers.variant.TextInputVariant;
import valedit.ExposedCollection;
import valedit.data.openfl.text.TextData;
import valedit.value.ExposedBitmapData;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloat;
import valedit.value.ExposedFloatRange;
import valedit.value.ExposedInt;
import valedit.value.ExposedObject;
import valedit.value.ExposedObjectReference;
import valedit.value.ExposedSelect;
import valedit.value.ExposedString;
import valedit.value.NumericMode;

/**
 * ...
 * @author Matse
 */
class DisplayData 
{
	
	static public function exposeBitmap(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bmd:ExposedBitmapData;
		var bool:ExposedBool;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObject(collection, groupName);
		
		if (!collection.hasValue("bitmapData"))
		{
			bmd = new ExposedBitmapData("bitmapData");
			collection.addValue(bmd, groupName);
		}
		
		if (!collection.hasValue("pixelSnapping"))
		{
			select = new ExposedSelect("pixelSnapping");
			select.add("ALWAYS", PixelSnapping.ALWAYS);
			select.add("AUTO", PixelSnapping.AUTO);
			select.add("NEVER", PixelSnapping.NEVER);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("smoothing"))
		{
			bool = new ExposedBool("smoothing");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeBitmapConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bmd:ExposedBitmapData;
		var bool:ExposedBool;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("bitmapData"))
		{
			bmd = new ExposedBitmapData("bitmapData");
			collection.addValue(bmd, groupName);
		}
		
		if (!collection.hasValue("pixelSnapping"))
		{
			select = new ExposedSelect("pixelSnapping");
			select.add("ALWAYS", PixelSnapping.ALWAYS);
			select.add("AUTO", PixelSnapping.AUTO);
			select.add("NEVER", PixelSnapping.NEVER);
			select.defaultValue = PixelSnapping.AUTO;
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("smoothing"))
		{
			bool = new ExposedBool("smoothing");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeDisplayObject(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var float:ExposedFloat;
		var floatRange:ExposedFloatRange;
		var obj:ExposedObject;
		var objRef:ExposedObjectReference;
		var select:ExposedSelect;
		var string:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("name"))
		{
			string = new ExposedString("name");
			collection.addValue(string, groupName);
		}
		
		if (!collection.hasValue("x"))
		{
			float = new ExposedFloat("x");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("y"))
		{
			float = new ExposedFloat("y");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("width"))
		{
			float = new ExposedFloat("width");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			float = new ExposedFloat("height");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("scaleX"))
		{
			float = new ExposedFloat("scaleX");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("scaleY"))
		{
			float = new ExposedFloat("scaleY");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("alpha"))
		{
			floatRange = new ExposedFloatRange("alpha", null, 0, 1, 0.01, 2, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange, groupName);
		}
		
		if (!collection.hasValue("rotation"))
		{
			floatRange = new ExposedFloatRange("rotation", null, -180, 180, 1, 2, TextInputVariant.NUMERIC_SMALL);
			collection.addValue(floatRange, groupName);
		}
		
		if (!collection.hasValue("blendMode"))
		{
			select = new ExposedSelect("blendMode");
			select.add("ADD", BlendMode.ADD);
			select.add("ALPHA", BlendMode.ALPHA);
			select.add("DARKEN", BlendMode.DARKEN);
			select.add("DIFFERENCE", BlendMode.DIFFERENCE);
			select.add("ERASE", BlendMode.ERASE);
			select.add("HARDLIGHT", BlendMode.HARDLIGHT);
			select.add("INVERT", BlendMode.INVERT);
			select.add("LAYER", BlendMode.LAYER);
			select.add("LIGHTEN", BlendMode.LIGHTEN);
			select.add("MULTIPLY", BlendMode.MULTIPLY);
			select.add("NORMAL", BlendMode.NORMAL);
			select.add("OVERLAY", BlendMode.OVERLAY);
			select.add("SCREEN", BlendMode.SCREEN);
			select.add("SHADER", BlendMode.SHADER);
			select.add("SUBTRACT", BlendMode.SUBTRACT);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("mask"))
		{
			objRef = new ExposedObjectReference("mask");
			objRef.addClass(DisplayObject);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("transform"))
		{
			obj = new ExposedObject("transform", null, true, true);
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("cacheAsBitmap"))
		{
			bool = new ExposedBool("cacheAsBitmap");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("visible"))
		{
			bool = new ExposedBool("visible");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeDisplayObjectContainer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeInteractiveObject(collection, groupName);
		
		if (!collection.hasValue("mouseChildren"))
		{
			bool = new ExposedBool("mouseChildren");
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("tabChildren"))
		{
			bool = new ExposedBool("tabChildren");
			collection.addValue(bool);
		}
		
		return collection;
	}
	
	static public function exposeFPS(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		TextData.exposeTextField(collection, groupName);
		
		return collection;
	}
	
	static public function exposeFPSConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var color:ExposedColor;
		var float:ExposedFloat;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("x"))
		{
			float = new ExposedFloat("x");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("y"))
		{
			float = new ExposedFloat("y");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color, groupName);
		}
		
		return collection;
	}
	
	static public function exposeInteractiveObject(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var int:ExposedInt;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObject(collection, groupName);
		
		if (!collection.hasValue("doubleClickEnabled"))
		{
			bool = new ExposedBool("doubleClickEnabled");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("focusRect"))
		{
			bool = new ExposedBool("focusRect");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("mouseEnabled"))
		{
			bool = new ExposedBool("mouseEnabled");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("needsSoftKeyboard"))
		{
			bool = new ExposedBool("needsSoftKeyboard");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("tabEnabled"))
		{
			bool = new ExposedBool("tabEnabled");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("tabIndex"))
		{
			int = new ExposedInt("tabIndex");
			collection.addValue(int, groupName);
		}
		
		return collection;
	}
	
	static public function exposeMovieClip(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeSprite(collection, groupName);
		
		if (!collection.hasValue("enabled"))
		{
			bool = new ExposedBool("enabled");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeShape(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObject(collection, groupName);
		
		return collection;
	}
	
	static public function exposeSprite(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObjectContainer(collection, groupName);
		
		if (!collection.hasValue("buttonMode"))
		{
			bool = new ExposedBool("buttonMode");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("useHandCursor"))
		{
			bool = new ExposedBool("useHandCursor");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeStage(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var float:ExposedFloat;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("align"))
		{
			select = new ExposedSelect("align");
			select.add("bottom", StageAlign.BOTTOM);
			select.add("bottomLeft", StageAlign.BOTTOM_LEFT);
			select.add("bottomRight", StageAlign.BOTTOM_RIGHT);
			select.add("left", StageAlign.LEFT);
			select.add("right", StageAlign.RIGHT);
			select.add("top", StageAlign.TOP);
			select.add("topLeft", StageAlign.TOP_LEFT);
			select.add("topRight", StageAlign.TOP_RIGHT);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("displayState"))
		{
			select = new ExposedSelect("displayState");
			select.add("fullScreen", StageDisplayState.FULL_SCREEN);
			select.add("fullScreenInteractive", StageDisplayState.FULL_SCREEN_INTERACTIVE);
			select.add("normal", StageDisplayState.NORMAL);
			collection.addValue(select, groupName);
		}
		
		// TODO : focus
		
		if (!collection.hasValue("frameRate"))
		{
			float = new ExposedFloat("frameRate", null, 2, NumericMode.Positive);
			collection.addValue(float, groupName);
		}
		
		// TODO : fullScreenSourceRect
		
		if (!collection.hasValue("quality"))
		{
			select = new ExposedSelect("quality");
			select.add("low", StageQuality.LOW);
			select.add("medium", StageQuality.MEDIUM);
			select.add("high", StageQuality.HIGH);
			select.add("best", StageQuality.BEST);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("scaleMode"))
		{
			select = new ExposedSelect("scaleMode");
			select.add("exact fit", StageScaleMode.EXACT_FIT);
			select.add("no border", StageScaleMode.NO_BORDER);
			select.add("no scale", StageScaleMode.NO_SCALE);
			select.add("show all", StageScaleMode.SHOW_ALL);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("showDefaultContextMenu"))
		{
			bool = new ExposedBool("showDefaultContextMenu");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("stageFocusRect"))
		{
			bool = new ExposedBool("stageFocusRect");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
}