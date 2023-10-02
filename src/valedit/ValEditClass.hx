package valedit;
import flash.display.DisplayObjectContainer;
import haxe.Constraints.Function;
import haxe.ds.ObjectMap;
import valedit.utils.PropertyMap;
import valedit.value.base.ExposedValueWithChildren;
import valeditor.ValEditorObject;

/**
 * ...
 * @author Matse
 */
class ValEditClass 
{
	static private var _POOL:Array<ValEditClass> = new Array<ValEditClass>();
	
	static public function fromPool(classReference:Class<Dynamic>):ValEditClass
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(classReference);
		return new ValEditClass(classReference);
	}
	
	/** Dynamic->DisplayObjectContainer->Void */
	public var addToDisplayFunction:Function;
	public var addToDisplayFunctionName:String;
	public var className:String;
	public var classReference:Class<Dynamic>;
	public var constructorCollection:ExposedCollection;
	public var creationFunction:Function;
	/** Dynamic->Void external function reference, to be called on object creation */
	public var creationInitFunction:Function;
	/** Void->Void object function name, to be called on object creation */
	public var creationInitFunctionName:String;
	public var displayObjectType:Int = DisplayObjectType.NONE;
	/** Dynamic->Void external function reference, to be called on object destruction */
	public var disposeFunction:Function;
	/** Void->Void object function name, to be called on object destruction */
	public var disposeFunctionName:String = null;
	public var isDisplayObject:Bool;
	public var numInstances(default, null):Int = 0;
	public var numTemplates(default, null):Int = 0;
	public var objectCollection:ExposedCollection;
	public var propertyMap:PropertyMap;
	/** Dynamic->DisplayObjectContainer->Void */
	public var removeFromDisplayFunction:Function;
	public var removeFromDisplayFunctionName:String;
	public var superClassNames(default, null):Array<String> = new Array<String>();
	public var templateCollection:ExposedCollection;
	
	private var _IDToObject:Map<String, ValEditObject> = new Map<String, ValEditObject>();
	private var _objectIDIndex:Int = -1;
	
	private var _objectToValEditObject:ObjectMap<Dynamic, ValEditObject> = new ObjectMap<Dynamic, ValEditObject>();
	
	private var _IDToTemplate:Map<String, ValEditTemplate> = new Map<String, ValEditTemplate>();
	private var _templateIDIndex:Int = -1;
	
	private var _containers:Map<DisplayObjectContainer, ExposedCollection> = new Map<DisplayObjectContainer, ExposedCollection>();
	private var _pool:Array<ExposedCollection> = new Array<ExposedCollection>();
	
	private var _constructorContainers:Map<DisplayObjectContainer, ExposedCollection> = new Map<DisplayObjectContainer, ExposedCollection>();
	private var _constructorPool:Array<ExposedCollection> = new Array<ExposedCollection>();
	
	private var _templateContainers:Map<DisplayObjectContainer, ValEditTemplate> = new Map<DisplayObjectContainer, ValEditTemplate>();
	
	private var _collectionsToPool:Map<ExposedCollection, ExposedCollection> = new Map<ExposedCollection, ExposedCollection>();
	
	/**
	   
	**/
	public function new(classReference:Class<Dynamic>) 
	{
		this.classReference = classReference;
	}
	
	/**
	   
	**/
	public function clear():Void
	{
		this.addToDisplayFunction = null;
		this.addToDisplayFunctionName = null;
		this.className = null;
		this.classReference = null;
		if (this.constructorCollection != null)
		{
			this.constructorCollection.pool();
			this.constructorCollection = null;
		}
		this.creationFunction = null;
		this.creationInitFunction = null;
		this.creationInitFunctionName = null;
		this.displayObjectType = DisplayObjectType.NONE;
		this.disposeFunction = null;
		this.disposeFunctionName = null;
		this.isDisplayObject = false;
		this.numInstances = 0;
		this.numTemplates = 0;
		if (this.objectCollection != null)
		{
			this.objectCollection.pool();
			this.objectCollection = null;
		}
		if (this.propertyMap != null)
		{
			this.propertyMap.pool();
			this.propertyMap = null;
		}
		this.removeFromDisplayFunction = null;
		this.removeFromDisplayFunctionName = null;
		this.superClassNames.resize(0);
		if (this.templateCollection != null)
		{
			this.templateCollection.pool();
			this.templateCollection = null;
		}
		
		this._IDToObject.clear();
		this._objectIDIndex = -1;
		this._objectToValEditObject.clear();
		this._IDToTemplate.clear();
		this._templateIDIndex = -1;
		
		this._containers.clear();
		for (collection in this._pool)
		{
			collection.pool();
		}
		this._pool.resize(0);
		
		this._constructorContainers.clear();
		for (collection in this._constructorPool)
		{
			collection.pool();
		}
		this._constructorPool.resize(0);
		
		this._templateContainers.clear();
		for (collection in this._collectionsToPool)
		{
			collection.pool();
		}
		this._collectionsToPool.clear();
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(classReference:Class<Dynamic> = null, className:String = null, objectCollection:ExposedCollection = null,
						   isDisplayObject:Bool = false, constructorCollection:ExposedCollection = null, templateCollection:ExposedCollection = null):ValEditClass
	{
		this.classReference = classReference;
		this.className = className;
		this.objectCollection = objectCollection;
		this.isDisplayObject = isDisplayObject;
		this.constructorCollection = constructorCollection;
		this.templateCollection = templateCollection;
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
			collection = this.objectCollection.clone();
		}
		return collection;
	}
	
	public function getTemplateCollection():ExposedCollection
	{
		if (this.templateCollection != null)
		{
			return this.templateCollection.clone();
		}
		else
		{
			return getCollection();
		}
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
		this.numInstances++;
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
		this.numInstances--;
	}
	
	public function removeObjectByID(id:String):Void
	{
		var object:ValEditObject = this._IDToObject.get(id);
		this._IDToObject.remove(id);
		this._objectToValEditObject.remove(object.object);
		this.numInstances--;
	}
	
	public function makeTemplateID():String
	{
		var templateID:String = null;
		while (true)
		{
			this._templateIDIndex++;
			templateID = this.className + " template" + this._templateIDIndex;
			if (!this._IDToTemplate.exists(templateID)) break;
		}
		return templateID;
	}
	
	public function templateIDExists(id:String):Bool
	{
		return this._IDToTemplate.exists(id);
	}
	
	public function addTemplate(template:ValEditTemplate):Void
	{
		if (template.id == null) template.id = makeTemplateID();
		this._IDToTemplate.set(template.id, template);
		this.numTemplates++;
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
		this._IDToTemplate.remove(template.id);
		this.numTemplates--;
	}
	
	public function removeTemplateByID(id:String):Void
	{
		this._IDToTemplate.remove(id);
		this.numTemplates--;
	}
	
	public function addContainer(container:DisplayObjectContainer, object:Dynamic, collection:ExposedCollection = null, parentValue:ExposedValueWithChildren = null):ExposedCollection
	{
		if (collection == null)
		{
			if (this._pool.length != 0) 
			{
				collection = this._pool.pop();
			}
			else
			{
				collection = this.objectCollection.clone();
			}
			this._collectionsToPool.set(collection, collection);
			if (Std.isOfType(object, ValEditorObject))
			{
				collection.readAndSetObject(cast(object, ValEditorObject).object);
			}
			else
			{
				collection.readAndSetObject(object);
			}
		}
		this._containers[container] = collection;
		collection.parentValue = parentValue;
		//collection.readAndSetObject(object);
		collection.uiContainer = container;
		
		return collection;
	}
	
	public function addConstructorContainer(container:DisplayObjectContainer):ExposedCollection
	{
		var collection:ExposedCollection;
		if (this._constructorPool.length != 0)
		{
			collection = this._constructorPool.pop();
		}
		else
		{
			collection = this.constructorCollection.clone();
		}
		
		this._constructorContainers[container] = collection;
		collection.uiContainer = container;
		
		return collection;
	}
	
	public function addTemplateContainer(container:DisplayObjectContainer, template:ValEditTemplate):Void
	{
		this._templateContainers[container] = template;
		template.collection.uiContainer = container;
	}
	
	public function removeContainer(container:DisplayObjectContainer):Void
	{
		var collection:ExposedCollection = this._containers[container];
		if (collection != null)
		{
			this._containers.remove(container);
			collection.parentValue = null;
			collection.uiContainer = null;
			if (this._collectionsToPool.exists(collection))
			{
				collection.object = null;
				this._collectionsToPool.remove(collection);
				this._pool.push(collection);
			}
			return;
		}
		
		if (this._constructorContainers.exists(container))
		{
			removeConstructorContainer(container);
			return;
		}
		
		if (this._templateContainers.exists(container))
		{
			removeTemplateContainer(container);
			return;
		}
	}
	
	public function removeConstructorContainer(container:DisplayObjectContainer):Void
	{
		var collection:ExposedCollection = this._constructorContainers[container];
		if (collection != null)
		{
			this._constructorContainers.remove(container);
			collection.uiContainer = null;
			this._constructorPool.push(collection);
		}
	}
	
	public function removeTemplateContainer(container:DisplayObjectContainer):Void
	{
		var template:ValEditTemplate = this._templateContainers[container];
		if (template != null)
		{
			this._templateContainers.remove(container);
			template.collection.uiContainer = null;
		}
	}
	
}