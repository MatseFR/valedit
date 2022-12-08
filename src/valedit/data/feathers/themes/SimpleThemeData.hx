package valedit.data.feathers.themes;
import openfl.text.Font;
import openfl.text.TextFormatAlign;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedColorReadOnly;
import valedit.value.ExposedFloatRange;
import valedit.value.ExposedGroup;
import valedit.value.ExposedInt;
import valedit.value.ExposedIntRange;
import valedit.value.ExposedSelect;
import valedit.value.ExposedSeparator;
import valedit.value.ExposedSpacing;
import valedit.value.NumericMode;

/**
 * ...
 * @author Matse
 */
class SimpleThemeData 
{
	static public function exposeBiColorSettings(collection:ExposedCollection = null):ExposedCollection
	{
		var color:ExposedColor;
		var floatRange:ExposedFloatRange;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("alpha"))
		{
			floatRange = new ExposedFloatRange("alpha", null, 0, 1, 0.05, 2, 80, 20);
			collection.addValue(floatRange);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color);
		}
		
		if (!collection.hasValue("alpha2"))
		{
			floatRange = new ExposedFloatRange("alpha2", null, 0, 1, 0.05, 2, 80, 20);
			collection.addValue(floatRange);
		}
		
		if (!collection.hasValue("color2"))
		{
			color = new ExposedColor("color2");
			collection.addValue(color);
		}
		
		if (!collection.hasValue("borderAlpha"))
		{
			floatRange = new ExposedFloatRange("borderAlpha", null, 0, 1, 0.05, 2, 80, 20);
			collection.addValue(floatRange);
		}
		
		if (!collection.hasValue("borderColor"))
		{
			color = new ExposedColor("borderColor");
			collection.addValue(color);
		}
		
		if (!collection.hasValue("borderAlpha2"))
		{
			floatRange = new ExposedFloatRange("borderAlpha2", null, 0, 1, 0.05, 2, 80, 20);
			collection.addValue(floatRange);
		}
		
		if (!collection.hasValue("borderColor2"))
		{
			color = new ExposedColor("borderColor2");
			collection.addValue(color);
		}
		
		return collection;
	}
	
	static public function exposeColorSettings(collection:ExposedCollection = null):ExposedCollection
	{
		var color:ExposedColor;
		var floatRange:ExposedFloatRange;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("alpha"))
		{
			floatRange = new ExposedFloatRange("alpha", null, 0, 1, 0.05, 2, 80, 20);
			collection.addValue(floatRange);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color);
		}
		
		if (!collection.hasValue("borderAlpha"))
		{
			floatRange = new ExposedFloatRange("borderAlpha", null, 0, 1, 0.05, 2, 80, 20);
			collection.addValue(floatRange);
		}
		
		if (!collection.hasValue("borderColor"))
		{
			color = new ExposedColor("borderColor");
			collection.addValue(color);
		}
		
		return collection;
	}
	
	static public function exposeControlSettings(collection:ExposedCollection = null):ExposedCollection
	{
		var 
	}
	
	static public function exposeTextSettings(collection:ExposedCollection = null):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var intRange:ExposedIntRange;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("fontName"))
		{
			select = new ExposedSelect("fontName");
			var fonts:Array<Font> = Font.enumerateFonts(true);
			for (font in fonts)
			{
				select.add(font.fontName);
			}
			collection.addValue(select);
		}
		
		if (!collection.hasValue("fontSize"))
		{
			intRange = new ExposedIntRange("fontSize", null, 6, 42, 1, 80, 20);
			collection.addValue(intRange);
		}
		
		if (!collection.hasValue("alignDefault"))
		{
			select = new ExposedSelect("alignDefault");
			select.add("CENTER", TextFormatAlign.CENTER);
			select.add("JUSTIFY", TextFormatAlign.JUSTIFY);
			select.add("LEFT", TextFormatAlign.LEFT);
			select.add("RIGHT", TextFormatAlign.RIGHT);
			collection.addValue(select);
		}
		
		if (!collection.hasValue("bold"))
		{
			bool = new ExposedBool("bold");
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("italic"))
		{
			bool = new ExposedBool("italic");
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("underline"))
		{
			bool = new ExposedBool("underline");
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color);
		}
		
		return collection;
	}

	static public function exposeFlatColorTheme(collection:ExposedCollection = null):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var colorRead:ExposedColorReadOnly;
		var floatRange:ExposedFloatRange;
		var int:ExposedInt;
		var intRange:ExposedIntRange;
		var select:ExposedSelect;
		var group:ExposedGroup;
		var subGroup:ExposedGroup;
		var spacing:ExposedSpacing;
		var sep:ExposedSeparator;
		
		if (collection == null) collection = new ExposedCollection();
		
		group = new ExposedGroup("Flat Color Theme properties");
		collection.addValue(group);
		
		// common properties
		if (!collection.hasValue("darkMode"))
		{
			bool = new ExposedBool("darkMode");
			group.addValue(bool);
		}
		
		if (!collection.hasValue("fontName"))
		{
			select = new ExposedSelect("fontName");
			var fonts:Array<Font> = Font.enumerateFonts(true);
			for (font in fonts)
			{
				select.add(font.fontName);
			}
			group.addValue(select);
		}
		
		if (!collection.hasValue("fontSize"))
		{
			intRange = new ExposedIntRange("fontSize", null, 6, 42, 1, 80, 20);
			group.addValue(intRange);
		}
		
		if (!collection.hasValue("fontSizeBig"))
		{
			intRange = new ExposedIntRange("fontSizeBig", null, 6, 42, 1, 80, 20);
			group.addValue(intRange);
		}
		
		if (!collection.hasValue("fontSizeSmall"))
		{
			intRange = new ExposedIntRange("fontSizeSmall", null, 6, 42, 1, 80, 20);
			group.addValue(intRange);
		}
		
		if (!collection.hasValue("lineThickness"))
		{
			floatRange = new ExposedFloatRange("lineThickness", null, 0, 12, 1, 2, 80, 20);
			group.addValue(floatRange);
		}
		
		// light mode properties
		subGroup = collection.getGroup("light mode");
		if (subGroup == null)
		{
			subGroup = new ExposedGroup("light mode", true, true);
			group.addValue(subGroup);
		}
		
		if (!subGroup.hasValue("color"))
		{
			color = new ExposedColor("lightThemeColor", "color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("lightThemeColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("lightThemeColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			//spacing = new ExposedSpacing();
			//subGroup.addValue(spacing);
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("light color"))
		{
			color = new ExposedColor("lightThemeLightColor", "light color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("lightThemeLightColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("lightThemeLightColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			//spacing = new ExposedSpacing();
			//subGroup.addValue(spacing);
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("contrast color"))
		{
			color = new ExposedColor("lightThemeContrastColor", "contrast color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("lightThemeContrastColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("lightThemeContrastColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			//spacing = new ExposedSpacing();
			//subGroup.addValue(spacing);
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("danger color"))
		{
			color = new ExposedColor("lightThemeDangerColor", "danger color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("lightThemeDangerColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("lightThemeDangerColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			//spacing = new ExposedSpacing();
			//subGroup.addValue(spacing);
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("focus color"))
		{
			color = new ExposedColor("lightThemeFocusColor", "focus color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("lightThemeFocusColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("lightThemeFocusColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
		}
		
		// dark mode properties
		subGroup = collection.getGroup("dark mode");
		if (subGroup == null)
		{
			subGroup = new ExposedGroup("dark mode", true, true);
			group.addValue(subGroup);
		}
		
		if (!subGroup.hasValue("color"))
		{
			color = new ExposedColor("darkThemeColor", "color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("darkThemeColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("darkThemeColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			spacing = new ExposedSpacing();
			subGroup.addValue(spacing);
		}
		
		if (!subGroup.hasValue("light color"))
		{
			color = new ExposedColor("darkThemeLightColor", "light color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("darkThemeLightColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("darkThemeLightColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			spacing = new ExposedSpacing();
			subGroup.addValue(spacing);
		}
		
		if (!subGroup.hasValue("contrast color"))
		{
			color = new ExposedColor("darkThemeContrastColor", "contrast color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("darkThemeContrastColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("darkThemeContrastColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			spacing = new ExposedSpacing();
			subGroup.addValue(spacing);
		}
		
		if (!subGroup.hasValue("danger color"))
		{
			color = new ExposedColor("darkThemeDangerColor", "danger color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("darkThemeDangerColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("darkThemeDangerColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			spacing = new ExposedSpacing();
			subGroup.addValue(spacing);
		}
		
		if (!subGroup.hasValue("focus color"))
		{
			color = new ExposedColor("darkThemeFocusColor", "focus color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("darkThemeFocusColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("darkThemeFocusColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2, 80, 20);
			subGroup.addValue(floatRange);
		}
		
		return collection;
	}
	
}