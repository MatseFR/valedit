package valedit.data.openfl.filters;
import valedit.ExposedCollection;
import valedit.value.ExposedFloatRange;
import valedit.value.ExposedFunction;
import valedit.value.ExposedGroup;
import valedit.value.ExposedName;
import valedit.value.ExposedNote;
import valedit.value.ExposedSeparator;

/**
 * ...
 * @author Matse
 */
class ColorFilterHelperData 
{

	static public function exposeColorFilterHelper(collection:ExposedCollection = null):ExposedCollection
	{
		var floatRange:ExposedFloatRange;
		var func:ExposedFunction;
		var name:ExposedName;
		var note:ExposedNote;
		var sep:ExposedSeparator;
		var group:ExposedGroup;
		
		if (collection == null) collection = new ExposedCollection();
		
		group = new ExposedGroup("ColorFilterHelper properties");
		collection.addValue(group);
		
		floatRange = new ExposedFloatRange("brightness", null, -1, 1, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("saturation", null, 0, 5, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("contrast", null, 0, 5, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("luminosity", null, 0, 5, 0.01, 2);
		group.addValue(floatRange);
		
		func = new ExposedFunction("resetSettings", "reset settings");
		group.addValue(func);
		
		note = new ExposedNote("", "warning : playing with channels values below is likely to alter how brightness / saturation / contrast / luminosity work\n\nThis should not stop you from playing with them though :)");
		group.addValue(note);
		
		sep = new ExposedSeparator();
		group.addValue(sep);
		
		name = new ExposedName("red channel");
		group.addValue(name);
		
		floatRange = new ExposedFloatRange("redRed", "red", -1, 2, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("redGreen", "green", -1, 2, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("redBlue", "blue", -1, 2, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("redAlpha", "alpha", -1, 2, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("redOffset", "offset", -255, 255, 1, 1);
		group.addValue(floatRange);
		
		sep = new ExposedSeparator();
		group.addValue(sep);
		
		name = new ExposedName("green channel");
		group.addValue(name);
		
		floatRange = new ExposedFloatRange("greenRed", "red", -1, 2, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("greenGreen", "green", -1, 2, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("greenBlue", "blue", -1, 2, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("greenAlpha", "alpha", -1, 2, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("greenOffset", "offset", -255, 255, 1, 1);
		group.addValue(floatRange);
		
		sep = new ExposedSeparator();
		group.addValue(sep);
		
		name = new ExposedName("blue channel");
		group.addValue(name);
		
		floatRange = new ExposedFloatRange("blueRed", "red", -1, 2, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("blueGreen", "green", -1, 2, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("blueBlue", "blue", -1, 2, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("blueAlpha", "alpha", -1, 2, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("blueOffset", "offset", -255, 255, 1, 1);
		group.addValue(floatRange);
		
		sep = new ExposedSeparator();
		group.addValue(sep);
		
		name = new ExposedName("alpha channel");
		group.addValue(name);
		
		floatRange = new ExposedFloatRange("alphaRed", "red", -1, 1, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("alphaGreen", "green", -1, 1, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("alphaBlue", "blue", -1, 1, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("alphaAlpha", "alpha", -1, 1, 0.01, 2);
		group.addValue(floatRange);
		floatRange = new ExposedFloatRange("alphaOffset", "offset", -255, 255, 1, 1);
		group.addValue(floatRange);
		
		return collection;
	}
	
}