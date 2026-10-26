package valedit.data.massive.display;
import juggler.animation.Juggler;
import massive.animation.AnimationCollection;
import massive.data.Frame;
import massive.data.VertexColorData;
import massive.data.VertexPositionData;
import massive.display.color.ColorMode;
import massive.display.color.ColorOffsetMode;
import massive.display.render.RenderMode;
import openfl.geom.Rectangle;
import starling.textures.TextureSmoothing;
import valedit.ExposedCollection;
import valedit.data.starling.display.StarlingDisplayData;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObject;
import valedit.value.ExposedObjectReference;
import valedit.value.ExposedSelect;
import valedit.value.ExposedString;
import valedit.value.starling.ExposedStarlingTexture;

/**
 * ...
 * @author Matse
 */
class MassiveDisplayData 
{
	static public function exposeClip(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var obj:ExposedObject;
		var objRef:ExposedObjectReference;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeImg(collection, groupName);
		
		if (!collection.hasValue("animate"))
		{
			bool = new ExposedBool("animate");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("animation"))
		{
			obj = new ExposedObject("animation");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("animationCollection"))
		{
			objRef = new ExposedObjectReference("animationCollection");
			objRef.allowClass(AnimationCollection);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("animationComplete"))
		{
			bool = new ExposedBool("animationComplete");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("frameDelta"))
		{
			floatDrag = new ExposedFloatDrag("frameDelta", null, 0.0, null, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("frameIndex"))
		{
			intDrag = new ExposedIntDrag("frameIndex", null, 0);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("frameIndexBasic"))
		{
			intDrag = new ExposedIntDrag("frameIndexBasic", null, 0);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("frameTime"))
		{
			floatDrag = new ExposedFloatDrag("frameTime", null, null, null, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("frameTimingCurrent"))
		{
			floatDrag = new ExposedFloatDrag("frameTimingCurrent");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("lastFrameIndex"))
		{
			intDrag = new ExposedIntDrag("lastFrameIndex");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("loop"))
		{
			bool = new ExposedBool("loop");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("loopCount"))
		{
			intDrag = new ExposedIntDrag("loopCount");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("numLoops"))
		{
			intDrag = new ExposedIntDrag("numLoops");
			collection.addValue(intDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeContainerBase(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayBase(collection, groupName);
		
		if (!collection.hasValue("autoHandleNumDatas"))
		{
			bool = new ExposedBool("autoHandleNumDatas");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("numDatas"))
		{
			intDrag = new ExposedIntDrag("numDatas");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("red"))
		{
			floatDrag = new ExposedFloatDrag("red", null, -10.0, 10.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("green"))
		{
			floatDrag = new ExposedFloatDrag("green", null, -10.0, 10.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blue"))
		{
			floatDrag = new ExposedFloatDrag("blue", null, -10.0, 10.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, -10.0, 10.0, 0.005);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("redOffset"))
		{
			floatDrag = new ExposedFloatDrag("redOffset", null, -10.0, 10.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("greenOffset"))
		{
			floatDrag = new ExposedFloatDrag("greenOffset", null, -10.0, 10.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blueOffset"))
		{
			floatDrag = new ExposedFloatDrag("blueOffset", null, -10.0, 10.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alphaOffset"))
		{
			floatDrag = new ExposedFloatDrag("alphaOffset", null, -10.0, 10.0, 0.005);
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeDisplayBase(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("name"))
		{
			str = new ExposedString("name");
			collection.addValue(str, groupName);
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
		
		if (collection.hasValue("visible"))
		{
			bool = new ExposedBool("visible");
			collection.addValue(bool, groupName);
		}
		
		if (collection.hasValue("isContainer"))
		{
			bool = new ExposedBool("isContainer");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeEventClip(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeClip(collection, groupName);
		
		return collection;
	}
	
	static public function exposeImg(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var objRef:ExposedObjectReference;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeQuadBase(collection, groupName);
		
		if (!collection.hasValue("frame"))
		{
			objRef = new ExposedObjectReference("frame");
			objRef.allowClass(Frame);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("textureIndex"))
		{
			floatDrag = new ExposedFloatDrag("textureIndex", null, 0.0, 16.0, 1.0, 1.0);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("textureIndexReal"))
		{
			floatDrag = new ExposedFloatDrag("textureIndexReal");
			floatDrag.isReadOnly = true;
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
		
		if (!collection.hasValue("invertX"))
		{
			bool = new ExposedBool("invertX");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("invertY"))
		{
			bool = new ExposedBool("invertY");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeImgContainer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeContainerBase(collection, groupName);
		
		return collection;
	}
	
	static public function exposeMassiveDisplay(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var objRef:ExposedObjectReference;
		var select:ExposedSelect;
		var texture:ExposedStarlingTexture;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("renderMode"))
		{
			select = new ExposedSelect("renderMode");
			select.choiceListFunction = RenderMode.getValues;
			select.valueListFunction = RenderMode.getValues;
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("colorMode"))
		{
			select = new ExposedSelect("colorMode");
			select.choiceListFunction = ColorMode.getValues;
			select.valueListFunction = ColorMode.getValues;
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("colorOffsetMode"))
		{
			select = new ExposedSelect("colorOffsetMode");
			select.choiceListFunction = ColorOffsetMode.getValues;
			select.valueListFunction = ColorOffsetMode.getValues;
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("maxQuads"))
		{
			intDrag = new ExposedIntDrag("maxQuads");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("autoHandleJuggler"))
		{
			bool = new ExposedBool("autoHandleJuggler");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("autoUpdateBounds"))
		{
			bool = new ExposedBool("autoUpdateBounds");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("boundsRect"))
		{
			objRef = new ExposedObjectReference("boundsRect");
			objRef.allowClass(Rectangle);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("color"))
		{
			color = new ExposedColor("color");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("red"))
		{
			floatDrag = new ExposedFloatDrag("red", null, -10.0, 10.0, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("green"))
		{
			floatDrag = new ExposedFloatDrag("green", null, -10.0, 10.0, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blue"))
		{
			floatDrag = new ExposedFloatDrag("blue", null, -10.0, 10.0, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, -10.0, 10.0, 0.005);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("colorOffset"))
		{
			color = new ExposedColor("colorOffset");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("redOffset"))
		{
			floatDrag = new ExposedFloatDrag("redOffset", null, -10.0, 10.0, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("greenOffset"))
		{
			floatDrag = new ExposedFloatDrag("greenOffset", null, -10.0, 10.0, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blueOffset"))
		{
			floatDrag = new ExposedFloatDrag("blueOffset", null, -10.0, 10.0, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alphaOffset"))
		{
			floatDrag = new ExposedFloatDrag("alphaOffset", null, -10.0, 10.0, 0.1);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("renderOffsetX"))
		{
			floatDrag = new ExposedFloatDrag("renderOffsetX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("renderOffsetY"))
		{
			floatDrag = new ExposedFloatDrag("renderOffsetY");
			collection.addValue(floatDrag, groupName);
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
			select.add(TextureSmoothing.BILINEAR);
			select.add(TextureSmoothing.NONE);
			select.add(TextureSmoothing.TRILINEAR);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("elementsPerQuad"))
		{
			intDrag = new ExposedIntDrag("elementsPerQuad");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("elementsPerVertex"))
		{
			intDrag = new ExposedIntDrag("elementsPerVertex");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("juggler"))
		{
			objRef = new ExposedObjectReference("juggler");
			objRef.allowClass(Juggler);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("numLayers"))
		{
			intDrag = new ExposedIntDrag("numLayers");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("numQuads"))
		{
			intDrag = new ExposedIntDrag("numQuads");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("numTextures"))
		{
			intDrag = new ExposedIntDrag("numTextures");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("pma"))
		{
			bool = new ExposedBool("pma");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		StarlingDisplayData.exposeDisplayObject(collection, groupName);
		
		return collection;
	}
	
	static public function exposeMixedContainer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeContainerBase(collection, groupName);
		
		return collection;
	}
	
	static public function exposeQuadBase(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var objRef:ExposedObjectReference;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeDisplayBase(collection, groupName);
		
		if (!collection.hasValue("hasVertexColor"))
		{
			bool = new ExposedBool("hasVertexColor");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("hasVertexColorOffset"))
		{
			bool = new ExposedBool("hasVertexColorOffset");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("hasVertexPosition"))
		{
			bool = new ExposedBool("hasVertexPosition");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("offsetX"))
		{
			floatDrag = new ExposedFloatDrag("offsetX");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("offsetY"))
		{
			floatDrag = new ExposedFloatDrag("offsetY");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("rotation"))
		{
			floatDrag = new ExposedFloatDrag("rotation", null, null, null, 0.01);
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
		
		if (!collection.hasValue("skewX"))
		{
			floatDrag = new ExposedFloatDrag("skewX", null, null, null, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("skewY"))
		{
			floatDrag = new ExposedFloatDrag("skewY", null, null, null, 0.05);
			collection.addValue(floatDrag, groupName);
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
		
		if (!collection.hasValue("colorOffset"))
		{
			color = new ExposedColor("colorOffset");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("redOffset"))
		{
			floatDrag = new ExposedFloatDrag("redOffset", null, -1.0, 10.0, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("greenOffset"))
		{
			floatDrag = new ExposedFloatDrag("greenOffset", null, -1.0, 10.0, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("blueOffset"))
		{
			floatDrag = new ExposedFloatDrag("blueOffset", null, -1.0, 10.0, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("alphaOffset"))
		{
			floatDrag = new ExposedFloatDrag("alphaOffset", null, -1.0, 10.0, 0.05);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("vertexColor"))
		{
			objRef = new ExposedObjectReference("vertexColor");
			objRef.allowClass(VertexColorData);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("vertexColorOffset"))
		{
			objRef = new ExposedObjectReference("vertexColorOffset");
			objRef.allowClass(VertexColorData);
			collection.addValue(objRef, groupName);
		}
		
		if (!collection.hasValue("vertexPosition"))
		{
			objRef = new ExposedObjectReference("vertexPosition");
			objRef.allowClass(VertexPositionData);
			collection.addValue(objRef, groupName);
		}
		
		return collection;
	}
	
	//static private function exposeMassiveLayer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	//{
		//var bool:ExposedBool;
		//var intDrag:ExposedIntDrag;
		//var string:ExposedString;
		//
		//if (collection == null) collection = new ExposedCollection();
		//
		//if (!collection.hasValue("name"))
		//{
			//string = new ExposedString("name");
			//collection.addValue(string, groupName);
		//}
		//
		//if (!collection.hasValue("numDatas"))
		//{
			//intDrag = new ExposedIntDrag("numDatas");
			//collection.addValue(intDrag, groupName);
		//}
		//
		//if (!collection.hasValue("totalDatas"))
		//{
			//intDrag = new ExposedIntDrag("totalDatas");
			//intDrag.isReadOnly = true;
			//collection.addValue(intDrag, groupName);
		//}
		//
		//if (!collection.hasValue("animate"))
		//{
			//bool = new ExposedBool("animate");
			//collection.addValue(bool, groupName);
		//}
		//
		//return collection;
	//}
	
	//static public function exposeMassiveImageLayer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	//{
		//var bool:ExposedBool;
		//
		//if (collection == null) collection = new ExposedCollection();
		//
		//exposeMassiveLayer(collection, groupName);
		//
		//var value:ExposedValue = collection.getValue("numDatas");
		//if (value != null)
		//{
			//value.isReadOnly = true;
		//}
		//
		//if (!collection.hasValue("textureAnimation"))
		//{
			//bool = new ExposedBool("textureAnimation");
			//collection.addValue(bool, groupName);
		//}
		//
		//return collection;
	//}
	
	//static public function exposeMassiveQuadLayer(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	//{
		//if (collection == null) collection = new ExposedCollection();
		//
		//exposeMassiveLayer(collection, groupName);
		//
		//return collection;
	//}
	
}