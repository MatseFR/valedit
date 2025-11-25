package valedit.data.openfl.media;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObject;
import valedit.value.ExposedString;
import valedit.value.ExposedText;

/**
 * ...
 * @author Matse
 */
class OpenFLMediaData 
{

	static public function exposeID3Info(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var str:ExposedString;
		var txt:ExposedText;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("artist"))
		{
			str = new ExposedString("artist");
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("album"))
		{
			str = new ExposedString("album");
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("year"))
		{
			str = new ExposedString("year");
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("genre"))
		{
			str = new ExposedString("genre");
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("songName"))
		{
			str = new ExposedString("songName");
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("track"))
		{
			str = new ExposedString("track");
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("comment"))
		{
			txt = new ExposedText("comment");
			collection.addValue(txt, groupName);
		}
		
		return collection;
	}
	
	static public function exposeSound(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		var obj:ExposedObject;
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("bytesLoaded"))
		{
			intDrag = new ExposedIntDrag("bytesLoaded");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("bytesTotal"))
		{
			intDrag = new ExposedIntDrag("bytesTotal");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("id3"))
		{
			obj = new ExposedObject("id3");
			collection.addValue(obj, groupName);
		}
		
		if (!collection.hasValue("isBuffering"))
		{
			bool = new ExposedBool("isBuffering");
			bool.isReadOnly = true;
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("length"))
		{
			floatDrag = new ExposedFloatDrag("length");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		#if html5
		if (!collection.hasValue("sampleRate"))
		{
			intDrag = new ExposedIntDrag("sampleRate");
			intDrag.isReadOnly = true;
			collection.addValue(intDrag, groupName);
		}
		#end
		
		if (!collection.hasValue("url"))
		{
			str = new ExposedString("url");
			str.isReadOnly = true;
			collection.addValue(str, groupName);
		}
		
		return collection;
	}
	
	static public function exposeSoundChannel(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var obj:ExposedObject;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("position"))
		{
			floatDrag = new ExposedFloatDrag("position");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("leftPeak"))
		{
			floatDrag = new ExposedFloatDrag("leftPeak");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("rightPeak"))
		{
			floatDrag = new ExposedFloatDrag("rightPeak");
			floatDrag.isReadOnly = true;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("soundTransform"))
		{
			obj = new ExposedObject("soundTransform");
			collection.addValue(obj, groupName);
		}
		
		return collection;
	}
	
	static public function exposeSoundLoaderContext(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("bufferTime"))
		{
			floatDrag = new ExposedFloatDrag("bufferTime");
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("checkPolicyFile"))
		{
			bool = new ExposedBool("checkPolicyFile");
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeSoundLoaderContextConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("bufferTime"))
		{
			floatDrag = new ExposedFloatDrag("bufferTime");
			floatDrag.defaultValue = 1000.0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("checkPolicyFile"))
		{
			bool = new ExposedBool("checkPolicyFile");
			bool.defaultValue = false;
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeSoundTransform(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("leftToLeft"))
		{
			floatDrag = new ExposedFloatDrag("leftToLeft", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("leftToRight"))
		{
			floatDrag = new ExposedFloatDrag("leftToRight", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("pan"))
		{
			floatDrag = new ExposedFloatDrag("pan", null, -1.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("rightToLeft"))
		{
			floatDrag = new ExposedFloatDrag("rightToLeft", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("rightToRight"))
		{
			floatDrag = new ExposedFloatDrag("rightToRight", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("volume"))
		{
			floatDrag = new ExposedFloatDrag("volume", null, 0.0, 1.0, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
	static public function exposeSoundTransformConstructor(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null)
		{
			collection = new ExposedCollection();
			collection.isConstructor = true;
		}
		
		if (!collection.hasValue("volume"))
		{
			floatDrag = new ExposedFloatDrag("volume", null, 0.0, 1.0, 0.01);
			floatDrag.defaultValue = 1.0;
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("panning"))
		{
			floatDrag = new ExposedFloatDrag("panning", null, -1.0, 1.0, 0.01);
			floatDrag.defaultValue = 0.0;
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
}