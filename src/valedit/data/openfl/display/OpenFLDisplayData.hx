package valedit.data.openfl.display;
#if air
import flash.display.NativeWindowRenderMode;
#end
import openfl.display.BlendMode;
import openfl.display.DisplayObject;
#if desktop
import openfl.display.NativeWindow;
import openfl.display.NativeWindowDisplayState;
import openfl.display.NativeWindowInitOptions;
import openfl.display.NativeWindowSystemChrome;
import openfl.display.NativeWindowType;
#end
import openfl.display.PixelSnapping;
import openfl.display.StageAlign;
import openfl.display.StageDisplayState;
import openfl.display.StageQuality;
import openfl.display.StageScaleMode;
import openfl.display.Tileset;
import valedit.ExposedCollection;
import valedit.data.openfl.text.OpenFLTextData;
import valedit.value.ExposedBitmapData;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObject;
import valedit.value.ExposedObjectReference;
import valedit.value.ExposedSelect;
import valedit.value.ExposedString;
import valedit.value.extra.ReadValuesExtra;
import valeditor.editor.visibility.ClassValueVisibility;
import valeditor.editor.visibility.ClassVisibilityCollection;

/**
 * ...
 * @author Matse
 */
class OpenFLDisplayData 
{
	/* data for a Bitmap object */
	static public function exposeBitmap(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bmd:ExposedBitmapData;
		var bool:ExposedBool;
		var readExtra:ReadValuesExtra;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObject(collection, groupName);
		
		if (!collection.hasValue("bitmapData"))
		{
			bmd = new ExposedBitmapData("bitmapData");
			readExtra = new ReadValuesExtra(false, ["width", "height"]);
			bmd.extras.add(readExtra);
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
	
	static public function getBitmapVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getDisplayObjectVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("bitmapData", true, false));
		collection.add(ClassValueVisibility.fromPool("pixelSnapping", true, false));
		collection.add(ClassValueVisibility.fromPool("smoothing", true, false));
		
		return collection;
	}
	
	static public function exposeBitmapConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bmd:ExposedBitmapData;
		var bool:ExposedBool;
		var select:ExposedSelect;
		
