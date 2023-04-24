package valedit.data.starling.display;
import starling.display.BlendMode;
import starling.textures.TextureSmoothing;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloat;
import valedit.value.ExposedFloatRange;
import valedit.value.ExposedGroup;
import valedit.value.ExposedObject;
import valedit.value.ExposedSelect;
import valedit.value.ExposedStarlingTexture;
import valedit.value.ExposedString;

/**
 * ...
 * @author Matse
 */
class StarlingDisplayData 
{

	static public function exposeDisplayObject(collection:ExposedCollection = null, useGroups:Bool = true):ExposedCollection
	{
		var group:ExposedGroup;
		var groupName:String = null;
		
		var bool:ExposedBool;
		var floatRange:ExposedFloatRange;
		var float:ExposedFloat;
		var object:ExposedObject;
		var select:ExposedSelect;
		var string:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (useGroups)
		{
			groupName = "Properties";
			group = collection.getGroup(groupName);
			if (group == null)
			{
				group = new ExposedGroup(groupName, true);
				collection.addValue(group);
			}
		}
		
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
		
		if (!collection.hasValue("pivotX"))
		{
			float = new ExposedFloat("pivotX");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("pivotY"))
		{
			float = new ExposedFloat("pivotY");
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
			floatRange = new ExposedFloatRange("alpha", null, 0, 1, 0.01, 2, 75, 25);
			collection.addValue(floatRange, groupName);
		}
		
		if (!collection.hasValue("rotation"))
		{
			float = new ExposedFloat("rotation");
			collection.addValue(float, groupName)
		}
		
		if (!collection.hasValue("skewX"))
		{
			float = new ExposedFloat("skewX");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("skewY"))
		{
			float = new ExposedFloat("skewY");
			collection.addValue(float, groupName);
		}
		
		if (!collection.hasValue("blendMode"))
		{
			select = new ExposedSelect("blendMode");
			select.add("ADD", BlendMode.ADD);
			select.add("AUTO", BlendMode.AUTO);
			select.add("BELOW", BlendMode.BELOW);
			select.add("ERASE", BlendMode.ERASE);
			select.add("MASK", BlendMode.MASK);
			select.add("MULTIPLY", BlendMode.MULTIPLY);
			select.add("NONE", BlendMode.NONE);
			select.add("NORMAL", BlendMode.NORMAL);
			select.add("SCREEN", BlendMode.SCREEN);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("transformationMatrix"))
		{
			object = new ExposedObject("transformationMatrix");
			collection.addValue(object, groupName);
		}
		
		if (!collection.hasValue("maskInverted"))
		{
			bool = new ExposedBool("maskInverted");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("touchable"))
		{
			bool = new ExposedBool("touchable");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("useHandCursor"))
		{
			bool = new ExposedBool("useHandCursor");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("visible"))
		{
			bool = new ExposedBool("visible");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeDisplayObjectContainer(collection:ExposedCollection = null, useGroups:Bool = true):ExposedCollection
	{
		var groupName:String = useGroups ? "Properties" : null;
		
		var bool:ExposedBool;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObject(collection, useGroups);
		
		if (!collection.hasValue("touchGroup"))
		{
			bool = new ExposedBool("touchGroup");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeImage(collection:ExposedCollection = null, useGroups:Bool = true):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeMesh(collection, useGroups);
		
		return collection;
	}
	
	static public function exposeMesh(collection:ExposedCollection = null, useGroups:Bool = true):ExposedCollection
	{
		var groupName:String = useGroups ? "Properties" : null;
		
		var bool:ExposedBool;
		var color:ExposedColor;
		var select:ExposedSelect;
		var texture:ExposedStarlingTexture;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObject(collection, useGroups);
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("pixelSnapping"))
		{
			bool = new ExposedBool("pixelSnapping");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("texture"))
		{
			texture = new ExposedStarlingTexture("texture");
			collection.addValue(texture, groupName);
		}
		
		if (!collection.hasValue("textureRepeat"))
		{
			bool = new ExposedBool("textureRepeat");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("textureSmoothing"))
		{
			select = new ExposedSelect("textureSmoothing");
			select.add("BILINEAR", TextureSmoothing.BILINEAR);
			select.add("NONE", TextureSmoothing.NONE);
			select.add("TRILINEAR", TextureSmoothing.TRILINEAR);
			collection.addValue(select, groupName);
		}
		
		return collection;
	}
	
	static public function exposeQuad(collection:ExposedCollection = null, useGroups:Bool = true):ExposedCollection
	{
		//var groupName:String = useGroups ? "Properties" : null;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeMesh(collection, useGroups);
		
		return collection;
	}
	
	static public function exposeSprite(collection:ExposedCollection = null, useGroups:Bool = true):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObjectContainer(collection, useGroups);
		
		return collection;
	}
	
	static public function exposeSprite3D(collection:ExposedCollection = null, useGroups:Bool = true):ExposedCollection
	{
		var groupName:String = useGroups ? "Properties" : null;
		
		var float:ExposedFloat;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayObjectContainer(collection, useGroups);
		
		if (!collection.hasValue("z"))
		{
			float = new ExposedFloat("z");
			collection.addValueAfter(float, "y", groupName);
		}
		
		if (!collection.hasValue("pivotZ"))
		{
			float = new ExposedFloat("pivotZ");
			collection.addValueAfter(float, "pivotY", groupName);
		}
		
		if (!collection.hasValue("rotationX"))
		{
			float = new ExposedFloat("rotationX");
			collection.addValueAfter(float, "rotation", groupName);
			collection.removeValueByName("rotation");
		}
		
		if (!collection.hasValue("rotationY"))
		{
			float = new ExposedFloat("rotationY");
			collection.addValueAfter(float, "rotationX", groupName);
		}
		
		if (!collection.hasValue("rotationZ"))
		{
			float = new ExposedFloat("rotationZ");
			collection.addValueAfter(float, "rotationY", groupName);
		}
		
		if (!collection.hasValue("scaleZ"))
		{
			float = new ExposedFloat("scaleZ");
			collection.addValueAfter(float, "scaleY", groupName);
		}
		
		return collection;
	}
	
}