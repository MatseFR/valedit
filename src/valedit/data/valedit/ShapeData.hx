package valedit.data.valedit;
import valedit.ExposedCollection;
import valedit.data.openfl.display.DisplayData;
import valedit.value.ExposedBitmapData;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObject;
import valeditor.editor.visibility.ClassValueVisibility;
import valeditor.editor.visibility.ClassVisibilityCollection;

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
			collection.useActions = false;
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
	
	static public function getBaseShapeVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		DisplayData.getDisplayObjectVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("fill"));
		collection.add(ClassValueVisibility.fromPool("fillAlpha"));
		collection.add(ClassValueVisibility.fromPool("fillColor"));
		collection.add(ClassValueVisibility.fromPool("fillBitmapData"));
		collection.add(ClassValueVisibility.fromPool("fillRepeat"));
		collection.add(ClassValueVisibility.fromPool("fillSmoothing"));
		collection.add(ClassValueVisibility.fromPool("fillMatrix"));
		collection.add(ClassValueVisibility.fromPool("outline"));
		collection.add(ClassValueVisibility.fromPool("outlineThickness"));
		collection.add(ClassValueVisibility.fromPool("outlineAlpha"));
		collection.add(ClassValueVisibility.fromPool("outlineColor"));
		collection.add(ClassValueVisibility.fromPool("outlineBitmapData"));
		collection.add(ClassValueVisibility.fromPool("outlineRepeat"));
		collection.add(ClassValueVisibility.fromPool("outlineSmoothing"));
		collection.add(ClassValueVisibility.fromPool("outlineMatrix"));
		collection.add(ClassValueVisibility.fromPool("pivotX"));
		collection.add(ClassValueVisibility.fromPool("pivotY"));
		
		return collection;
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
			collection.useActions = false;
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
	
	static public function getArcShapeVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getBaseShapeVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("arc"));
		collection.add(ClassValueVisibility.fromPool("radiusX"));
		collection.add(ClassValueVisibility.fromPool("radiusY"));
		collection.add(ClassValueVisibility.fromPool("startAngle"));
		
		return collection;
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
			collection.useActions = false;
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
	
	static public function getArrowShapeVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getBaseShapeVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("arrowLength"));
		collection.add(ClassValueVisibility.fromPool("arrowHeight"));
		collection.add(ClassValueVisibility.fromPool("tail"));
		collection.add(ClassValueVisibility.fromPool("tailLength"));
		collection.add(ClassValueVisibility.fromPool("tailHeight"));
		
		return collection;
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
			collection.useActions = false;
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
	
	static public function getBurstShapeVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getBaseShapeVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("angle"));
		collection.add(ClassValueVisibility.fromPool("innerRadius"));
		collection.add(ClassValueVisibility.fromPool("numSides"));
		collection.add(ClassValueVisibility.fromPool("outerRadius"));
		
		return collection;
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
			collection.useActions = false;
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
	
	static public function getCircleShapeVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getBaseShapeVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("radius"));
		
		return collection;
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
			collection.useActions = false;
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
	
	static public function getDonutShapeVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getBaseShapeVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("radius"));
		collection.add(ClassValueVisibility.fromPool("holeRadius"));
		
		return collection;
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
			collection.useActions = false;
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
	
	static public function getEllipseShapeVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getBaseShapeVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("radiusX"));
		collection.add(ClassValueVisibility.fromPool("radiusY"));
		
		return collection;
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
			collection.useActions = false;
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
	
	static public function getFlowerShapeVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getBaseShapeVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("angle"));
		collection.add(ClassValueVisibility.fromPool("innerRadius"));
		collection.add(ClassValueVisibility.fromPool("numSides"));
		collection.add(ClassValueVisibility.fromPool("outerRadius"));
		
		return collection;
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
			collection.useActions = false;
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
	
	static public function getGearShapeVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getBaseShapeVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("angle"));
		collection.add(ClassValueVisibility.fromPool("hole"));
		collection.add(ClassValueVisibility.fromPool("holeRadius"));
		collection.add(ClassValueVisibility.fromPool("innerRadius"));
		collection.add(ClassValueVisibility.fromPool("numHoleSides"));
		collection.add(ClassValueVisibility.fromPool("numSides"));
		collection.add(ClassValueVisibility.fromPool("outerRadius"));
		
		return collection;
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
			collection.useActions = false;
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
	
	static public function getPolygonShapeVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getBaseShapeVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("angle"));
		collection.add(ClassValueVisibility.fromPool("numSides"));
		collection.add(ClassValueVisibility.fromPool("radius"));
		
		return collection;
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
			collection.useActions = false;
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
	
	static public function getRectangleShapeVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getBaseShapeVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("rectangleWidth"));
		collection.add(ClassValueVisibility.fromPool("rectangleHeight"));
		
		return collection;
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
			collection.useActions = false;
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
	
	static public function getRoundRectangleShapeVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getBaseShapeVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("rectangleWidth"));
		collection.add(ClassValueVisibility.fromPool("rectangleHeight"));
		collection.add(ClassValueVisibility.fromPool("roundWidth"));
		collection.add(ClassValueVisibility.fromPool("roundHeight"));
		
		return collection;
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
			collection.useActions = false;
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
	
	static public function getStarShapeVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getBaseShapeVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("angle"));
		collection.add(ClassValueVisibility.fromPool("numPoints"));
		collection.add(ClassValueVisibility.fromPool("innerRadius"));
		collection.add(ClassValueVisibility.fromPool("outerRadius"));
		
		return collection;
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
			collection.useActions = false;
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
	
	static public function getWedgeShapeVisibility(?collection:ClassVisibilityCollection):ClassVisibilityCollection
	{
		if (collection == null) collection = ClassVisibilityCollection.fromPool();
		
		getBaseShapeVisibility(collection);
		collection.add(ClassValueVisibility.fromPool("arc"));
		collection.add(ClassValueVisibility.fromPool("radiusX"));
		collection.add(ClassValueVisibility.fromPool("radiusY"));
		collection.add(ClassValueVisibility.fromPool("startAngle"));
		
		return collection;
	}
	
}