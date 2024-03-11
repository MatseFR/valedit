package valedit.data.valedit;
import valedit.ExposedCollection;
import valedit.data.openfl.display.DisplayData;
import valedit.value.ExposedBitmapData;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObject;

/**
 * ...
 * @author Matse
 */
@:access(valedit.data.openfl.display.DisplayData)
class ShapeData 
{
	static public function exposeBaseShape(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bmd:ExposedBitmapData;
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		var object:ExposedObject;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("pivotX"))
		{
			floatDrag = new ExposedFloatDrag("pivotX");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("pivotY"))
		{
			floatDrag = new ExposedFloatDrag("pivotY");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("fill"))
		{
			bool = new ExposedBool("fill");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("fillAlpha"))
		{
			floatDrag = new ExposedFloatDrag("fillAlpha", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("fillColor"))
		{
			color = new ExposedColor("fillColor");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("fillBitmapData"))
		{
			bmd = new ExposedBitmapData("fillBitmapData");
			collection.addValue(bmd, groupName);
		}
		
		if (!collection.hasValue("fillRepeat"))
		{
			bool = new ExposedBool("fillRepeat");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("fillSmoothing"))
		{
			bool = new ExposedBool("fillSmoothing");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("fillMatrix"))
		{
			object = new ExposedObject("fillMatrix", null, true);
			collection.addValue(object, groupName);
		}
		
		if (!collection.hasValue("outline"))
		{
			bool = new ExposedBool("outline");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("outlineThickness"))
		{
			floatDrag = new ExposedFloatDrag("outlineThickness", null, 0, null, 0.5);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("outlineAlpha"))
		{
			floatDrag = new ExposedFloatDrag("outlineAlpha", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("outlineColor"))
		{
			color = new ExposedColor("outlineColor");
			collection.addValue(color, groupName);
		}
		
		if (!collection.hasValue("outlineBitmapData"))
		{
			bmd = new ExposedBitmapData("outlineBitmapData");
			collection.addValue(bmd, groupName);
		}
		
		if (!collection.hasValue("outlineRepeat"))
		{
			bool = new ExposedBool("outlineRepeat");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("outlineSmoothing"))
		{
			bool = new ExposedBool("outlineSmoothing");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("outlineMatrix"))
		{
			object = new ExposedObject("outlineMatrix", null, true);
			collection.addValue(object, groupName);
		}
		
		DisplayData.exposeDisplayObject(collection, groupName);
		
		return collection;
	}
	
	static public function exposeBaseShapeConstructor(?collection:ExposedCollection):ExposedCollection
	{
		var bmd:ExposedBitmapData;
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("fill"))
		{
			bool = new ExposedBool("fill");
			bool.defaultValue = true;
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("fillColor"))
		{
			color = new ExposedColor("fillColor");
			color.defaultValue = 0xffffff;
			collection.addValue(color);
		}
		
		if (!collection.hasValue("fillBitmapData"))
		{
			bmd = new ExposedBitmapData("fillBitmapData");
			collection.addValue(bmd);
		}
		
		if (!collection.hasValue("outline"))
		{
			bool = new ExposedBool("outline");
			bool.defaultValue = true;
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("outlineThickness"))
		{
			floatDrag = new ExposedFloatDrag("outlineThickness", null, 0, null, 0.5);
			floatDrag.defaultValue = 1.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("outlineColor"))
		{
			color = new ExposedColor("outlineColor");
			color.defaultValue = 0x000000;
			collection.addValue(color);
		}
		
		if (!collection.hasValue("outlineBitmapData"))
		{
			bmd = new ExposedBitmapData("outlineBitmapData");
			collection.addValue(bmd);
		}
		
		return collection;
	}
	
	static private function applyBaseShapeInstance(collection:ExposedCollection):Void
	{
		DisplayData.applyDisplayObjectInstance(collection);
		collection.setVisibleArray([
			"fill",
			"fillAlpha",
			"fillColor",
			"fillBitmapData",
			"fillRepeat",
			"fillSmoothing",
			"fillMatrix",
			"outline",
			"outlineThickness",
			"outlineAlpha",
			"outlineColor",
			"outlineBitmapData",
			"outlineRepeat",
			"outlineSmoothing",
			"outlineMatrix",
			"pivotX",
			"pivotY"
		], true);
	}
	
