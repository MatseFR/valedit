package valedit.data.feathers.themes;
import openfl.text.Font;
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

/**
 * ...
 * @author Matse
 */
class SimpleThemeData 
{
	static public function exposeSimpleTheme(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var colorRead:ExposedColorReadOnly;
		var floatRange:ExposedFloatRange;
		var int:ExposedInt;
		var intRange:ExposedIntRange;
		var select:ExposedSelect;
		var subGroup:ExposedGroup;
		var spacing:ExposedSpacing;
		var sep:ExposedSeparator;
		
		if (collection == null) collection = new ExposedCollection();
		
		// common properties
		if (!collection.hasValue("darkMode"))
		{
			bool = new ExposedBool("darkMode");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("fontName"))
		{
			select = new ExposedSelect("fontName");
			var fonts:Array<Font> = Font.enumerateFonts(true);
			for (font in fonts)
			{
				// TODO : this throws an error on neko target
				select.add(font.fontName);
			}
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("fontSize"))
		{
			intRange = new ExposedIntRange("fontSize", null, 6, 42, 1);
			collection.addValue(intRange, groupName);
		}
		
		if (!collection.hasValue("fontSizeBig"))
		{
			intRange = new ExposedIntRange("fontSizeBig", null, 6, 42, 1);
			collection.addValue(intRange, groupName);
		}
		
		if (!collection.hasValue("fontSizeSmall"))
		{
			intRange = new ExposedIntRange("fontSizeSmall", null, 6, 42, 1);
			collection.addValue(intRange, groupName);
		}
		
		if (!collection.hasValue("lineThickness"))
		{
			floatRange = new ExposedFloatRange("lineThickness", null, 0, 12, 1, 2);
			collection.addValue(floatRange, groupName);
		}
		
		// light mode properties
		subGroup = collection.getGroup("light mode");
		if (subGroup == null)
		{
			subGroup = new ExposedGroup("light mode", true, true);
			collection.addValue(subGroup, groupName);
		}
		
		if (!subGroup.hasValue("color"))
		{
			color = new ExposedColor("lightThemeColor", "color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("lightThemeColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("lightThemeColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
			
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("light color"))
		{
			color = new ExposedColor("lightThemeLightColor", "light color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("lightThemeLightColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("lightThemeLightColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
			
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("contrast color"))
		{
			color = new ExposedColor("lightThemeContrastColor", "contrast color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("lightThemeContrastColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("lightThemeContrastColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
			
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("danger color"))
		{
			color = new ExposedColor("lightThemeDangerColor", "danger color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("lightThemeDangerColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("lightThemeDangerColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
			
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("focus color"))
		{
			color = new ExposedColor("lightThemeFocusColor", "focus color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("lightThemeFocusColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("lightThemeFocusColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
		}
		
		// dark mode properties
		subGroup = collection.getGroup("dark mode");
		if (subGroup == null)
		{
			subGroup = new ExposedGroup("dark mode", true, true);
			collection.addValue(subGroup, groupName);
		}
		
		if (!subGroup.hasValue("color"))
		{
			color = new ExposedColor("darkThemeColor", "color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("darkThemeColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("darkThemeColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
			
			spacing = new ExposedSpacing();
			subGroup.addValue(spacing);
		}
		
		if (!subGroup.hasValue("light color"))
		{
			color = new ExposedColor("darkThemeLightColor", "light color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("darkThemeLightColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("darkThemeLightColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
			
			spacing = new ExposedSpacing();
			subGroup.addValue(spacing);
		}
		
		if (!subGroup.hasValue("contrast color"))
		{
			color = new ExposedColor("darkThemeContrastColor", "contrast color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("darkThemeContrastColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("darkThemeContrastColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
			
			spacing = new ExposedSpacing();
			subGroup.addValue(spacing);
		}
		
		if (!subGroup.hasValue("danger color"))
		{
			color = new ExposedColor("darkThemeDangerColor", "danger color");
			subGroup.addValue(color);
			
			floatRange = new ExposedFloatRange("darkThemeDangerColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
			
			floatRange = new ExposedFloatRange("darkThemeDangerColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2);
			subGroup.addValue(floatRange);
			
			spacing = new ExposedSpacing();
			subGroup.addValue(spacing);
		}
		
		if (!subGroup.hasValue("focus color"))
		{
			color = new ExposedColor("darkThemeFocusColor", "focus color");
			subGroup.addValue(color);
			
			//floatRange = new ExposedFloatRange("darkThemeFocusColorDarkenRatio", "darken ratio", 0, 1, 0.01, 2);
			//subGroup.addValue(floatRange);
			
			//floatRange = new ExposedFloatRange("darkThemeFocusColorLightenRatio", "lighten ratio", 0, 1, 0.01, 2);
			//subGroup.addValue(floatRange);
		}
		
		return collection;
	}
	
}