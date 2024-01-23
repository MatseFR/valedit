package valedit;
import openfl.events.EventDispatcher;
import valedit.utils.PropertyMap;
import valedit.utils.ReverseIterator;

/**
 * ...
 * @author Matse
 */
class ValEditObject extends EventDispatcher
{
	static private var _POOL:Array<ValEditObject> = new Array<ValEditObject>();
	
	static public function fromPool(clss:ValEditClass, ?id:String):ValEditObject
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(clss, id);
		return new ValEditObject(clss, id);
	}
	
	public var className:String;
	public var clss:ValEditClass;
	public var currentCollection(default, null):ExposedCollection;
	public var currentKeyFrame(default, null):ValEditKeyFrame;
	public var defaultCollection(get, set):ExposedCollection;
	public var displayObjectType:Int;
	public var id(get, set):String;
	public var isDisplayObject:Bool;
	public var numKeyFrames(default, null):Int = 0;
	public var object:Dynamic;
	public var propertyMap:PropertyMap;
	public var template:ValEditTemplate;
	
	private var _defaultCollection:ExposedCollection;
	private function get_defaultCollection():ExposedCollection { return this._defaultCollection; }
	private function set_defaultCollection(value:ExposedCollection):ExposedCollection
	{
		if (this.currentCollection == null)
		{
			this.currentCollection = value;
		}
		return this._defaultCollection = value;
	}
	
	private var _id:String;
	private function get_id():String { return this._id; }
	private function set_id(value:String):String
	{
		return this._id = value;
	}
	
	private var _keyFrames:Array<ValEditKeyFrame> = new Array<ValEditKeyFrame>();
	private var _keyFrameToCollection:Map<ValEditKeyFrame, ExposedCollection> = new Map<ValEditKeyFrame, ExposedCollection>();
	
	private var _realPropertyName:String;
	private var _regularPropertyName:String;
	
	public function new(clss:ValEditClass, ?id:String)
	{
		super();
		
		setTo(clss, id);
	}
	
	public function clear():Void
	{
		//for (keyFrame in this._keyFrameToCollection.keys())
		//{
			//keyFrame.remove(this);
		//}
		for (i in new ReverseIterator(this._keyFrames.length - 1, 0))
		{
			this._keyFrames[i].remove(this);
		}
		
		this.clss = null;
		this.currentCollection = null;
		if (this._defaultCollection != null)
		{
			this._defaultCollection.pool();
			this._defaultCollection = null;
		}
		this.numKeyFrames = 0;
		this.object = null;
		this.template = null;
		this.propertyMap = null;
		
		//for (collection in this._keyFrameToCollection)
		//{
			//collection.pool();
		//}
		//this._keyFrameToCollection.clear();
		
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	public function canBeDestroyed():Bool
	{
		return this.numKeyFrames == 0;
	}
	
	public function addKeyFrame(keyFrame:ValEditKeyFrame, collection:ExposedCollection = null):Void
	{
		if (collection == null)
		{
			collection = createCollectionForKeyFrame(keyFrame);
		}
		
		this._keyFrames[this._keyFrames.length] = keyFrame;
		this._keyFrameToCollection.set(keyFrame, collection);
		this.numKeyFrames++;
	}
	
	public function createCollectionForKeyFrame(keyFrame:ValEditKeyFrame):ExposedCollection
	{
		var collection:ExposedCollection = null;
		var previousFrame:ValEditKeyFrame = keyFrame.timeLine.getPreviousKeyFrame(keyFrame);
		if (previousFrame != null && this._keyFrameToCollection.exists(previousFrame))
		{
			collection = this._keyFrameToCollection.get(previousFrame).clone(true);
		}
		
		if (collection == null)
		{
			collection = this.clss.getCollection();
			collection.readValuesFromObject(this.object);
		}
		
		return collection;
	}
	
	public function getCollectionForKeyFrame(keyFrame:ValEditKeyFrame):ExposedCollection
	{
		return this._keyFrameToCollection.get(keyFrame);
	}
	
	public function hasKeyFrame(keyFrame:ValEditKeyFrame):Bool
	{
		return this._keyFrameToCollection.exists(keyFrame);
	}
	
	public function removeKeyFrame(keyFrame:ValEditKeyFrame, poolCollection:Bool = true):Void
	{
		if (poolCollection)
		{
			this._keyFrameToCollection.get(keyFrame).pool();
		}
		this._keyFrames.remove(keyFrame);
		this._keyFrameToCollection.remove(keyFrame);
		this.numKeyFrames--;
		
		if (this.currentKeyFrame == keyFrame)
		{
			setKeyFrame(null);
		}
	}
	
	public function setKeyFrame(keyFrame:ValEditKeyFrame):Void
	{
		if (this.currentKeyFrame == keyFrame) return;
		if (this.currentCollection != null) this.currentCollection.object = null;
		if (keyFrame == null)
		{
			this.currentCollection = null;
		}
		else
		{
			this.currentCollection = this._keyFrameToCollection.get(keyFrame);
		}
		this.currentKeyFrame = keyFrame;
		if (this.currentCollection != null)
		{
			this.currentCollection.applyAndSetObject(this.object);
		}
	}
	
	public function ready():Void
	{
		
	}
	
	public function getProperty(regularPropertyName:String):Dynamic
	{
		this._realPropertyName = this.propertyMap.getObjectPropertyName(regularPropertyName);
		if (this._realPropertyName == null) this._realPropertyName = regularPropertyName;
		return Reflect.getProperty(this.object, this._realPropertyName);
	}
	
	private function setTo(clss:ValEditClass, id:String):ValEditObject
	{
		this._id = id;
		this.clss = clss;
		this.className = clss.className;
		this.isDisplayObject = clss.isDisplayObject;
		this.displayObjectType = clss.displayObjectType;
		
		return this;
	}
	
	public function loadComplete():Void
	{
		if (this.defaultCollection != null)
		{
			this.defaultCollection.loadComplete();
		}
		
		for (collection in this._keyFrameToCollection)
		{
			collection.loadComplete();
		}
	}
	
}