		if (collection == null) 
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
			collection.useActions = false;
		}
		
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
	
	static public function exposeBitmapData(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var intDrag:ExposedIntDrag;
		var obj:ExposedObject;
		
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
		
		if (!collection.hasValue("image"))
		{
			obj = new ExposedObject("image");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("readable"))
		{
			bool = new ExposedBool("readable");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("rect"))
		{
			obj = new ExposedObject("rect");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("transparent"))
		{
			bool = new ExposedBool("transparent");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeBitmapDataConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var intDrag:ExposedIntDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("width"))
		{
			intDrag = new ExposedIntDrag("width", null, 1);
			intDrag.isMandatory = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			intDrag = new ExposedIntDrag("height", null, 1);
			intDrag.isMandatory = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("transparent"))
		{
			bool = new ExposedBool("transparent");
			bool.defaultValue = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("fillColor"))
		{
			color = new ExposedColor("fillColor");
			collection.addValue(color, groupName);
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
			objRef.allowClass(DisplayObject);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("transform"))
		{
			obj = new ExposedObject("transform");
			// TODO : interpolating matrix's a, b, c & d values gives weird results
			obj.addNonTweenablePropertyName("matrix");
			//obj.addNonTweenableDeepPropertyName(["matrix", "tx"]);
			//obj.addNonTweenableDeepPropertyName(["matrix", "ty"]);
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
	
	static public function getDisplayObjectVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		collection.add(ClassValueVisibility.fromPool("name"));
		collection.add(ClassValueVisibility.fromPool("x"));
		collection.add(ClassValueVisibility.fromPool("y"));
		collection.add(ClassValueVisibility.fromPool("width"));
		collection.add(ClassValueVisibility.fromPool("height"));
		collection.add(ClassValueVisibility.fromPool("scaleX"));
		collection.add(ClassValueVisibility.fromPool("scaleY"));
		collection.add(ClassValueVisibility.fromPool("alpha"));
		collection.add(ClassValueVisibility.fromPool("rotation"));
		collection.add(ClassValueVisibility.fromPool("blendMode"));
		collection.add(ClassValueVisibility.fromPool("mask"));
		collection.add(ClassValueVisibility.fromPool("transform"));
		collection.add(ClassValueVisibility.fromPool("cacheAsBitmap"));
		collection.add(ClassValueVisibility.fromPool("visible"));
		
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
	
	static public function getDisplayObjectContainerVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getDisplayObjectVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("mouseChildren"));
		collection.add(ClassValueVisibility.fromPool("tabChildren"));
		
		return collection;
	}
	
	static public function exposeFPS(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var intDrag:ExposedIntDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("currentFPS"))
		{
			intDrag = new ExposedIntDrag("currentFPS");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		OpenFLTextData.exposeTextField(collection, groupName);
		
		return collection;
	}
	
	static public function exposeFPSConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) 
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
			collection.useActions = false;
		}
		
		if (!collection.hasValue("x"))
		{
			floatDrag = new ExposedFloatDrag("x");
			floatDrag.defaultValue = 10.0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("y"))
		{
			floatDrag = new ExposedFloatDrag("y");
			floatDrag.defaultValue = 10.0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			color.defaultValue = 0x000000;
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
	
	static public function getInteractiveObjectVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getDisplayObjectVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("doubleClickEnabled"));
		collection.add(ClassValueVisibility.fromPool("focusRect"));
		collection.add(ClassValueVisibility.fromPool("mouseEnabled"));
		collection.add(ClassValueVisibility.fromPool("needsSoftKeyboard"));
		collection.add(ClassValueVisibility.fromPool("tabEnabled"));
		
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
	
	static public function getMovieClipVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getSpriteVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("enabled"));
		
		return collection;
	}
	
	#if desktop
	static public function exposeNativeWindow(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var obj:ExposedObject;
		var select:ExposedSelect;
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("active"))
		{
			bool = new ExposedBool("active");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("bounds"))
		{
			obj = new ExposedObject("bounds");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("closed"))
		{
			bool = new ExposedBool("closed");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("displayState"))
		{
			select = new ExposedSelect("displayState");
			select.isReadOnly = true;
			select.add("MAXIMIZED", NativeWindowDisplayState.MAXIMIZED);
			select.add("MINIMIZED", NativeWindowDisplayState.MINIMIZED);
			select.add("NORMAL", NativeWindowDisplayState.NORMAL);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			floatDrag = new ExposedFloatDrag("height");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("maxSize"))
		{
			obj = new ExposedObject("maxSize");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("maximizable"))
		{
			bool = new ExposedBool("maximizable");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("minSize"))
		{
			obj = new ExposedObject("minSize");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("minimizable"))
		{
			bool = new ExposedBool("minimizable");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("owner"))
		{
			obj = new ExposedObject("owner");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("renderMode"))
		{
			#if flash
			select = new ExposedSelect("renderMode");
			select.isReadOnly = true;
			select.add("AUTO", NativeWindowRenderMode.AUTO);
			select.add("CPU", NativeWindowRenderMode.CPU);
			select.add("DIRECT", NativeWindowRenderMode.DIRECT);
			select.add("GPU", NativeWindowRenderMode.GPU);
			collection.addValue(select, groupName);
			#else
			str = new ExposedString("renderMode");
			str.isReadOnly = true;
			collection.addValue(str, groupName);
			#end
		}
		
		if (!collection.hasValue("resizable"))
		{
			bool = new ExposedBool("resizable");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("stage"))
		{
			obj = new ExposedObject("stage");
			collection.addValue(obj);
		}
		
		if (!collection.hasValue("systemChrome"))
		{
			select = new ExposedSelect("systemChrome");
			select.isReadOnly = true;
			select.add("ALTERNATE", NativeWindowSystemChrome.ALTERNATE);
			select.add("NONE", NativeWindowSystemChrome.NONE);
			select.add("STANDARD", NativeWindowSystemChrome.STANDARD);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("title"))
		{
			str = new ExposedString("title");
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("transparent"))
		{
			bool = new ExposedBool("transparent");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("type"))
		{
			select = new ExposedSelect("type");
			select.isReadOnly = true;
			select.add("LIGHTWEIGHT", NativeWindowType.LIGHTWEIGHT);
			select.add("NORMAL", NativeWindowType.NORMAL);
			select.add("UTILITY", NativeWindowType.UTILITY);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("visible"))
		{
			bool = new ExposedBool("visible");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("width"))
		{
			floatDrag = new ExposedFloatDrag("width");
			collection.addValue(floatDrag, groupName);
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
		
		return collection;
	}
	
	static public function exposeNativeWindowConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var obj:ExposedObject;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("initOptions"))
		{
			obj = new ExposedObject("initOptions");
			obj.autoCreateIfNull = true;
			obj.autoCreationClassName = Type.getClassName(NativeWindowInitOptions);
			collection.addValue(obj, groupName);
		}
		
		return collection;
	}
	#end
	
	#if desktop
	static public function exposeNativeWindowInitOptions(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var objRef:ExposedObjectReference;
		var select:ExposedSelect;
		#if !flash
		var str:ExposedString;
		#end
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("maximizable"))
		{
			bool = new ExposedBool("maximizable");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("minimizable"))
		{
			bool = new ExposedBool("minimizable");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("owner"))
		{
			objRef = new ExposedObjectReference("owner");
			objRef.allowClass(NativeWindow);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("renderMode"))
		{
			#if flash
			select = new ExposedSelect("renderMode");
			select.add("AUTO", NativeWindowRenderMode.AUTO);
			select.add("CPU", NativeWindowRenderMode.CPU);
			select.add("DIRECT", NativeWindowRenderMode.DIRECT);
			select.add("GPU", NativeWindowRenderMode.GPU);
			collection.addValue(select, groupName);
			#else
			str = new ExposedString("renderMode");
			collection.addValue(str, groupName);
			#end
		}
		
		if (!collection.hasValue("resizable"))
		{
			bool = new ExposedBool("resizable");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("systemChrome"))
		{
			select = new ExposedSelect("systemChrome");
			select.add("ALTERNATE", NativeWindowSystemChrome.ALTERNATE);
			select.add("NONE", NativeWindowSystemChrome.NONE);
			select.add("STANDARD", NativeWindowSystemChrome.STANDARD);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("transparent"))
		{
			bool = new ExposedBool("transparent");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("type"))
		{
			select = new ExposedSelect("type");
			select.add("LIGHTWEIGHT", NativeWindowType.LIGHTWEIGHT);
			select.add("NORMAL", NativeWindowType.NORMAL);
			select.add("UTILITY", NativeWindowType.UTILITY);
			collection.addValue(select, groupName);
		}
		
		return collection;
	}
	#end
	
	static public function exposeScreen(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var obj:ExposedObject;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("bounds"))
		{
			obj = new ExposedObject("bounds");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("screenMode"))
		{
			obj = new ExposedObject("screenMode");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("safeArea"))
		{
			obj = new ExposedObject("safeArea");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("visibleBounds"))
		{
			obj = new ExposedObject("visibleBounds");
			collection.addValue(obj, groupName);
		}
		
		return collection;
	}
	
	static public function exposeScreenMode(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var intDrag:ExposedIntDrag;
		
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
		
		if (!collection.hasValue("refreshRate"))
		{
			intDrag = new ExposedIntDrag("refreshRate");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeShape(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObject(collection, groupName);
		
		return collection;
	}
	
	static public function getShapeVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getDisplayObjectVisibility(collection);
		
		return collection;
	}
	
	static public function exposeSimpleButton(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var obj:ExposedObject;
		var objRef:ExposedObjectReference;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeInteractiveObject(collection, groupName);
		
		if (!collection.hasValue("downState"))
		{
			objRef = new ExposedObjectReference("downState");
			objRef.allowClass(DisplayObject);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("enabled"))
		{
			bool = new ExposedBool("enabled");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("hitTestState"))
		{
			objRef = new ExposedObjectReference("hitTestState");
			objRef.allowClass(DisplayObject);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("overState"))
		{
			objRef = new ExposedObjectReference("overState");
			objRef.allowClass(DisplayObject);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("soundTransform"))
		{
			obj = new ExposedObject("soundTransform");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("trackAsMenu"))
		{
			bool = new ExposedBool("trackAsMenu");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("upState"))
		{
			objRef = new ExposedObjectReference("upState");
			objRef.allowClass(DisplayObject);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("useHandCursor"))
		{
			bool = new ExposedBool("useHandCursor");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeSimpleButtonConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var objRef:ExposedObjectReference;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("upState"))
		{
			objRef = new ExposedObjectReference("upState");
			objRef.allowClass(DisplayObject);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("overState"))
		{
			objRef = new ExposedObjectReference("overState");
			objRef.allowClass(DisplayObject);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("downState"))
		{
			objRef = new ExposedObjectReference("downState");
			objRef.allowClass(DisplayObject);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("hitTestState"))
		{
			objRef = new ExposedObjectReference("hitTestState");
			objRef.allowClass(DisplayObject);
			collection.addValue(objRef, groupName);
		}
		
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
	
	static public function getSpriteVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getDisplayObjectContainerVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("buttonMode", true, false));
		collection.add(ClassValueVisibility.fromPool("useHandCursor", true, false));
		
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
	
	static public function exposeStage3D(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var obj:ExposedObject;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("context3D"))
		{
			obj = new ExposedObject("context3D");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("visible"))
		{
			bool = new ExposedBool("visible");
			collection.addValue(bool, groupName);
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
		
		return collection;
	}
	
	static public function exposeTile(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var obj:ExposedObject;
		var objRef:ExposedObjectReference;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, 0.0, 1.0, 0.01);
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
		
		if (!collection.hasValue("colorTransform"))
		{
			obj = new ExposedObject("colorTransform");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			floatDrag = new ExposedFloatDrag("height");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("id"))
		{
			intDrag = new ExposedIntDrag("id", null, 0);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("matrix"))
		{
			obj = new ExposedObject("matrix");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("originX"))
		{
			floatDrag = new ExposedFloatDrag("originX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("originY"))
		{
			floatDrag = new ExposedFloatDrag("originY");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("parent"))
		{
			obj = new ExposedObject("parent");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("rect"))
		{
			obj = new ExposedObject("rect");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("rotation"))
		{
			floatDrag = new ExposedFloatDrag("rotation");
			floatDrag.isAbsolute = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("scaleX"))
		{
			floatDrag = new ExposedFloatDrag("scaleX", null, null, null, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("scaleY"))
		{
			floatDrag = new ExposedFloatDrag("scaleY", null, null, null, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("tileSet"))
		{
			objRef = new ExposedObjectReference("tileSet");
			objRef.allowClass(Tileset);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("visible"))
		{
			bool = new ExposedBool("visible");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("width"))
		{
			floatDrag = new ExposedFloatDrag("width");
			collection.addValue(floatDrag, groupName);
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
		
		return collection;
	}
	
	static public function exposeTileConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("id"))
		{
			intDrag = new ExposedIntDrag("id", null, 0);
			collection.addValue(intDrag, groupName);
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
		
		if (!collection.hasValue("scaleX"))
		{
			floatDrag = new ExposedFloatDrag("scaleX", null, null, null, 0.01);
			floatDrag.defaultValue = 1.0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("scaleY"))
		{
			floatDrag = new ExposedFloatDrag("scaleY", null, null, null, 0.01);
			floatDrag.defaultValue = 1.0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("rotation"))
		{
			floatDrag = new ExposedFloatDrag("rotation");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("originX"))
		{
			floatDrag = new ExposedFloatDrag("originX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("originY"))
		{
			floatDrag = new ExposedFloatDrag("originY");
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTileContainer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var intDrag:ExposedIntDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("numTiles"))
		{
			intDrag = new ExposedIntDrag("numTiles");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		exposeTile(collection, groupName);
		
		return collection;
	}
	
	static public function exposeTileContainerConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
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
		
		if (!collection.hasValue("scaleX"))
		{
			floatDrag = new ExposedFloatDrag("scaleX", null, null, null, 0.01);
			floatDrag.defaultValue = 1.0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("scaleY"))
		{
			floatDrag = new ExposedFloatDrag("scaleY", null, null, null, 0.01);
			floatDrag.defaultValue = 1.0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("rotation"))
		{
			floatDrag = new ExposedFloatDrag("rotation");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("originX"))
		{
			floatDrag = new ExposedFloatDrag("originX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("originY"))
		{
			floatDrag = new ExposedFloatDrag("originY");
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTileMap(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var intDrag:ExposedIntDrag;
		var objRef:ExposedObjectReference;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObject(collection, groupName);
		
		if (!collection.hasValue("numTiles"))
		{
			intDrag = new ExposedIntDrag("numTiles");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("tileAlphaEnabled"))
		{
			bool = new ExposedBool("tileAlphaEnabled");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("tileBlendModeEnabled"))
		{
			bool = new ExposedBool("tileBlendModeEnabled");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("tileColorTransformEnabled"))
		{
			bool = new ExposedBool("tileColorTransformEnabled");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("tileSet"))
		{
			objRef = new ExposedObjectReference("tileSet");
			objRef.allowClass(Tileset);
			collection.addValue(objRef, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTileMapConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var intDrag:ExposedIntDrag;
		var objRef:ExposedObjectReference;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("width"))
		{
			intDrag = new ExposedIntDrag("width");
			intDrag.isMandatory = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			intDrag = new ExposedIntDrag("height");
			intDrag.isMandatory = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("tileSet"))
		{
			objRef = new ExposedObjectReference("tileSet");
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("smoothing"))
		{
			bool = new ExposedBool("smoothing");
			bool.defaultValue = true;
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTileSet(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bmd:ExposedBitmapData;
		var intDrag:ExposedIntDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("bitmapData"))
		{
			bmd = new ExposedBitmapData("bitmapData");
			collection.addValue(bmd, groupName);
		}
		
		if (!collection.hasValue("numRects"))
		{
			intDrag = new ExposedIntDrag("numRects");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTileSetConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bmd:ExposedBitmapData;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("bitmapData"))
		{
			bmd = new ExposedBitmapData("bitmapData");
			bmd.isMandatory = true;
			collection.addValue(bmd, groupName);
		}
		
		return collection;
	}
	
}