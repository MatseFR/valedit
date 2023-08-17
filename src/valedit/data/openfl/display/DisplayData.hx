package valedit.data.openfl.display;
import openfl.display.BlendMode;
import openfl.display.DisplayObject;
import openfl.display.PixelSnapping;
import openfl.display.StageAlign;
import openfl.display.StageDisplayState;
import openfl.display.StageQuality;
import openfl.display.StageScaleMode;
import valedit.ExposedCollection;
import valedit.data.openfl.text.TextData;
import valedit.value.ExposedBitmapData;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObject;
import valedit.value.ExposedObjectReference;
import valedit.value.ExposedSelect;
import valedit.value.ExposedString;

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
		var floatDrag:ExposedFloatDrag;
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
			floatDrag = new ExposedFloatDrag("x");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("y"))
		{
			floatDrag = new ExposedFloatDrag("y");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("width"))
		{
			floatDrag = new ExposedFloatDrag("width");
			floatDrag.isTweenable = false; // don't tween width since it will become messy with rotation, scaleX will be used instead
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			floatDrag = new ExposedFloatDrag("height");
			floatDrag.isTweenable = false; // don't tween height since it will become messy with rotation, scaleY will be used instead
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
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, 0, 1, 0.005);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("rotation"))
		{
			floatDrag = new ExposedFloatDrag("rotation", null, null, null, 0.5);
			floatDrag.isAbsolute = true;
			collection.addValue(floatDrag, groupName);
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
		var intDrag:ExposedIntDrag;
		
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
			intDrag = new ExposedIntDrag("tabIndex", null, -1);
			collection.addValue(intDrag, groupName);
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
		var floatDrag:ExposedFloatDrag;
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
			floatDrag = new ExposedFloatDrag("frameRate", null, 0, 120, 0.5, 1);
			collection.addValue(floatDrag, groupName);
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