	static private function applyBaseShapeTemplate(collection:ExposedCollection):Void
	{
		DisplayData.applyDisplayObjectTemplate(collection);
		collection.setVisibleArray([
		], true);
	}
	
	static public function exposeArcShape(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("arc"))
		{
			floatDrag = new ExposedFloatDrag("arc", null, -360.0, 360.0);
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("radiusX"))
		{
			floatDrag = new ExposedFloatDrag("radiusX");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("radiusY"))
		{
			floatDrag = new ExposedFloatDrag("radiusY");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("startAngle"))
		{
			floatDrag = new ExposedFloatDrag("startAngle", null, -360.0, 360.0);
			collection.addValue(floatDrag);
		}
		
		exposeBaseShape(collection);
		
		return collection;
	}
	
	static public function exposeArcShapeConstructor(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("arc"))
		{
			floatDrag = new ExposedFloatDrag("arc", null, -360.0, 360.0);
			floatDrag.defaultValue = 90.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("radiusX"))
		{
			floatDrag = new ExposedFloatDrag("radiusX");
			floatDrag.defaultValue = 50.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("radiusY"))
		{
			floatDrag = new ExposedFloatDrag("radiusY");
			floatDrag.defaultValue = 50.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("startAngle"))
		{
			floatDrag = new ExposedFloatDrag("startAngle", null, -360.0, 360.0);
			floatDrag.defaultValue = 0.0;
			collection.addValue(floatDrag);
		}
		
		exposeBaseShapeConstructor(collection);
		
		return collection;
	}
	
	static public function exposeArcShapeInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeArcShape(collection);
		collection.setVisibleAll(false);
		applyArcShapeInstance(collection);
		
		return collection;
	}
	
	static private function applyArcShapeInstance(collection:ExposedCollection):Void
	{
		applyBaseShapeInstance(collection);
		collection.setVisibleArray([
			"arc",
			"radiusX",
			"radiusY",
			"startAngle"
		], true);
	}
	
	static public function exposeArcShapeTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeArcShape(collection);
		collection.setVisibleAll(false);
		applyArcShapeTemplate(collection);
		
		return collection;
	}
	
	static private function applyArcShapeTemplate(collection:ExposedCollection):Void
	{
		applyBaseShapeTemplate(collection);
		collection.setVisibleArray([
		], true);
	}
	
	static public function exposeArrowShape(?collection:ExposedCollection):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("arrowLength"))
		{
			floatDrag = new ExposedFloatDrag("arrowLength", null, 0.0);
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("arrowHeight"))
		{
			floatDrag = new ExposedFloatDrag("arrowHeight", null, 0.0);
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("tail"))
		{
			bool = new ExposedBool("tail");
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("tailLength"))
		{
			floatDrag = new ExposedFloatDrag("tailLength", null, 0.0);
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("tailHeight"))
		{
			floatDrag = new ExposedFloatDrag("tailHeight", null, 0.0);
			collection.addValue(floatDrag);
		}
		
		exposeBaseShape(collection);
		
		return collection;
	}
	
	static public function exposeArrowShapeConstructor(?collection:ExposedCollection):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("arrowLength"))
		{
			floatDrag = new ExposedFloatDrag("arrowLength", null, 0.0);
			floatDrag.defaultValue = 50.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("arrowHeight"))
		{
			floatDrag = new ExposedFloatDrag("arrowHeight", null, 0.0);
			floatDrag.defaultValue = 50.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("tail"))
		{
			bool = new ExposedBool("tail");
			bool.defaultValue = true;
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("tailLength"))
		{
			floatDrag = new ExposedFloatDrag("tailLength", null, 0.0);
			floatDrag.defaultValue = 30.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("tailHeight"))
		{
			floatDrag = new ExposedFloatDrag("tailHeight", null, 0.0);
			floatDrag.defaultValue = 20.0;
			collection.addValue(floatDrag);
		}
		
		exposeBaseShapeConstructor(collection);
		
		return collection;
	}
	
	static public function exposeArrowShapeInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeArrowShape(collection);
		collection.setVisibleAll(false);
		applyArrowShapeInstance(collection);
		
		return collection;
	}
	
	static private function applyArrowShapeInstance(collection:ExposedCollection):Void
	{
		applyBaseShapeInstance(collection);
		collection.setVisibleArray([
			"arrowLength",
			"arrowHeight",
			"tail",
			"tailLength",
			"tailHeight"
		], true);
	}
	
	static public function exposeArrowShapeTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeArrowShape(collection);
		collection.setVisibleAll(false);
		applyArrowShapeTemplate(collection);
		
		return collection;
	}
	
	static private function applyArrowShapeTemplate(collection:ExposedCollection):Void
	{
		applyBaseShapeTemplate(collection);
		collection.setVisibleArray([
		], true);
	}
	
	static public function exposeBurstShape(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("numSides"))
		{
			intDrag = new ExposedIntDrag("numSides", null, 3, null, 0.5);
			collection.addValue(intDrag);
		}
		
		if (!collection.hasValue("innerRadius"))
		{
			floatDrag = new ExposedFloatDrag("innerRadius");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("outerRadius"))
		{
			floatDrag = new ExposedFloatDrag("outerRadius");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("angle"))
		{
			floatDrag = new ExposedFloatDrag("angle");
			collection.addValue(floatDrag);
		}
		
		exposeBaseShape(collection);
		
		return collection;
	}
	
	static public function exposeBurstShapeConstructor(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("numSides"))
		{
			intDrag = new ExposedIntDrag("numSides", null, 3, null, 0.5);
			intDrag.defaultValue = 12;
			collection.addValue(intDrag);
		}
		
		if (!collection.hasValue("innerRadius"))
		{
			floatDrag = new ExposedFloatDrag("innerRadius");
			floatDrag.defaultValue = 40.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("outerRadius"))
		{
			floatDrag = new ExposedFloatDrag("outerRadius");
			floatDrag.defaultValue = 50.0;
			collection.addValue(floatDrag);
		}
		
		exposeBaseShapeConstructor(collection);
		
		return collection;
	}
	
	static public function exposeBurstShapeInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeBurstShape(collection);
		collection.setVisibleAll(false);
		applyBurstShapeInstance(collection);
		
		return collection;
	}
	
	static private function applyBurstShapeInstance(collection:ExposedCollection):Void
	{
		applyBaseShapeInstance(collection);
		collection.setVisibleArray([
			"angle",
			"innerRadius",
			"numSides",
			"outerRadius"
		], true);
	}
	
	static public function exposeBurstShapeTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeBurstShape(collection);
		collection.setVisibleAll(false);
		applyBurstShapeTemplate(collection);
		
		return collection;
	}
	
	static private function applyBurstShapeTemplate(collection:ExposedCollection):Void
	{
		applyBaseShapeTemplate(collection);
		collection.setVisibleArray([
		], true);
	}

	static public function exposeCircleShape(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("radius"))
		{
			floatDrag = new ExposedFloatDrag("radius", null, 0, null, 0.5);
			collection.addValue(floatDrag, groupName);
		}
		
		exposeBaseShape(collection, groupName);
		
		return collection;
	}
	
	static public function exposeCircleShapeConstructor(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("radius"))
		{
			floatDrag = new ExposedFloatDrag("radius", null, 0, null, 0.5);
			floatDrag.defaultValue = 50.0;
			collection.addValue(floatDrag);
		}
		
		exposeBaseShapeConstructor(collection);
		
		return collection;
	}
	
	static public function exposeCircleShapeInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeCircleShape(collection);
		collection.setVisibleAll(false);
		applyCircleShapeInstance(collection);
		
		return collection;
	}
	
	static private function applyCircleShapeInstance(collection:ExposedCollection):Void
	{
		applyBaseShapeInstance(collection);
		collection.setVisibleArray([
			"radius"
		], true);
	}
	
	static public function exposeCircleShapeTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeCircleShape(collection);
		collection.setVisibleAll(false);
		applyCircleShapeTemplate(collection);
		
		return collection;
	}
	
	static private function applyCircleShapeTemplate(collection:ExposedCollection):Void
	{
		applyBaseShapeTemplate(collection);
		collection.setVisibleArray([
		], true);
	}
	
	static public function exposeDonutShape(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("radius"))
		{
			floatDrag = new ExposedFloatDrag("radius", null, 0.0);
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("holeRadius"))
		{
			floatDrag = new ExposedFloatDrag("holeRadius", null, 0.0);
			collection.addValue(floatDrag);
		}
		
		exposeBaseShape(collection);
		
		return collection;
	}
	
	static public function exposeDonutShapeConstructor(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("radius"))
		{
			floatDrag = new ExposedFloatDrag("radius", null, 0.0);
			floatDrag.defaultValue = 50.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("holeRadius"))
		{
			floatDrag = new ExposedFloatDrag("holeRadius", null, 0.0);
			floatDrag.defaultValue = 20.0;
			collection.addValue(floatDrag);
		}
		
		exposeBaseShapeConstructor(collection);
		
		return collection;
	}
	
	static public function exposeDonutShapeInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeDonutShape(collection);
		collection.setVisibleAll(false);
		applyDonutShapeInstance(collection);
		
		return collection;
	}
	
	static private function applyDonutShapeInstance(collection:ExposedCollection):Void
	{
		applyBaseShapeInstance(collection);
		collection.setVisibleArray([
			"radius",
			"holeRadius"
		], true);
	}
	
	static public function exposeDonutShapeTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeDonutShape(collection);
		collection.setVisibleAll(false);
		applyDonutShapeTemplate(collection);
		
		return collection;
	}
	
	static private function applyDonutShapeTemplate(collection:ExposedCollection):Void
	{
		applyBaseShapeTemplate(collection);
		collection.setVisibleArray([
		], true);
	}
	
	static public function exposeEllipseShape(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("radiusX"))
		{
			floatDrag = new ExposedFloatDrag("radiusX", null, 0);
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("radiusY"))
		{
			floatDrag = new ExposedFloatDrag("radiusY", null, 0);
			collection.addValue(floatDrag);
		}
		
		exposeBaseShape(collection);
		
		return collection;
	}
	
	static public function exposeEllipseShapeConstructor(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("radiusX"))
		{
			floatDrag = new ExposedFloatDrag("radiusX", null, 0);
			floatDrag.defaultValue = 50.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("radiusY"))
		{
			floatDrag = new ExposedFloatDrag("radiusY", null, 0);
			floatDrag.defaultValue = 50.0;
			collection.addValue(floatDrag);
		}
		
		exposeBaseShapeConstructor(collection);
		
		return collection;
	}
	
	static public function exposeEllipseShapeInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeEllipseShape(collection);
		collection.setVisibleAll(false);
		applyEllipseShapeInstance(collection);
		
		return collection;
	}
	
	static private function applyEllipseShapeInstance(collection:ExposedCollection):Void
	{
		applyBaseShapeInstance(collection);
		collection.setVisibleArray([
			"radiusX",
			"radiusY"
		], true);
	}
	
	static public function exposeEllipseShapeTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeEllipseShape(collection);
		collection.setVisibleAll(false);
		applyEllipseShapeTemplate(collection);
		
		return collection;
	}
	
	static private function applyEllipseShapeTemplate(collection:ExposedCollection):Void
	{
		applyBaseShapeTemplate(collection);
		collection.setVisibleArray([
		], true);
	}
	
	static public function exposeFlowerShape(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("numSides"))
		{
			intDrag = new ExposedIntDrag("numSides", null, 3, null, 0.5);
			collection.addValue(intDrag);
		}
		
		if (!collection.hasValue("innerRadius"))
		{
			floatDrag = new ExposedFloatDrag("innerRadius");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("outerRadius"))
		{
			floatDrag = new ExposedFloatDrag("outerRadius");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("angle"))
		{
			floatDrag = new ExposedFloatDrag("angle");
			collection.addValue(floatDrag);
		}
		
		exposeBaseShape(collection);
		
		return collection;
	}
	
	static public function exposeFlowerShapeConstructor(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("numSides"))
		{
			intDrag = new ExposedIntDrag("numSides", null, 3, null, 0.5);
			intDrag.defaultValue = 12;
			collection.addValue(intDrag);
		}
		
		if (!collection.hasValue("innerRadius"))
		{
			floatDrag = new ExposedFloatDrag("innerRadius");
			floatDrag.defaultValue = 40.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("outerRadius"))
		{
			floatDrag = new ExposedFloatDrag("outerRadius");
			floatDrag.defaultValue = 50.0;
			collection.addValue(floatDrag);
		}
		
		exposeBaseShapeConstructor(collection);
		
		return collection;
	}
	
	static public function exposeFlowerShapeInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeFlowerShape(collection);
		collection.setVisibleAll(false);
		applyFlowerShapeInstance(collection);
		
		return collection;
	}
	
	static private function applyFlowerShapeInstance(collection:ExposedCollection):Void
	{
		applyBaseShapeInstance(collection);
		collection.setVisibleArray([
			"angle",
			"innerRadius",
			"numSides",
			"outerRadius"
		], true);
	}
	
	static public function exposeFlowerShapeTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeFlowerShape(collection);
		collection.setVisibleAll(false);
		applyFlowerShapeTemplate(collection);
		
		return collection;
	}
	
	static private function applyFlowerShapeTemplate(collection:ExposedCollection):Void
	{
		applyBaseShapeTemplate(collection);
		collection.setVisibleArray([
		], true);
	}
	
	static public function exposeGearShape(?collection:ExposedCollection):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("numSides"))
		{
			intDrag = new ExposedIntDrag("numSides", null, 3, null, 0.5);
			collection.addValue(intDrag);
		}
		
		if (!collection.hasValue("innerRadius"))
		{
			floatDrag = new ExposedFloatDrag("innerRadius");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("outerRadius"))
		{
			floatDrag = new ExposedFloatDrag("outerRadius");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("angle"))
		{
			floatDrag = new ExposedFloatDrag("angle");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("hole"))
		{
			bool = new ExposedBool("hole");
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("numHoleSides"))
		{
			intDrag = new ExposedIntDrag("numHoleSides", null, 3, null, 0.5);
			collection.addValue(intDrag);
		}
		
		if (!collection.hasValue("holeRadius"))
		{
			floatDrag = new ExposedFloatDrag("holeRadius");
			collection.addValue(floatDrag);
		}
		
		exposeBaseShape(collection);
		
		return collection;
	}
	
	static public function exposeGearShapeConstructor(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("numSides"))
		{
			intDrag = new ExposedIntDrag("numSides", null, 3, null, 0.5);
			intDrag.defaultValue = 10;
			collection.addValue(intDrag);
		}
		
		if (!collection.hasValue("innerRadius"))
		{
			floatDrag = new ExposedFloatDrag("innerRadius");
			floatDrag.defaultValue = 40.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("outerRadius"))
		{
			floatDrag = new ExposedFloatDrag("outerRadius");
			floatDrag.defaultValue = 50.0;
			collection.addValue(floatDrag);
		}
		
		exposeBaseShapeConstructor(collection);
		
		return collection;
	}
	
	static public function exposeGearShapeInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeGearShape(collection);
		collection.setVisibleAll(false);
		applyGearShapeInstance(collection);
		
		return collection;
	}
	
	static private function applyGearShapeInstance(collection:ExposedCollection):Void
	{
		applyBaseShapeInstance(collection);
		collection.setVisibleArray([
			"angle",
			"hole",
			"holeRadius",
			"innerRadius",
			"numHoleSides",
			"numSides",
			"outerRadius"
		], true);
	}
	
	static public function exposeGearShapeTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeGearShape(collection);
		collection.setVisibleAll(false);
		applyGearShapeTemplate(collection);
		
		return collection;
	}
	
	static private function applyGearShapeTemplate(collection:ExposedCollection):Void
	{
		applyBaseShapeInstance(collection);
		collection.setVisibleArray([
		], true);
	}
	
	static public function exposePolygonShape(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("numSides"))
		{
			intDrag = new ExposedIntDrag("numSides", null, 3);
			collection.addValue(intDrag);
		}
		
		if (!collection.hasValue("radius"))
		{
			floatDrag = new ExposedFloatDrag("radius");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("angle"))
		{
			floatDrag = new ExposedFloatDrag("angle");
			collection.addValue(floatDrag);
		}
		
		exposeBaseShape(collection);
		
		return collection;
	}
	
	static public function exposePolygonShapeConstructor(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (collection == null) 
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("numSides"))
		{
			intDrag = new ExposedIntDrag("numSides", null, 3);
			intDrag.defaultValue = 5;
			collection.addValue(intDrag);
		}
		
		if (!collection.hasValue("radius"))
		{
			floatDrag = new ExposedFloatDrag("radius");
			floatDrag.defaultValue = 50.0;
			collection.addValue(floatDrag);
		}
		
		exposeBaseShapeConstructor(collection);
		
		return collection;
	}
	
	static public function exposePolygonShapeInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposePolygonShape(collection);
		collection.setVisibleAll(false);
		applyPolygonShapeInstance(collection);
		
		return collection;
	}
	
	static private function applyPolygonShapeInstance(collection:ExposedCollection):Void
	{
		applyBaseShapeInstance(collection);
		collection.setVisibleArray([
			"angle",
			"numSides",
			"radius"
		], true);
	}
	
	static public function exposePolygonShapeTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposePolygonShape(collection);
		collection.setVisibleAll(false);
		applyPolygonShapeTemplate(collection);
		
		return collection;
	}
	
	static private function applyPolygonShapeTemplate(collection:ExposedCollection):Void
	{
		applyBaseShapeTemplate(collection);
		collection.setVisibleArray([
		], true);
	}
	
	static public function exposeRectangleShape(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("rectangleWidth"))
		{
			floatDrag = new ExposedFloatDrag("rectangleWidth");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("rectangleHeight"))
		{
			floatDrag = new ExposedFloatDrag("rectangleHeight");
			collection.addValue(floatDrag);
		}
		
		exposeBaseShape(collection);
		
		return collection;
	}
	
	static public function exposeRectangleShapeConstructor(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("rectangleWidth"))
		{
			floatDrag = new ExposedFloatDrag("rectangleWidth");
			floatDrag.defaultValue = 100.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("rectangleHeight"))
		{
			floatDrag = new ExposedFloatDrag("rectangleHeight");
			floatDrag.defaultValue = 100.0;
			collection.addValue(floatDrag);
		}
		
		exposeBaseShapeConstructor(collection);
		
		return collection;
	}
	
	static public function exposeRectangleShapeInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeRectangleShape(collection);
		collection.setVisibleAll(false);
		applyRectangleShapeInstance(collection);
		
		return collection;
	}
	
	static private function applyRectangleShapeInstance(collection:ExposedCollection):Void
	{
		applyBaseShapeInstance(collection);
		collection.setVisibleArray([
			"rectangleWidth",
			"rectangleHeight"
		], true);
	}
	
	static public function exposeRectangleShapeTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeRectangleShape(collection);
		collection.setVisibleAll(false);
		applyRectangleShapeTemplate(collection);
		
		return collection;
	}
	
	static private function applyRectangleShapeTemplate(collection:ExposedCollection):Void
	{
		applyBaseShapeTemplate(collection);
		collection.setVisibleArray([
		], true);
	}
	
	static public function exposeRoundRectangleShape(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("rectangleWidth"))
		{
			floatDrag = new ExposedFloatDrag("rectangleWidth");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("rectangleHeight"))
		{
			floatDrag = new ExposedFloatDrag("rectangleHeight");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("roundWidth"))
		{
			floatDrag = new ExposedFloatDrag("roundWidth");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("roundHeight"))
		{
			floatDrag = new ExposedFloatDrag("roundHeight");
			collection.addValue(floatDrag);
		}
		
		exposeBaseShape(collection);
		
		return collection;
	}
	
	static public function exposeRoundRectangleShapeConstructor(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("rectangleWidth"))
		{
			floatDrag = new ExposedFloatDrag("rectangleWidth");
			floatDrag.defaultValue = 100.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("rectangleHeight"))
		{
			floatDrag = new ExposedFloatDrag("rectangleHeight");
			floatDrag.defaultValue = 100.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("roundWidth"))
		{
			floatDrag = new ExposedFloatDrag("roundWidth");
			floatDrag.defaultValue = 10.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("roundHeight"))
		{
			floatDrag = new ExposedFloatDrag("roundHeight");
			floatDrag.defaultValue = 10.0;
			collection.addValue(floatDrag);
		}
		
		exposeBaseShapeConstructor(collection);
		
		return collection;
	}
	
	static public function exposeRoundRectangleShapeInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeRoundRectangleShape(collection);
		collection.setVisibleAll(false);
		applyRoundRectangleShapeInstance(collection);
		
		return collection;
	}
	
	static private function applyRoundRectangleShapeInstance(collection:ExposedCollection):Void
	{
		applyBaseShapeInstance(collection);
		collection.setVisibleArray([
			"rectangleWidth",
			"rectangleHeight",
			"roundWidth",
			"roundHeight"
		], true);
	}
	
	static public function exposeRoundRectangleShapeTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeRoundRectangleShape(collection);
		collection.setVisibleAll(false);
		applyRoundRectangleShapeTemplate(collection);
		
		return collection;
	}
	
	static private function applyRoundRectangleShapeTemplate(collection:ExposedCollection):Void
	{
		applyBaseShapeTemplate(collection);
		collection.setVisibleArray([
		], true);
	}
	
	static public function exposeStarShape(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("numPoints"))
		{
			intDrag = new ExposedIntDrag("numPoints", null, 3, null, 0.5);
			collection.addValue(intDrag);
		}
		
		if (!collection.hasValue("innerRadius"))
		{
			floatDrag = new ExposedFloatDrag("innerRadius");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("outerRadius"))
		{
			floatDrag = new ExposedFloatDrag("outerRadius");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("angle"))
		{
			floatDrag = new ExposedFloatDrag("angle", null, -360, 360);
			collection.addValue(floatDrag);
		}
		
		exposeBaseShape(collection);
		
		return collection;
	}
	
	static public function exposeStarShapeConstructor(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("numPoints"))
		{
			intDrag = new ExposedIntDrag("numPoints", null, 3, null, 0.5);
			intDrag.defaultValue = 5;
			collection.addValue(intDrag);
		}
		
		if (!collection.hasValue("innerRadius"))
		{
			floatDrag = new ExposedFloatDrag("innerRadius");
			floatDrag.defaultValue = 25.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("outerRadius"))
		{
			floatDrag = new ExposedFloatDrag("outerRadius");
			floatDrag.defaultValue = 50.0;
			collection.addValue(floatDrag);
		}
		
		exposeBaseShapeConstructor(collection);
		
		return collection;
	}
	
	static public function exposeStarShapeInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeStarShape(collection);
		collection.setVisibleAll(false);
		applyStarShapeInstance(collection);
		
		return collection;
	}
	
	static private function applyStarShapeInstance(collection:ExposedCollection):Void
	{
		applyBaseShapeInstance(collection);
		collection.setVisibleArray([
			"angle",
			"numPoints",
			"innerRadius",
			"outerRadius"
		], true);
	}
	
	static public function exposeStarShapeTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeStarShape(collection);
		collection.setVisibleAll(false);
		applyStarShapeTemplate(collection);
		
		return collection;
	}
	
	static private function applyStarShapeTemplate(collection:ExposedCollection):Void
	{
		applyBaseShapeTemplate(collection);
		collection.setVisibleArray([
		], true);
	}
	
	static public function exposeWedgeShape(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("arc"))
		{
			floatDrag = new ExposedFloatDrag("arc", null, -360.0, 360.0);
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("radiusX"))
		{
			floatDrag = new ExposedFloatDrag("radiusX");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("radiusY"))
		{
			floatDrag = new ExposedFloatDrag("radiusY");
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("startAngle"))
		{
			floatDrag = new ExposedFloatDrag("startAngle", null, -360.0, 360.0);
			collection.addValue(floatDrag);
		}
		
		exposeBaseShape(collection);
		
		return collection;
	}
	
	static public function exposeWedgeShapeConstructor(?collection:ExposedCollection):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("arc"))
		{
			floatDrag = new ExposedFloatDrag("arc", null, -360.0, 360.0);
			floatDrag.defaultValue = 90.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("radiusX"))
		{
			floatDrag = new ExposedFloatDrag("radiusX");
			floatDrag.defaultValue = 50.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("radiusY"))
		{
			floatDrag = new ExposedFloatDrag("radiusY");
			floatDrag.defaultValue = 50.0;
			collection.addValue(floatDrag);
		}
		
		if (!collection.hasValue("startAngle"))
		{
			floatDrag = new ExposedFloatDrag("startAngle", null, -360.0, 360.0);
			floatDrag.defaultValue = 0.0;
			collection.addValue(floatDrag);
		}
		
		exposeBaseShapeConstructor(collection);
		
		return collection;
	}
	
	static public function exposeWedgeShapeInstance(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeWedgeShape(collection);
		collection.setVisibleAll(false);
		applyWedgeShapeInstance(collection);
		
		return collection;
	}
	
	static private function applyWedgeShapeInstance(collection:ExposedCollection):Void
	{
		applyBaseShapeInstance(collection);
		collection.setVisibleArray([
			"arc",
			"radiusX",
			"radiusY",
			"startAngle"
		], true);
	}
	
	static public function exposeWedgeShapeTemplate(?collection:ExposedCollection):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		exposeWedgeShape(collection);
		collection.setVisibleAll(false);
		applyWedgeShapeTemplate(collection);
		
		return collection;
	}
	
	static private function applyWedgeShapeTemplate(collection:ExposedCollection):Void
	{
		applyBaseShapeTemplate(collection);
		collection.setVisibleArray([
		], true);
	}
	
}