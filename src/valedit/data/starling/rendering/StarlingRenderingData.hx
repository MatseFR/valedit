package valedit.data.starling.rendering;
import openfl.display3D.Context3DCompareMode;
import openfl.display3D.Context3DProfile;
import openfl.display3D.Context3DTriangleFace;
import starling.display.BlendMode;
import starling.textures.TextureSmoothing;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObject;
import valedit.value.ExposedSelect;
import valedit.value.ExposedString;

/**
 * ...
 * @author Matse
 */
class StarlingRenderingData 
{
	
	static public function exposeBatchToken(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var intDrag:ExposedIntDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("batchID"))
		{
			intDrag = new ExposedIntDrag("batchID");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("indexID"))
		{
			intDrag = new ExposedIntDrag("indexID");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("vertexID"))
		{
			intDrag = new ExposedIntDrag("vertexID");
			collection.addValue(intDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeEffect(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var obj:ExposedObject;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("mvpMatrix3D"))
		{
			obj = new ExposedObject("mvpMatrix3D");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("vertexFormat"))
		{
			obj = new ExposedObject("vertexFormat");
			collection.addValue(obj, groupName);
		}
		
		return collection;
	}
	
	static public function exposeFilterEffect(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var obj:ExposedObject;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeEffect(collection, groupName);
		
		if (!collection.hasValue("texture"))
		{
			obj = new ExposedObject("texture");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("textureRepeat"))
		{
			bool = new ExposedBool("textureRepeat");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("textureSmoothing"))
		{
			select = new ExposedSelect("textureSmoothing");
			select.add(TextureSmoothing.NONE);
			select.add(TextureSmoothing.BILINEAR);
			select.add(TextureSmoothing.TRILINEAR);
			collection.addValue(select, groupName);
		}
		
		return collection;
	}
	
	static public function exposeIndexData(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var intDrag:ExposedIntDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("indexSizeInBytes"))
		{
			intDrag = new ExposedIntDrag("indexSizeInBytes");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("numIndices"))
		{
			intDrag = new ExposedIntDrag("numIndices", null, 0);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("numQuads"))
		{
			intDrag = new ExposedIntDrag("numQuads", null, 0);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("numTriangles"))
		{
			intDrag = new ExposedIntDrag("numTriangles", null, 0);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("useQuadLayout"))
		{
			bool = new ExposedBool("useQuadLayout");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeMeshEffect(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		exposeFilterEffect(collection, groupName);
		
		if (!collection.hasValue("alpha"))
		{
			floatDrag = new ExposedFloatDrag("alpha", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("tinted"))
		{
			bool = new ExposedBool("tinted");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}

	static public function exposePainter(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var obj:ExposedObject;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("backBufferHeight"))
		{
			intDrag = new ExposedIntDrag("backBufferHeight");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("backBufferScaleFactor"))
		{
			floatDrag = new ExposedFloatDrag("backBufferScaleFactor");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("backBufferWidth"))
		{
			intDrag = new ExposedIntDrag("backBufferWidth");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("cacheEnabled"))
		{
			bool = new ExposedBool("cacheEnabled");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("context"))
		{
			obj = new ExposedObject("context");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("contextValid"))
		{
			bool = new ExposedBool("contextValid");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("drawCount"))
		{
			intDrag = new ExposedIntDrag("drawCount", null, 0);
			collection.addValue(intDrag);
		}
		
		if (!collection.hasValue("enableErrorChecking"))
		{
			bool = new ExposedBool("enableErrorChecking");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("frameID"))
		{
			intDrag = new ExposedIntDrag("frameID");
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("pixelSize"))
		{
			floatDrag = new ExposedFloatDrag("pixelSize");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("profile"))
		{
			select = new ExposedSelect("profile");
			select.isReadOnly = true;
			select.add(Context3DProfile.BASELINE, Context3DProfile.BASELINE);
			select.add(Context3DProfile.BASELINE_CONSTRAINED, Context3DProfile.BASELINE_CONSTRAINED);
			select.add(Context3DProfile.BASELINE_EXTENDED, Context3DProfile.BASELINE_EXTENDED);
			select.add(Context3DProfile.STANDARD, Context3DProfile.STANDARD);
			select.add(Context3DProfile.STANDARD_CONSTRAINED, Context3DProfile.STANDARD_CONSTRAINED);
			select.add(Context3DProfile.STANDARD_EXTENDED, Context3DProfile.STANDARD_EXTENDED);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("shareContext"))
		{
			bool = new ExposedBool("shareContext");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("stage3D"))
		{
			obj = new ExposedObject("stage3D");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("state"))
		{
			obj = new ExposedObject("state");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("stencilReferenceValue"))
		{
			intDrag = new ExposedIntDrag("stencilReferenceValue", null, 0);
			collection.addValue(intDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeRenderState(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var obj:ExposedObject;
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
			select.add(BlendMode.ADD);
			select.add(BlendMode.AUTO);
			select.add(BlendMode.BELOW);
			select.add(BlendMode.ERASE);
			select.add(BlendMode.MASK);
			select.add(BlendMode.MULTIPLY);
			select.add(BlendMode.NONE);
			select.add(BlendMode.NORMAL);
			select.add(BlendMode.SCREEN);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("clipRect"))
		{
			obj = new ExposedObject("clipRect");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("culling"))
		{
			select = new ExposedSelect("culling");
			select.add(Context3DTriangleFace.BACK, Context3DTriangleFace.BACK);
			select.add(Context3DTriangleFace.FRONT, Context3DTriangleFace.FRONT);
			select.add(Context3DTriangleFace.FRONT_AND_BACK, Context3DTriangleFace.FRONT_AND_BACK);
			select.add(Context3DTriangleFace.NONE, Context3DTriangleFace.NONE);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("depthMask"))
		{
			bool = new ExposedBool("depthMask");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("depthTest"))
		{
			select = new ExposedSelect("depthTest");
			select.add(Context3DCompareMode.ALWAYS, Context3DCompareMode.ALWAYS);
			select.add(Context3DCompareMode.EQUAL, Context3DCompareMode.EQUAL);
			select.add(Context3DCompareMode.GREATER, Context3DCompareMode.GREATER);
			select.add(Context3DCompareMode.GREATER_EQUAL, Context3DCompareMode.GREATER_EQUAL);
			select.add(Context3DCompareMode.LESS, Context3DCompareMode.LESS);
			select.add(Context3DCompareMode.LESS_EQUAL, Context3DCompareMode.LESS_EQUAL);
			select.add(Context3DCompareMode.NEVER, Context3DCompareMode.NEVER);
			select.add(Context3DCompareMode.NOT_EQUAL, Context3DCompareMode.NOT_EQUAL);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("is3D"))
		{
			bool = new ExposedBool("is3D");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("modelViewMatrix"))
		{
			obj = new ExposedObject("modelViewMatrix");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("modelViewMatrix3D"))
		{
			obj = new ExposedObject("modelViewMatrix3D");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("mvpMatrix3D"))
		{
			obj = new ExposedObject("mvpMatrix3D");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("projectionMatrix3D"))
		{
			obj = new ExposedObject("projectionMatrix3D");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("renderTarget"))
		{
			obj = new ExposedObject("renderTarget");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("renderTargetAntiAlias"))
		{
			intDrag = new ExposedIntDrag("renderTargetAntiAlias");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("renderTargetSupportsDepthAndStencil"))
		{
			bool = new ExposedBool("renderTargetSupportsDepthAndStencil");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeVertexData(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var intDrag:ExposedIntDrag;
		var obj:ExposedObject;
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("format"))
		{
			obj = new ExposedObject("format");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("formatString"))
		{
			str = new ExposedString("formatString");
			str.isReadOnly = true;
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("numVertices"))
		{
			intDrag = new ExposedIntDrag("numVertices", null, 0);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("preMultipliedAlpha"))
		{
			bool = new ExposedBool("preMultipliedAlpha");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("size"))
		{
			intDrag = new ExposedIntDrag("size");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("sizeIn32Bits"))
		{
			intDrag = new ExposedIntDrag("sizeIn32Bits");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("tinted"))
		{
			bool = new ExposedBool("tinted");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("vertexSize"))
		{
			intDrag = new ExposedIntDrag("vertexSize");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("vertexSizeIn32Bits"))
		{
			intDrag = new ExposedIntDrag("vertexSizeIn32Bits");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeVertexDataFormat(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var intDrag:ExposedIntDrag;
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("formatString"))
		{
			str = new ExposedString("formatString");
			str.isReadOnly = true;
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("numAttributes"))
		{
			intDrag = new ExposedIntDrag("numAttributes");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("vertexSize"))
		{
			intDrag = new ExposedIntDrag("vertexSize");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("vertexSizeIn32Bits"))
		{
			intDrag = new ExposedIntDrag("vertexSizeIn32Bits");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		return collection;
	}
	
}