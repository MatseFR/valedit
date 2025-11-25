package valedit.data.openfl.display3D;
import openfl.display3D.Context3DProfile;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedSelect;
import valedit.value.ExposedString;

/**
 * ...
 * @author Matse
 */
class OpenFLDisplay3DData 
{

	static public function exposeContext3D(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var intDrag:ExposedIntDrag;
		var select:ExposedSelect;
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("backBufferHeight"))
		{
			intDrag = new ExposedIntDrag("backBufferHeight");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("backBufferWidth"))
		{
			intDrag = new ExposedIntDrag("backBufferWidth");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("driverInfo"))
		{
			str = new ExposedString("driverInfo");
			str.isReadOnly = true;
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("enableErrorChecking"))
		{
			bool = new ExposedBool("enableErrorChecking");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("maxBackBufferHeight"))
		{
			intDrag = new ExposedIntDrag("maxBackBufferHeight");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("maxBackBufferWidth"))
		{
			intDrag = new ExposedIntDrag("maxBackBufferWidth");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
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
		
		if (!collection.hasValue("totalGPUMemory"))
		{
			intDrag = new ExposedIntDrag("totalGPUMemory");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		return collection;
	}
	
}