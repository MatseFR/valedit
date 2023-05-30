package valedit.data.starling.animation;
import valedit.ExposedCollection;
import valedit.value.ExposedFloat;

/**
 * ...
 * @author Matse
 */
class StarlingAnimationData 
{

	static public function exposeJuggler(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var float:ExposedFloat;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("timeScale"))
		{
			float = new ExposedFloat("timeScale");
			collection.addValue(float, groupName);
		}
		
		return collection;
	}
	
}