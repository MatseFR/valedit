package valedit.data.starling.text;
import flash.display3D.Context3DTextureFormat;
import openfl.text.StyleSheet;
import starling.styles.MeshStyle;
import starling.text.TextFieldAutoSize;
import starling.text.TextFormat;
import starling.text.TextOptions;
import starling.utils.Align;
import valedit.ExposedCollection;
import valedit.data.starling.display.StarlingDisplayData;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedFontName;
import valedit.value.ExposedFunction;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObjectReference;
import valedit.value.ExposedSelect;
import valedit.value.ExposedText;

/**
 * ...
 * @author Matse
 */
@:access(valedit.data.starling.display.StarlingDisplayData)
class StarlingTextData 
{

	static public function exposeTextField(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var objectRef:ExposedObjectReference;
		var select:ExposedSelect;
		var text:ExposedText;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("autoScale"))
		{
			bool = new ExposedBool("autoScale");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("autoSize"))
		{
			select = new ExposedSelect("autoSize");
			select.add("BOTH_DIRECTIONS", TextFieldAutoSize.BOTH_DIRECTIONS);
			select.add("HORIZONTAL", TextFieldAutoSize.HORIZONTAL);
			select.add("NONE", TextFieldAutoSize.NONE);
			select.add("VERTICAL", TextFieldAutoSize.VERTICAL);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("batchable"))
		{
			bool = new ExposedBool("batchable");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("border"))
		{
			bool = new ExposedBool("border");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("format"))
		{
			objectRef = new ExposedObjectReference("format");
			objectRef.addClass(TextFormat);
			collection.addValue(objectRef, groupName);
		}
		
		if (!collection.hasValue("isHtmlText"))
		{
			bool = new ExposedBool("isHtmlText");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("padding"))
		{
			floatDrag = new ExposedFloatDrag("padding");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("pixelSnapping"))
		{
			bool = new ExposedBool("pixelSnapping");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("style"))
		{
			objectRef = new ExposedObjectReference("style");
			objectRef.addClass(MeshStyle);
			collection.addValue(objectRef, groupName);
		}
		
		if (!collection.hasValue("styleSheet"))
		{
			objectRef = new ExposedObjectReference("styleSheet");
			objectRef.addClass(StyleSheet);
			collection.addValue(objectRef, groupName);
		}
		
		if (!collection.hasValue("text"))
		{
			text = new ExposedText("text");
			collection.addValue(text, groupName);
		}
		
		if (!collection.hasValue("wordWrap"))
		{
			bool = new ExposedBool("wordWrap");
			collection.addValue(bool, groupName);
		}
		
		StarlingDisplayData.exposeDisplayObjectContainer(collection, groupName);
		
