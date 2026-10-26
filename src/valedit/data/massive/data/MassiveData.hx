package valedit.data.massive.data;
import starling.utils.Align;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedFunction;
import valedit.value.ExposedGroup;
import valedit.value.ExposedSelect;
import valedit.value.extra.FunctionCallExtra;

/**
 * ...
 * @author Matse
 */
class MassiveData 
{
	
	static public function exposeFrame(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var func:ExposedFunction;
		var select:ExposedSelect;
		
		var funcExtra:FunctionCallExtra;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("u1"))
		{
			floatDrag = new ExposedFloatDrag("u1", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("v1"))
		{
			floatDrag = new ExposedFloatDrag("v1", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("u2"))
		{
			floatDrag = new ExposedFloatDrag("u2", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("v2"))
		{
			floatDrag = new ExposedFloatDrag("v2", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("width"))
		{
			floatDrag = new ExposedFloatDrag("width");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("height"))
		{
			floatDrag = new ExposedFloatDrag("height");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("pivotX"))
		{
			floatDrag = new ExposedFloatDrag("pivotX");
			funcExtra = new FunctionCallExtra("pivotUpdate");
			floatDrag.extras.add(funcExtra);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("pivotY"))
		{
			floatDrag = new ExposedFloatDrag("pivotY");
			funcExtra = new FunctionCallExtra("pivotUpdate");
			floatDrag.extras.add(funcExtra);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alignPivot"))
		{
			func = new ExposedFunction("alignPivot", "align pivot");
			
			select = new ExposedSelect("horizontal align");
			select.add("center", Align.CENTER);
			select.add("left", Align.LEFT);
			select.add("right", Align.RIGHT);
			func.addParameter(select);
			
			select = new ExposedSelect("vertical align");
			select.add("center", Align.CENTER);
			select.add("top", Align.TOP);
			select.add("bottom", Align.BOTTOM);
			func.addParameter(select);
			
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("leftWidth"))
		{
			floatDrag = new ExposedFloatDrag("leftWidth");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("rightWidth"))
		{
			floatDrag = new ExposedFloatDrag("rightWidth");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("topHeight"))
		{
			floatDrag = new ExposedFloatDrag("topHeight");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("bottomHeight"))
		{
			floatDrag = new ExposedFloatDrag("bottomHeight");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("rotated"))
		{
			bool = new ExposedBool("rotated");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeVertexColorData(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		
		var group:ExposedGroup;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("isChanging"))
		{
			bool = new ExposedBool("isChanging");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("red"))
		{
			floatDrag = new ExposedFloatDrag("red", null, -1.0, 10.0, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("green"))
		{
			floatDrag = new ExposedFloatDrag("green", null, -1.0, 10.0, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blue"))
		{
			floatDrag = new ExposedFloatDrag("blue", null, -1.0, 10.0, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, -1.0, 10.0, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		// Top left
		group = collection.getGroup("top left");
		if (group == null)
		{
			group = new ExposedGroup("top left");
			collection.addValue(group, groupName);
		}
		
		if (!group.hasValue("color1"))
		{
			color = new ExposedColor("color1");
			group.addValue(color);
		}
		
		if (!group.hasValue("red1"))
		{
			floatDrag = new ExposedFloatDrag("red1", null, -1.0, 10.0, 0.05);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("green1"))
		{
			floatDrag = new ExposedFloatDrag("green1", null, -1.0, 10.0, 0.05);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("blue1"))
		{
			floatDrag = new ExposedFloatDrag("blue1", null, -1.0, 10.0, 0.05);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("alpha1"))
		{
			floatDrag = new ExposedFloatDrag("alpha1", null, -1.0, 10.0, 0.05);
			group.addValue(floatDrag);
		}
		//\Top left
		
		// Top right
		group = collection.getGroup("top right");
		if (group == null)
		{
			group = new ExposedGroup("top right");
			collection.addValue(group, groupName);
		}
		
		if (!group.hasValue("color2"))
		{
			color = new ExposedColor("color2");
			group.addValue(color);
		}
		
		if (!group.hasValue("red2"))
		{
			floatDrag = new ExposedFloatDrag("red2", null, -1.0, 10.0, 0.05);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("green2"))
		{
			floatDrag = new ExposedFloatDrag("green2", null, -1.0, 10.0, 0.05);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("blue2"))
		{
			floatDrag = new ExposedFloatDrag("blue2", null, -1.0, 10.0, 0.05);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("alpha2"))
		{
			floatDrag = new ExposedFloatDrag("alpha2", null, -1.0, 10.0, 0.05);
			group.addValue(floatDrag);
		}
		//\Top right
		
		// Bottom left
		group = collection.getGroup("bottom left");
		if (group == null)
		{
			group = new ExposedGroup("bottom left");
			collection.addValue(group, groupName);
		}
		
		if (!group.hasValue("color3"))
		{
			color = new ExposedColor("color3");
			group.addValue(color);
		}
		
		if (!group.hasValue("red3"))
		{
			floatDrag = new ExposedFloatDrag("red3", null, -1.0, 10.0, 0.05);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("green3"))
		{
			floatDrag = new ExposedFloatDrag("green3", null, -1.0, 10.0, 0.05);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("blue3"))
		{
			floatDrag = new ExposedFloatDrag("blue3", null, -1.0, 10.0, 0.05);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("alpha3"))
		{
			floatDrag = new ExposedFloatDrag("alpha3", null, -1.0, 10.0, 0.05);
			group.addValue(floatDrag);
		}
		//\Bottom left
		
		// Bottom right
		group = collection.getGroup("bottom right");
		if (group == null)
		{
			group = new ExposedGroup("bottom right");
			collection.addValue(group, groupName);
		}
		
		if (!group.hasValue("color4"))
		{
			color = new ExposedColor("color4");
			group.addValue(color);
		}
		
		if (!group.hasValue("red4"))
		{
			floatDrag = new ExposedFloatDrag("red4", null, -1.0, 10.0, 0.05);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("green4"))
		{
			floatDrag = new ExposedFloatDrag("green4", null, -1.0, 10.0, 0.05);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("blue4"))
		{
			floatDrag = new ExposedFloatDrag("blue4", null, -1.0, 10.0, 0.05);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("alpha4"))
		{
			floatDrag = new ExposedFloatDrag("alpha4", null, -1.0, 10.0, 0.05);
			group.addValue(floatDrag);
		}
		//\Bottom right
		
		return collection;
	}
	
	static public function exposeVertexPositionData(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		
		var funcExtra:FunctionCallExtra;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("x1"))
		{
			floatDrag = new ExposedFloatDrag("x1");
			funcExtra = new FunctionCallExtra("processInversions");
			floatDrag.extras.add(funcExtra);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("y1"))
		{
			floatDrag = new ExposedFloatDrag("y1");
			funcExtra = new FunctionCallExtra("processInversions");
			floatDrag.extras.add(funcExtra);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("x2"))
		{
			floatDrag = new ExposedFloatDrag("x2");
			funcExtra = new FunctionCallExtra("processInversions");
			floatDrag.extras.add(funcExtra);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("y2"))
		{
			floatDrag = new ExposedFloatDrag("y2");
			funcExtra = new FunctionCallExtra("processInversions");
			floatDrag.extras.add(funcExtra);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("x3"))
		{
			floatDrag = new ExposedFloatDrag("x3");
			funcExtra = new FunctionCallExtra("processInversions");
			floatDrag.extras.add(funcExtra);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("y3"))
		{
			floatDrag = new ExposedFloatDrag("y3");
			funcExtra = new FunctionCallExtra("processInversions");
			floatDrag.extras.add(funcExtra);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("x4"))
		{
			floatDrag = new ExposedFloatDrag("x4");
			funcExtra = new FunctionCallExtra("processInversions");
			floatDrag.extras.add(funcExtra);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("y4"))
		{
			floatDrag = new ExposedFloatDrag("y4");
			funcExtra = new FunctionCallExtra("processInversions");
			floatDrag.extras.add(funcExtra);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("pivotX"))
		{
			floatDrag = new ExposedFloatDrag("pivotX");
			funcExtra = new FunctionCallExtra("processInversions");
			floatDrag.extras.add(funcExtra);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("pivotY"))
		{
			floatDrag = new ExposedFloatDrag("pivotY");
			funcExtra = new FunctionCallExtra("processInversions");
			floatDrag.extras.add(funcExtra);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("canInvertX"))
		{
			bool = new ExposedBool("canInvertX");
			funcExtra = new FunctionCallExtra("processInversions");
			bool.extras.add(funcExtra);
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("canInvertY"))
		{
			bool = new ExposedBool("canInvertY");
			funcExtra = new FunctionCallExtra("processInversions");
			bool.extras.add(funcExtra);
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("isChanging"))
		{
			bool = new ExposedBool("isChanging");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
}