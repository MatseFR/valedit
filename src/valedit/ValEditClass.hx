package valedit;
import flash.display.DisplayObjectContainer;
import haxe.Constraints.Function;
import valedit.utils.PropertyMap;
import valedit.value.base.ExposedValueWithChildren;

/**
 * ...
 * @author Matse
 */
class ValEditClass 
{
	/** Dynamic->DisplayObjectContainer->Void */
	public var addToDisplayCustom:Function;
	public var canBeCreated:Bool;
	public var categories(default, null):Array<String> = new Array<String>();
	public var className:String;
	public var classReference:Class<Dynamic>;
	public var constructorCollection:ExposedCollection;
	public var displayObjectType:Int = DisplayObjectType.NONE;
	/** Dynamic->Void */
	public var disposeCustom:Function;
	/** if object has a function that should be called when being destroyed, the function's name should go here */
	public var disposeFunctionName:String = null;
	public var isDisplayObject:Bool;
	public var numInstances(default, null):Int = 0;
	public var numTemplates(default, null):Int = 0;
	public var propertyMap:PropertyMap;
	/** Dynamic->DisplayObjectContainer->Void */
	public var removeFromDisplayCustom:Function;
	public var sourceCollection:ExposedCollection;
	public var superClassNames(default, null):Array<String> = new Array<String>();
	
	private var _IDToObject:Map<String, ValEditObject> = new Map<String, ValEditObject>();
	private var _objectIDIndex:Int = -1;
	
	private var _IDToTemplate:Map<String, ValEditTemplate> = new Map<String, ValEditTemplate>();
	private var _templateIDIndex:Int = -1;
	
	private var _containers:Map<DisplayObjectContainer, ExposedCollection> = new Map<DisplayObjectContainer, ExposedCollection>();
	private var _pool:Array<ExposedCollection> = new Array<ExposedCollection>();
	
	private var _constructorContainers:Map<DisplayObjectContainer, ExposedCollection> = new Map<DisplayObjectContainer, ExposedCollection>();
	private var _constructorPool:Array<ExposedCollection> = new Array<ExposedCollection>();
	
	private var _templateContainers:Map<DisplayObjectContainer, ValEditTemplate> = new Map<DisplayObjectContainer, ValEditTemplate>();
	
	/**
	   
	**/
	public function new(?classReference:Class<Dynamic>, ?className:String, ?sourceCollection:ExposedCollection, canBeCreated:Bool = true, isDisplayObject:Bool = false, ?constructorCollection:ExposedCollection) 
	{
		this.classReference = classReference;
		this.className = className;
		this.sourceCollection = sourceCollection;
		this.canBeCreated = canBeCreated;
		this.isDisplayObject = isDisplayObject;
		this.constructorCollection = constructorCollection;
	}
	
	/**
	   
	**/
	public function clear():Void
	{
		this.numInstances = 0;
		this.numTemplates = 0;
		
		this._IDToObject.clear();
		this._objectIDIndex = -1;
	}
	
	public function addCategory(category:String):Void
	{
		this.categories.push(category);
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
			collection = this.sourceCollection.clone();
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
	
	public function removeObject(object:ValEditObject):Void
	{
		this._IDToObject.remove(object.id);
		this.numInstances--;
	}
	
	public function removeObjectByID(id:String):Void
	{
		this._IDToObject.remove(id);
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
	
	/**
	   
	   @param	container
	   @param	object
	   @param	parentValue
	**/
	public function addContainer(container:DisplayObjectContainer, object:Dynamic, parentValue:ExposedValueWithChildren = null):ExposedCollection
	{
		var collection:ExposedCollection;
		if (this._pool.length != 0) 
		{
			collection = this._pool.pop();
		}
		else
		{
			collection = this.sourceCollection.clone();
		}
		
		this._containers[container] = collection;
		collection.parentValue = parentValue;
		collection.object = object;
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
	
	/**
	   
	   @param	container
	**/
	public function removeContainer(container:DisplayObjectContainer):Void
	{
		var collection:ExposedCollection = this._containers[container];
		if (collection != null)
		{
			this._containers.remove(container);
			collection.parentValue = null;
			collection.object = null;
			collection.uiContainer = null;
			this._pool.push(collection);
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