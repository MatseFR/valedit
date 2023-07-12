package valedit.data.feathers.themes;
import openfl.text.Font;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedGroup;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedSelect;
import valedit.value.ExposedSeparator;

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
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var select:ExposedSelect;
		var subGroup:ExposedGroup;
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
				trace(font);
				select.add(font.fontName);
			}
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("fontSize"))
		{
			intDrag = new ExposedIntDrag("fontSize", null, 6, null, 0.5, 1, false);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("fontSizeBig"))
		{
			intDrag = new ExposedIntDrag("fontSizeBig", null, 6, null, 0.5, 1, false);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("fontSizeSmall"))
		{
			intDrag = new ExposedIntDrag("fontSizeSmall", null, 6, null, 0.5, 1, false);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("lineThickness"))
		{
			floatDrag = new ExposedFloatDrag("lineThickness", null, 0, 12, 0.5, 0.5, false);
			collection.addValue(floatDrag, groupName);
		}
		
		// light mode properties
		subGroup = collection.getGroup("light mode");
		if (subGroup == null)
		{
			subGroup = new ExposedGroup("light mode", true, true);
			collection.addValue(subGroup, groupName);
		}
		
		if (!subGroup.hasValue("lightThemeColor"))
		{
			color = new ExposedColor("lightThemeColor", "color");
			subGroup.addValue(color);
			
			floatDrag = new ExposedFloatDrag("lightThemeColorDarkenRatio", "darken ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			floatDrag = new ExposedFloatDrag("lightThemeColorLightenRatio", "lighten ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("lightThemeAlternColor"))
		{
			color = new ExposedColor("lightThemeAlternColor", "altern color");
			subGroup.addValue(color);
			
			floatDrag = new ExposedFloatDrag("lightThemeAlternColorDarkenRatio", "darken ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			floatDrag = new ExposedFloatDrag("lightThemeAlternColorLightenRatio", "lighten ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("lightThemeLightColor"))
		{
			color = new ExposedColor("lightThemeLightColor", "light color");
			subGroup.addValue(color);
			
			floatDrag = new ExposedFloatDrag("lightThemeLightColorDarkenRatio", "darken ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			floatDrag = new ExposedFloatDrag("lightThemeLightColorLightenRatio", "lighten ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("lightThemeContrastColor"))
		{
			color = new ExposedColor("lightThemeContrastColor", "contrast color");
			subGroup.addValue(color);
			
			floatDrag = new ExposedFloatDrag("lightThemeContrastColorDarkenRatio", "darken ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			floatDrag = new ExposedFloatDrag("lightThemeContrastColorLightenRatio", "lighten ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("lightThemeDangerColor"))
		{
			color = new ExposedColor("lightThemeDangerColor", "danger color");
			subGroup.addValue(color);
			
			floatDrag = new ExposedFloatDrag("lightThemeDangerColorDarkenRatio", "darken ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			floatDrag = new ExposedFloatDrag("lightThemeDangerColorLightenRatio", "lighten ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("lightThemeFocusColor"))
		{
			color = new ExposedColor("lightThemeFocusColor", "focus color");
			subGroup.addValue(color);
			
			//floatDrag = new ExposedFloatDrag("lightThemeFocusColorDarkenRatio", "darken ratio", 0, 1, 0.005, 0.001);
			//subGroup.addValue(floatDrag);
			
			//floatDrag = new ExposedFloatDrag("lightThemeFocusColorLightenRatio", "lighten ratio", 0, 1, 0.005, 0.001);
			//subGroup.addValue(floatDrag);
		}
		
		// dark mode properties
		subGroup = collection.getGroup("dark mode");
		if (subGroup == null)
		{
			subGroup = new ExposedGroup("dark mode", true, true);
			collection.addValue(subGroup, groupName);
		}
		
		if (!subGroup.hasValue("darkThemeColor"))
		{
			color = new ExposedColor("darkThemeColor", "color");
			subGroup.addValue(color);
			
			floatDrag = new ExposedFloatDrag("darkThemeColorDarkenRatio", "darken ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			floatDrag = new ExposedFloatDrag("darkThemeColorLightenRatio", "lighten ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("darkThemeAlternColor"))
		{
			color = new ExposedColor("darkThemeAlternColor", "altern color");
			subGroup.addValue(color);
			
			floatDrag = new ExposedFloatDrag("darkThemeAlternColorDarkenRatio", "darken ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			floatDrag = new ExposedFloatDrag("darkThemeAlternColorLightenRatio", "lighten ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("darkThemeLightColor"))
		{
			color = new ExposedColor("darkThemeLightColor", "light color");
			subGroup.addValue(color);
			
			floatDrag = new ExposedFloatDrag("darkThemeLightColorDarkenRatio", "darken ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			floatDrag = new ExposedFloatDrag("darkThemeLightColorLightenRatio", "lighten ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("darkThemeContrastColor"))
		{
			color = new ExposedColor("darkThemeContrastColor", "contrast color");
			subGroup.addValue(color);
			
			floatDrag = new ExposedFloatDrag("darkThemeContrastColorDarkenRatio", "darken ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			floatDrag = new ExposedFloatDrag("darkThemeContrastColorLightenRatio", "lighten ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("darkThemeDangerColor"))
		{
			color = new ExposedColor("darkThemeDangerColor", "danger color");
			subGroup.addValue(color);
			
			floatDrag = new ExposedFloatDrag("darkThemeDangerColorDarkenRatio", "darken ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			floatDrag = new ExposedFloatDrag("darkThemeDangerColorLightenRatio", "lighten ratio", 0, 1, 0.005, 0.001);
			subGroup.addValue(floatDrag);
			
			sep = new ExposedSeparator();
			subGroup.addValue(sep);
		}
		
		if (!subGroup.hasValue("darkThemeFocusColor"))
		{
			color = new ExposedColor("darkThemeFocusColor", "focus color");
			subGroup.addValue(color);
			
			//floatDrag = new ExposedFloatDrag("darkThemeFocusColorDarkenRatio", "darken ratio", 0, 1, 0.005, 0.001);
			//subGroup.addValue(floatDrag);
			
			//floatDrag = new ExposedFloatDrag("darkThemeFocusColorLightenRatio", "lighten ratio", 0, 1, 0.005, 0.001);
			//subGroup.addValue(floatDrag);
		}
		
		return collection;
	}
	
}