package valedit.data.openfl.filters;
import valedit.ExposedCollection;
import valedit.value.ExposedFloatRange;
import valedit.value.ExposedFunction;
import valedit.value.ExposedName;
import valedit.value.ExposedNote;
import valedit.value.ExposedSeparator;

/**
 * ...
 * @author Matse
 */
class ColorFilterHelperData 
{

	static public function exposeColorFilterHelper(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatRange:ExposedFloatRange;
		var func:ExposedFunction;
		var name:ExposedName;
		var note:ExposedNote;
		var sep:ExposedSeparator;
		
		if (collection == null) collection = new ExposedCollection();
		
		floatRange = new ExposedFloatRange("brightness", null, -1, 1, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("saturation", null, 0, 5, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("contrast", null, 0, 5, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("luminosity", null, 0, 5, 0.01, 2);
		collection.addValue(floatRange, groupName);
		
		func = new ExposedFunction("resetSettings", "reset settings");
		collection.addValue(func, groupName);
		
		note = new ExposedNote("", "warning : playing with channels values below is likely to alter how brightness / saturation / contrast / luminosity work\n\nThis should not stop you from playing with them though :)");
		collection.addValue(note, groupName);
		
		sep = new ExposedSeparator();
		collection.addValue(sep, groupName);
		
		name = new ExposedName("red channel");
		collection.addValue(name, groupName);
		
		floatRange = new ExposedFloatRange("redRed", "red", -1, 2, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("redGreen", "green", -1, 2, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("redBlue", "blue", -1, 2, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("redAlpha", "alpha", -1, 2, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("redOffset", "offset", -255, 255, 1, 1);
		collection.addValue(floatRange, groupName);
		
		sep = new ExposedSeparator();
		collection.addValue(sep, groupName);
		
		name = new ExposedName("green channel");
		collection.addValue(name, groupName);
		
		floatRange = new ExposedFloatRange("greenRed", "red", -1, 2, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("greenGreen", "green", -1, 2, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("greenBlue", "blue", -1, 2, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("greenAlpha", "alpha", -1, 2, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("greenOffset", "offset", -255, 255, 1, 1);
		collection.addValue(floatRange, groupName);
		
		sep = new ExposedSeparator();
		collection.addValue(sep, groupName);
		
		name = new ExposedName("blue channel");
		collection.addValue(name, groupName);
		
		floatRange = new ExposedFloatRange("blueRed", "red", -1, 2, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("blueGreen", "green", -1, 2, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("blueBlue", "blue", -1, 2, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("blueAlpha", "alpha", -1, 2, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("blueOffset", "offset", -255, 255, 1, 1);
		collection.addValue(floatRange, groupName);
		
		sep = new ExposedSeparator();
		collection.addValue(sep, groupName);
		
		name = new ExposedName("alpha channel");
		collection.addValue(name, groupName);
		
		floatRange = new ExposedFloatRange("alphaRed", "red", -1, 1, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("alphaGreen", "green", -1, 1, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("alphaBlue", "blue", -1, 1, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("alphaAlpha", "alpha", -1, 1, 0.01, 2);
		collection.addValue(floatRange, groupName);
		floatRange = new ExposedFloatRange("alphaOffset", "offset", -255, 255, 1, 1);
		collection.addValue(floatRange, groupName);
		
		return collection;
	}
	
}