		return collection;
	}
	
	static public function exposeTextFieldInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeTextField(collection);
		collection.setVisibleAll(false);
		applyTextFieldInstance(collection);
		
		return collection;
	}
	
	static private function applyTextFieldInstance(collection:ExposedCollection):Void
	{
		StarlingDisplayData.applyDisplayObjectContainerInstance(collection);
		collection.setVisibleArray([
			"text"
		], true);
	}
	
	static public function exposeTextFieldTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeTextField(collection);
		collection.setVisibleAll(false);
		applyTextFieldTemplate(collection);
		
		return collection;
	}
	
	static private function applyTextFieldTemplate(collection:ExposedCollection):Void
	{
		StarlingDisplayData.applyDisplayObjectContainerTemplate(collection);
		collection.setVisibleArray([
			"autoScale",
			"autoSize",
			"batchable",
			"border",
			"format",
			"isHtmlText",
			"padding",
			"pixelSnapping",
			"style",
			"styleSheet",
			"wordWrap"
		], true);
	}
	
	static public function exposeTextFieldConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var intDrag:ExposedIntDrag;
		var objectRef:ExposedObjectReference;
		var text:ExposedText;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("width"))
		{
			intDrag = new ExposedIntDrag("width");
			intDrag.defaultValue = 0;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			intDrag = new ExposedIntDrag("height");
			intDrag.defaultValue = 0;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("text"))
		{
			text = new ExposedText("text");
			text.defaultValue = "";
			collection.addValue(text, groupName);
		}
		
		if (!collection.hasValue("format"))
		{
			objectRef = new ExposedObjectReference("format");
			collection.addValue(objectRef, groupName);
		}
		
		if (!collection.hasValue("options"))
		{
			objectRef = new ExposedObjectReference("options");
			collection.addValue(objectRef, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTextFormat(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var font:ExposedFontName;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("bold"))
		{
			bool = new ExposedBool("bold");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("font"))
		{
			font = new ExposedFontName("font");
			collection.addValue(font, groupName);
		}
		
		if (!collection.hasValue("horizontalAlign"))
		{
			select = new ExposedSelect("horizontalAlign");
			select.add("CENTER", Align.CENTER);
			select.add("LEFT", Align.LEFT);
			select.add("RIGHT", Align.RIGHT);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("italic"))
		{
			bool = new ExposedBool("italic");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("kerning"))
		{
			bool = new ExposedBool("kerning");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("leading"))
		{
			floatDrag = new ExposedFloatDrag("leading");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("letterSpacing"))
		{
			floatDrag = new ExposedFloatDrag("letterSpacing");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("size"))
		{
			floatDrag = new ExposedFloatDrag("size", null, 0);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("underline"))
		{
			bool = new ExposedBool("underline");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("verticalAlign"))
		{
			select = new ExposedSelect("verticalAlign");
			select.add("BOTTOM", Align.BOTTOM);
			select.add("CENTER", Align.CENTER);
			select.add("TOP", Align.TOP);
			collection.addValue(select, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTextFormatConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var font:ExposedFontName;
		var select:ExposedSelect;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("font"))
		{
			font = new ExposedFontName("font");
			collection.addValue(font, groupName);
		}
		
		if (!collection.hasValue("size"))
		{
			floatDrag = new ExposedFloatDrag("size", null, 0);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("horizontalAlign"))
		{
			select = new ExposedSelect("horizontalAlign");
			select.add("CENTER", Align.CENTER);
			select.add("LEFT", Align.LEFT);
			select.add("RIGHT", Align.RIGHT);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("verticalAlign"))
		{
			select = new ExposedSelect("verticalAlign");
			select.add("BOTTOM", Align.BOTTOM);
			select.add("CENTER", Align.CENTER);
			select.add("TOP", Align.TOP);
			collection.addValue(select, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTextOptions(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var func:ExposedFunction;
		var objectRef:ExposedObjectReference;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("autoScale"))
		{
			bool = new ExposedBool("autoScale");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("autoSize"))
		{
			select = new ExposedSelect("autoSize");
			select.add("BOTH_DIRECTIONS", TextFieldAutoSize.BOTH_DIRECTIONS);
			select.add("HORIZONTAL", TextFieldAutoSize.HORIZONTAL);
			select.add("NONE", TextFieldAutoSize.NONE);
			select.add("VERTICAL", TextFieldAutoSize.VERTICAL);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("isHtmlText"))
		{
			bool = new ExposedBool("isHtmlText");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("padding"))
		{
			floatDrag = new ExposedFloatDrag("padding");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("styleSheet"))
		{
			objectRef = new ExposedObjectReference("styleSheet");
			objectRef.addClass(StyleSheet);
			collection.addValue(objectRef, groupName);
		}
		
		if (!collection.hasValue("textureFormat"))
		{
			select = new ExposedSelect("textureFormat");
			select.add("BGR_PACKED", Context3DTextureFormat.BGR_PACKED);
			select.add("BGRA", Context3DTextureFormat.BGRA);
			select.add("BGRA_PACKED", Context3DTextureFormat.BGRA_PACKED);
			select.add("COMPRESSED (ATF)", Context3DTextureFormat.COMPRESSED);
			select.add("COMPRESSED_ALPHA (ATF)", Context3DTextureFormat.COMPRESSED_ALPHA);
			select.add("RGBA_HALF_FLOAT", Context3DTextureFormat.RGBA_HALF_FLOAT);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("textureScale"))
		{
			floatDrag = new ExposedFloatDrag("textureScale", null, 0);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("wordWrap"))
		{
			bool = new ExposedBool("wordWrap");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("copyFrom"))
		{
			func = new ExposedFunction("copyFrom");
			objectRef = new ExposedObjectReference("options");
			objectRef.addClass(TextOptions);
			func.addParameter(objectRef);
			collection.addValue(func, groupName);
		}
		
		return collection;
	}
	
	static public function exposeTextOptionsConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("wordWrap"))
		{
			bool = new ExposedBool("wordWrap");
			bool.defaultValue = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("autoScale"))
		{
			bool = new ExposedBool("autoScale");
			bool.defaultValue = false;
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
}