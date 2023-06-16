package valedit.data.starling.animation;
import valedit.ExposedCollection;
import valedit.value.ExposedFloatDrag;

/**
 * ...
 * @author Matse
 */
class StarlingAnimationData 
{

	static public function exposeJuggler(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("timeScale"))
		{
			floatDrag = new ExposedFloatDrag("timeScale", null, null, null, 0.25);
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
}