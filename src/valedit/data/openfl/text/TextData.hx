package valedit.data.openfl.text;
import openfl.text.AntiAliasType;
import openfl.text.FontStyle;
import openfl.text.FontType;
import openfl.text.GridFitType;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFieldType;
import openfl.text.TextFormatAlign;
import valedit.ExposedCollection;
import valedit.data.openfl.display.DisplayData;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloat;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedFloatRange;
import valedit.value.ExposedFontName;
import valedit.value.ExposedInt;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedSelect;
import valedit.value.ExposedString;
import valedit.value.ExposedText;
import valedit.value.NumericMode;

/**
 * ...
 * @author Matse
 */
class TextData 
{
	static public function exposeFont(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var select:ExposedSelect;
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("fontName"))
		{
			str = new ExposedString("fontName");
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("fontStyle"))
		{
			select = new ExposedSelect("fontStyle");
			select.add("bold", FontStyle.BOLD);
			select.add("bold italic", FontStyle.BOLD_ITALIC);
			select.add("italic", FontStyle.ITALIC);
			select.add("regular", FontStyle.REGULAR);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("fontType"))
		{
			select = new ExposedSelect("fontType");
			select.add("device", FontType.DEVICE);
			select.add("embedded", FontType.EMBEDDED);
			select.add("embedded CFF", FontType.EMBEDDED_CFF);
			collection.addValue(select, groupName);
		}
		
