package valedit.data.massive.text;
import massive.text.MassiveFont;
import massive.text.MassiveText;
import massive.text.TextAlign;
import starling.text.TextFieldAutoSize;
import valedit.ExposedCollection;
import valedit.data.massive.display.MassiveDisplayData;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObject;
import valedit.value.ExposedSelect;
import valedit.value.ExposedText;
import valedit.value.base.ExposedValue;
import valeditor.utils.ArraySort;

/**
 * ...
 * @author Matse
 */
class MassiveTextData 
{

	public static function exposeText(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var intDrag:ExposedIntDrag;
		var obj:ExposedObject;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("numChars"))
		{
			intDrag = new ExposedIntDrag("numChars");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("numParts"))
		{
			intDrag = new ExposedIntDrag("numParts");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("format"))
		{
			obj = new ExposedObject("format");
			obj.isReadOnly = true;
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("options"))
		{
			obj = new ExposedObject("options");
			obj.isReadOnly = true;
			collection.addValue(obj, groupName);
		}
		
		return collection;
	}
	
	public static function exposeTextField(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var obj:ExposedObject;
		var text:ExposedText;
		
		if (collection == null) collection = new ExposedCollection();
		
		MassiveDisplayData.exposeContainerBase(collection, groupName);
		
		if (!collection.hasValue("width"))
		{
			floatDrag = new ExposedFloatDrag("width", null, 0.0);
			collection.addValueAfter(floatDrag, "y", groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			floatDrag = new ExposedFloatDrag("height", null, 0.0);
			collection.addValueAfter(floatDrag, "width", groupName);
		}
		
		if (!collection.hasValue("format"))
		{
			obj = new ExposedObject("format");
			collection.addValueAfter(obj, "height", groupName);
		}
		
		if (!collection.hasValue("options"))
		{
			obj = new ExposedObject("options");
			collection.addValueAfter(obj, "format", groupName);
		}
		
		if (!collection.hasValue("text"))
		{
			text = new ExposedText("text");
			collection.addValueAfter(text, "options", groupName);
		}
		
		if (!collection.hasValue("textData"))
		{
			text = new ExposedText("textData");
			collection.addValueAfter(text, "text", groupName);
		}
		
		if (!collection.hasValue("textDataSafeMode"))
		{
			bool = new ExposedBool("textDataSafeMode");
			bool.isReadOnly = true;
			collection.addValueAfter(bool, "textData", groupName);
		}
		
		return collection;
	}
	
	public static function exposeTextFormat(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("font"))
		{
			select = new ExposedSelect("font");
			select.choiceListFunction = getFontNames;
			select.valueListFunction = getFontNames;
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("style"))
		{
			select = new ExposedSelect("style");
			select.choiceListFunction = getFontStyles;
			select.choiceListFunctionUseCollectionAsParameter = true;
			select.valueListFunction = getFontStyles;
			select.valueListFunctionUseCollectionAsParameter = true;
			select.addChoicesAndValuesUpdatePropertyName("font");
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("size"))
		{
			floatDrag = new ExposedFloatDrag("size", null, 0.0, null);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, 0.0, 1.0, 0.05, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			color.showRGBControls = false;
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("red"))
		{
			floatDrag = new ExposedFloatDrag("red", null, -10.0, 10.0, 0.01, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("green"))
		{
			floatDrag = new ExposedFloatDrag("green", null, -10.0, 10.0, 0.01, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blue"))
		{
			floatDrag = new ExposedFloatDrag("blue", null, -10.0, 10.0, 0.01, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alphaOffset"))
		{
			floatDrag = new ExposedFloatDrag("alphaOffset", null, -10.0, 10.0, 0.05, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("colorOffset"))
		{
			color = new ExposedColor("colorOffset");
			color.showRGBControls = false;
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("redOffset"))
		{
			floatDrag = new ExposedFloatDrag("redOffset", null, -10.0, 10.0, 0.01, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("greenOffset"))
		{
			floatDrag = new ExposedFloatDrag("greenOffset", null, -10.0, 10.0, 0.01, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blueOffset"))
		{
			floatDrag = new ExposedFloatDrag("blueOffset", null, -10.0, 10.0, 0.01, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("kerning"))
		{
			bool = new ExposedBool("kerning");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("letterSpacing"))
		{
			floatDrag = new ExposedFloatDrag("letterSpacing");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("restrictImgHeightToFontSize"))
		{
			bool = new ExposedBool("restrictImgHeightToFontSize");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("restrictImgHeightOverflow"))
		{
			floatDrag = new ExposedFloatDrag("restrictImgHeightOverflow");
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	private static function getFontNames():Array<String>
	{
		var fontNames:Array<String> = MassiveText.getFontNames();
		fontNames.sort(ArraySort.alphabetical);
		return fontNames;
	}
	
	private static function getFontStyles(collection:ExposedCollection):Array<String>
	{
		var fontValue:ExposedValue = collection.getValue("font");
		if (fontValue.value == null)
		{
			return [];
		}
		else
		{
			var font:MassiveFont = MassiveText.getFont(fontValue.value);
			var styleNames:Array<String> = font.getFontStyleNames();
			styleNames.sort(ArraySort.alphabetical);
			return styleNames;
		}
	}
	
	public static function exposeTextOptions(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("horizontalAlign"))
		{
			select = new ExposedSelect("horizontalAlign");
			for (align in TextAlign.horizontalValues)
			{
				select.add(align, align);
			}
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("verticalAlign"))
		{
			select = new ExposedSelect("verticalAlign");
			for (align in TextAlign.verticalValues)
			{
				select.add(align, align);
			}
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("autoSize"))
		{
			select = new ExposedSelect("autoSize");
			select.add(TextFieldAutoSize.BOTH_DIRECTIONS);
			select.add(TextFieldAutoSize.HORIZONTAL);
			select.add(TextFieldAutoSize.NONE);
			select.add(TextFieldAutoSize.VERTICAL);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("wordWrap"))
		{
			bool = new ExposedBool("wordWrap");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("leading"))
		{
			floatDrag = new ExposedFloatDrag("leading");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("uniformLineHeight"))
		{
			bool = new ExposedBool("uniformLineHeight");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("intPositions"))
		{
			bool = new ExposedBool("intPositions");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("hyphenation"))
		{
			bool = new ExposedBool("hyphenation");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("hyphenationMinLength"))
		{
			intDrag = new ExposedIntDrag("hyphenationMinLength", null, 0);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("hyphenationSpaceRatio"))
		{
			floatDrag = new ExposedFloatDrag("hyphenationSpaceRatio", null, 1.0, null, 0.1, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("charSpreading"))
		{
			bool = new ExposedBool("charSpreading");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("charSpreadingAllowIrregular"))
		{
			bool = new ExposedBool("charSpreadingAllowIrregular");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("charSpreadingMax"))
		{
			floatDrag = new ExposedFloatDrag("charSpreadingMax", null, 0.0);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("charSpreadingSpaceRatio"))
		{
			floatDrag = new ExposedFloatDrag("charSpreadingSpaceRatio", null, 1.0, null, 0.1, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("padding"))
		{
			floatDrag = new ExposedFloatDrag("padding");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("paddingLeft"))
		{
			floatDrag = new ExposedFloatDrag("paddingLeft");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("paddingRight"))
		{
			floatDrag = new ExposedFloatDrag("paddingRight");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("paddingTop"))
		{
			floatDrag = new ExposedFloatDrag("paddingTop");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("paddingBottom"))
		{
			floatDrag = new ExposedFloatDrag("paddingBottom");
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	public static function exposeTextPart(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		return collection;
	}
	
}