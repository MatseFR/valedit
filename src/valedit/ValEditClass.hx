package valedit;
import haxe.Constraints.Function;
import haxe.ds.ObjectMap;
import openfl.events.EventDispatcher;
import valedit.utils.PropertyMap;

/**
 * ...
 * @author Matse
 */
class ValEditClass extends EventDispatcher
{
	static private var _POOL:Array<ValEditClass> = new Array<ValEditClass>();
	
	static public function fromPool(classReference:Class<Dynamic>, className:String, collection:ExposedCollection, constructorCollection:ExposedCollection = null):ValEditClass
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(classReference, className, collection, constructorCollection);
		return new ValEditClass(classReference, className, collection, constructorCollection);
	}
	
	/** Dynamic->DisplayObjectContainer->Void */
	public var addToDisplayFunction:Function;
	public var addToDisplayFunctionName:String;
	public var className:String;
	public var classReference:Class<Dynamic>;
	public var cloneFromFunctionName:String;
	public var cloneToFunctionName:String;
	public var collection:ExposedCollection;
	public var constructorCollection:ExposedCollection;
	public var creationFunction:Function;
	public var creationFunctionForLoading:Function;
	public var creationFunctionForTemplateInstance:Function;
	/** Dynamic->Void external function reference, to be called on object creation */
	public var creationInitFunction:Function;
	/** Void->Void object function name, to be called on object creation */
	public var creationInitFunctionName:String;
	public var displayObjectType:Int = DisplayObjectType.NONE;
	/** Dynamic->Void external function reference, to be called on object destruction */
	public var disposeFunction:Function;
	/** Void->Void object function name, to be called on object destruction */
	public var disposeFunctionName:String = null;
	public var isContainer:Bool;
	public var isDisplayObject:Bool;
	public var numInstances(get, never):Int;
	public var numTemplates(get, never):Int;
	public var propertyMap:PropertyMap;
	/** Dynamic->DisplayObjectContainer->Void */
	public var removeFromDisplayFunction:Function;
	public var removeFromDisplayFunctionName:String;
	public var superClassNames(default, null):Array<String> = new Array<String>();
	
	private function get_numInstances():Int { return this._numObjects; }
	private function get_numTemplates():Int { return this._numTemplates; }
	
	private var _IDToObject:Map<String, ValEditObject> = new Map<String, ValEditObject>();
	private var _numObjects:Int = 0;
	private var _objectIDIndex:Int = -1;
	private var _objectToValEditObject:ObjectMap<Dynamic, ValEditObject> = new ObjectMap<Dynamic, ValEditObject>();
	
	private var _IDToTemplate:Map<String, ValEditTemplate> = new Map<String, ValEditTemplate>();
	private var _numTemplates:Int = 0;
	private var _templateIDIndex:Int = -1;
	
	private var _pool:Array<ExposedCollection> = new Array<ExposedCollection>();
	
	private var _constructorPool:Array<ExposedCollection> = new Array<ExposedCollection>();
	
	/**
	   
	**/
	public function new(classReference:Class<Dynamic>, className:String, collection:ExposedCollection, constructorCollection:ExposedCollection = null) 
	{
		super();
		this.classReference = classReference;
		this.className = className;
		this.collection = collection;
		this.constructorCollection = constructorCollection;
	}
	
	/**
	   
	**/
	public function clear():Void
	{
		this.addToDisplayFunction = null;
		this.addToDisplayFunctionName = null;
		this.className = null;
		this.classReference = null;
		this.cloneFromFunctionName = null;
		this.cloneToFunctionName = null;
		if (this.collection != null)
		{
			this.collection.pool();
			this.collection = null;
		}
		if (this.constructorCollection != null)
		{
			this.constructorCollection.pool();
			this.constructorCollection = null;
		}
		this.creationFunction = null;
		this.creationFunctionForLoading = null;
		this.creationFunctionForTemplateInstance = null;
		this.creationInitFunction = null;
		this.creationInitFunctionName = null;
		this.displayObjectType = DisplayObjectType.NONE;
		this.disposeFunction = null;
		this.disposeFunctionName = null;
		this.isContainer = false;
		this.isDisplayObject = false;
		this._numObjects = 0;
		this._numTemplates = 0;
		
		if (this.propertyMap != null)
		{
			this.propertyMap.pool();
			this.propertyMap = null;
		}
		this.removeFromDisplayFunction = null;
		this.removeFromDisplayFunctionName = null;
		this.superClassNames.resize(0);
		
		this._IDToObject.clear();
		this._objectIDIndex = -1;
		this._objectToValEditObject.clear();
		this._IDToTemplate.clear();
		this._templateIDIndex = -1;
		
		for (collection in this._pool)
		{
			collection.pool();
		}
		this._pool.resize(0);
		
		for (collection in this._constructorPool)
		{
			collection.pool();
		}
		this._constructorPool.resize(0);
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(classReference:Class<Dynamic>, className:String, collection:ExposedCollection, constructorCollection:ExposedCollection):ValEditClass
	{
		this.classReference = classReference;
		this.className = className;
		this.collection = collection;
		this.constructorCollection = constructorCollection;
		return this;
	}
	
	public function addSuperClassName(superClassName:String):Void
	{
		this.superClassNames.push(superClassName);
	}
	
	public function getCollection():ExposedCollection
	{
		var collection:ExposedCollection;
		if (this._pool.length != 0)
		{
			collection = this._pool.pop();
		}
		else
		{
			collection = this.collection.clone();
		}
		return collection;
	}
	
	public function makeObjectID():String
	{
		var objID:String = null;
		while (true)
		{
			this._objectIDIndex++;
			objID = this.className + this._objectIDIndex;
			if (!this._IDToObject.exists(objID)) break;
		}
		return objID;
	}
	
	public function objectIDExists(name:String):Bool
	{
		return this._IDToObject.exists(name);
	}
	
	public function addObject(object:ValEditObject):Void
	{
		if (object.id == null) object.id = makeObjectID();
		this._IDToObject.set(object.id, object);
		this._objectToValEditObject.set(object.object, object);
		this._numObjects++;
	}
	
	public function getObjectByID(id:String):ValEditObject
	{
		return this._IDToObject.get(id);
	}
	
	public function getObjectList(?objList:Array<ValEditObject>):Array<ValEditObject>
	{
		if (objList == null) objList = new Array<ValEditObject>();
		
		for (obj in this._IDToObject)
		{
			objList.push(obj);
		}
		
		return objList;
	}
	
	public function getValEditObjectFromObject(object:Dynamic):ValEditObject
	{
		return this._objectToValEditObject.get(object);
	}
	
	public function removeObject(object:ValEditObject):Void
	{
		this._IDToObject.remove(object.id);
		this._objectToValEditObject.remove(object.object);
		this._numObjects--;
	}
	
	public function removeObjectByID(id:String):Void
	{
		var object:ValEditObject = this._IDToObject.get(id);
		this._IDToObject.remove(id);
		this._objectToValEditObject.remove(object.object);
		this._numObjects--;
	}
	
	public function templateIDExists(id:String):Bool
	{
		return this._IDToTemplate.exists(id);
	}
	
	public function addTemplate(template:ValEditTemplate):Void
	{
		this._IDToTemplate.set(template.id, template);
		this._numTemplates++;
	}
	
	public function getTemplateByID(id:String):ValEditTemplate
	{
		return this._IDToTemplate.get(id);
	}
	
	public function getTemplateList(?templateList:Array<ValEditTemplate>):Array<ValEditTemplate>
	{
		if (templateList == null) templateList = new Array<ValEditTemplate>();
		
		for (template in _IDToTemplate)
		{
			templateList.push(template);
		}
		
		return templateList;
	}
	
	public function removeTemplate(template:ValEditTemplate):Void
	{
		if (this._IDToTemplate.remove(template.id))
		{
			this._numTemplates--;
		}
	}
	
	public function removeTemplateByID(id:String):Void
	{
		if (this._IDToTemplate.remove(id))
		{
			this._numTemplates--;
		}
	}
	
	public function loadComplete():Void
	{
		
	}
	
}