		return collection;
	}
	
	static public function exposeFontConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var str:ExposedString;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("name"))
		{
			str = new ExposedString("name");
			collection.addValue(str, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTextField(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var select:ExposedSelect;
		var str:ExposedString;
		var text:ExposedText;
		
		if (collection == null) collection = new ExposedCollection();
		
		DisplayData.exposeInteractiveObject(collection, groupName);
		
		if (!collection.hasValue("alwaysShowSelection"))
		{
			bool = new ExposedBool("alwaysShowSelection");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("antiAliasType"))
		{
			select = new ExposedSelect("antiAliasType");
			select.add("advanced", AntiAliasType.ADVANCED);
			select.add("normal", AntiAliasType.NORMAL);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("autoSize"))
		{
			select = new ExposedSelect("autoSize");
			select.add("center", TextFieldAutoSize.CENTER);
			select.add("left", TextFieldAutoSize.LEFT);
			select.add("none", TextFieldAutoSize.NONE);
			select.add("right", TextFieldAutoSize.RIGHT);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("background"))
		{
			bool = new ExposedBool("background");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("backgroundColor"))
		{
			color = new ExposedColor("backgroundColor");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("border"))
		{
			bool = new ExposedBool("border");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("borderColor"))
		{
			color = new ExposedColor("borderColor");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("condenseWhite"))
		{
			bool = new ExposedBool("condenseWhite");
			collection.addValue(bool, groupName);
		}
		
		// TODO : TextFormat
		
		if (!collection.hasValue("displayAsPassword"))
		{
			bool = new ExposedBool("displayAsPassword");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("embedFonts"))
		{
			bool = new ExposedBool("embedFonts");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("gridFitType"))
		{
			select = new ExposedSelect("gridFitType");
			select.add("none", GridFitType.NONE);
			select.add("pixel", GridFitType.PIXEL);
			select.add("subpixel", GridFitType.SUBPIXEL);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("htmlText"))
		{
			text = new ExposedText("htmlText");
			collection.addValue(text, groupName);
		}
		
		if (!collection.hasValue("maxChars"))
		{
			intDrag = new ExposedIntDrag("maxChars", null, 0);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("mouseWheelEnabled"))
		{
			bool = new ExposedBool("mouseWheelEnabled");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("multiline"))
		{
			bool = new ExposedBool("multiline");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("restrict"))
		{
			str = new ExposedString("restrict");
			str.isNullable = true;
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("scrollH"))
		{
			intDrag = new ExposedIntDrag("scrollH", null, 0);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("scrollV"))
		{
			intDrag = new ExposedIntDrag("scrollV", null, 0);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("selectable"))
		{
			bool = new ExposedBool("selectable");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("sharpness"))
		{
			floatDrag = new ExposedFloatDrag("sharpness", null, -400, 400);
			collection.addValue(floatDrag, groupName);
		}
		
		// TODO : StyleSheet
		
		if (!collection.hasValue("text"))
		{
			text = new ExposedText("text");
			collection.addValue(text, groupName);
		}
		
		if (!collection.hasValue("textColor"))
		{
			color = new ExposedColor("textColor");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("type"))
		{
			select = new ExposedSelect("type");
			select.add("dynamic", TextFieldType.DYNAMIC);
			select.add("input", TextFieldType.INPUT);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("wordWrap"))
		{
			bool = new ExposedBool("wordWrap");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTextFormat(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var font:ExposedFontName;
		var intDrag:ExposedIntDrag;
		var select:ExposedSelect;
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("font"))
		{
			font = new ExposedFontName("font");
			font.isNullable = true;
			collection.addValue(font, groupName);
		}
		
		if (!collection.hasValue("size"))
		{
			intDrag = new ExposedIntDrag("size", null, 0);
			intDrag.isNullable = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			color.isNullable = true;
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("align"))
		{
			select = new ExposedSelect("align");
			select.add("center", TextFormatAlign.CENTER);
			select.add("end", TextFormatAlign.END);
			select.add("justify", TextFormatAlign.JUSTIFY);
			select.add("left", TextFormatAlign.LEFT);
			select.add("right", TextFormatAlign.RIGHT);
			select.add("start", TextFormatAlign.START);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("bold"))
		{
			bool = new ExposedBool("bold");
			bool.isNullable = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("italic"))
		{
			bool = new ExposedBool("italic");
			bool.isNullable = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("underline"))
		{
			bool = new ExposedBool("underline");
			bool.isNullable = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("leftMargin"))
		{
			intDrag = new ExposedIntDrag("leftMargin");
			intDrag.isNullable = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("rightMargin"))
		{
			intDrag = new ExposedIntDrag("rightMargin");
			intDrag.isNullable = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("leading"))
		{
			intDrag = new ExposedIntDrag("leading");
			intDrag.isNullable = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("indent"))
		{
			intDrag = new ExposedIntDrag("indent");
			intDrag.isNullable = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("blockIndent"))
		{
			intDrag = new ExposedIntDrag("blockIndent");
			intDrag.isNullable = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("bullet"))
		{
			bool = new ExposedBool("bullet");
			bool.isNullable = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("kerning"))
		{
			bool = new ExposedBool("kerning");
			bool.isNullable = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("letterSpacing"))
		{
			floatDrag = new ExposedFloatDrag("letterSpacing");
			floatDrag.isNullable = true;
			collection.addValue(floatDrag, groupName);
		}
		
		// TODO : tabStops
		
		if (!collection.hasValue("target"))
		{
			str = new ExposedString("target");
			str.isNullable = true;
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("url"))
		{
			str = new ExposedString("url");
			str.isNullable = true;
			collection.addValue(str, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTextFormatConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var font:ExposedFontName;
		var intDrag:ExposedIntDrag;
		var select:ExposedSelect;
		var str:ExposedString;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("font"))
		{
			font = new ExposedFontName("font");
			font.isNullable = true;
			font.defaultValue = null;
			collection.addValue(font, groupName);
		}
		
		if (!collection.hasValue("size"))
		{
			intDrag = new ExposedIntDrag("size", null, 0);
			intDrag.isNullable = true;
			intDrag.defaultValue = null;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			color.isNullable = true;
			color.defaultValue = null;
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("bold"))
		{
			bool = new ExposedBool("bold");
			bool.isNullable = true;
			bool.defaultValue = null;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("italic"))
		{
			bool = new ExposedBool("italic");
			bool.isNullable = true;
			bool.defaultValue = null;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("underline"))
		{
			bool = new ExposedBool("underline");
			bool.isNullable = true;
			bool.defaultValue = null;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("url"))
		{
			str = new ExposedString("url");
			str.isNullable = true;
			str.defaultValue = null;
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("target"))
		{
			str = new ExposedString("target");
			str.isNullable = true;
			str.defaultValue = null;
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("align"))
		{
			select = new ExposedSelect("align");
			select.add("center", TextFormatAlign.CENTER);
			select.add("end", TextFormatAlign.END);
			select.add("justify", TextFormatAlign.JUSTIFY);
			select.add("left", TextFormatAlign.LEFT);
			select.add("right", TextFormatAlign.RIGHT);
			select.add("start", TextFormatAlign.START);
			select.isNullable = true;
			select.defaultValue = null;
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("leftMargin"))
		{
			intDrag = new ExposedIntDrag("leftMargin");
			intDrag.isNullable = true;
			intDrag.defaultValue = null;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("rightMargin"))
		{
			intDrag = new ExposedIntDrag("rightMargin");
			intDrag.isNullable = true;
			intDrag.defaultValue = null;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("indent"))
		{
			intDrag = new ExposedIntDrag("indent");
			intDrag.isNullable = true;
			intDrag.defaultValue = null;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("leading"))
		{
			intDrag = new ExposedIntDrag("leading");
			intDrag.isNullable = true;
			intDrag.defaultValue = null;
			collection.addValue(intDrag, groupName);
		}
		
		return collection;
	}
	
}