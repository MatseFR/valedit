package valedit;
import flash.display.DisplayObjectContainer;
import haxe.ds.ObjectMap;

/**
 * ...
 * @author Matse
 */
class ValEditClass 
{
	public var canBeCreated(default, null):Bool;
	public var categories(default, null):Array<String> = new Array<String>();
	public var className(default, null):String;
	public var classReference(default, null):Class<Dynamic>;
	public var constructorCollection(default, null):ExposedCollection;
	public var numInstances(default, null):Int = 0;
	public var numTemplates(default, null):Int = 0;
	public var sourceCollection(default, null):ExposedCollection;
	public var superClassNames(default, null):Array<String> = new Array<String>();
	
	public var proxyClassName(default, null):String;
	public var proxyClassReference(default, null):Class<Dynamic>;
	
	private var _nameToObject:Map<String, Dynamic> = new Map<String, Dynamic>();
	private var _objectToName:ObjectMap<Dynamic, String> = new ObjectMap<Dynamic, String>();
	private var _objectNameIndex:Int = -1;
	
	private var _nameToTemplate:Map<String, ValEditTemplate> = new Map<String, ValEditTemplate>();
	private var _templateNameIndex:Int = -1;
	
	private var _containers:Map<DisplayObjectContainer, ExposedCollection> = new Map<DisplayObjectContainer, ExposedCollection>();
	private var _pool:Array<ExposedCollection> = new Array<ExposedCollection>();
	
	private var _constructorContainers:Map<DisplayObjectContainer, ExposedCollection> = new Map<DisplayObjectContainer, ExposedCollection>();
	private var _constructorPool:Array<ExposedCollection> = new Array<ExposedCollection>();
	
	private var _templateContainers:Map<DisplayObjectContainer, ValEditTemplate> = new Map<DisplayObjectContainer, ValEditTemplate>();
	
	/**
	   
	**/
	public function new(classReference:Class<Dynamic>, className:String, sourceCollection:ExposedCollection, canBeCreated:Bool, ?constructorCollection:ExposedCollection) 
	{
		this.classReference = classReference;
		this.className = className;
		this.sourceCollection = sourceCollection;
		this.canBeCreated = canBeCreated;
		this.constructorCollection = constructorCollection;
	}
	
	/**
	   
	**/
	public function clear():Void
	{
		this.numInstances = 0;
		this.numTemplates = 0;
		
		this._nameToObject.clear();
		this._objectToName.clear();
		this._objectNameIndex = -1;
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
	
	public function makeObjectName():String
	{
		var objName:String = null;
		while (true)
		{
			this._objectNameIndex++;
			objName = this.className + this._objectNameIndex;
			if (!this._nameToObject.exists(objName)) break;
		}
		return objName;
	}
	
	public function objectNameExists(name:String):Bool
	{
		return this._nameToObject.exists(name);
	}
	
	public function addObject(object:Dynamic, name:String = null):Void
	{
		if (name == null) name = makeObjectName();
		this._nameToObject.set(name, object);
		this._objectToName.set(object, name);
		this.numInstances++;
	}
	
	public function getObjectByName(name:String):Dynamic
	{
		return this._nameToObject.get(name);
	}
	
	public function getObjectList(?objList:Array<Dynamic>):Array<Dynamic>
	{
		if (objList == null) objList = new Array<Dynamic>();
		
		for (obj in _nameToObject)
		{
			objList.push(obj);
		}
		
		return objList;
	}
	
	public function getObjectName(object:Dynamic):String
	{
		return this._objectToName.get(object);
	}
	
	public function hasObject(object:Dynamic):Bool
	{
		return this._objectToName.exists(object);
	}
	
	public function removeObject(object:Dynamic):Void
	{
		var name:String = this._objectToName.get(object);
		this._nameToObject.remove(name);
		this._objectToName.remove(object);
		this.numInstances--;
	}
	
	public function removeObjectByName(name:String):Void
	{
		var object:Dynamic = this._nameToObject.get(name);
		this._nameToObject.remove(name);
		this._objectToName.remove(object);
		this.numInstances--;
	}
	
	public function makeTemplateName():String
	{
		var templateName:String = null;
		while (true)
		{
			this._templateNameIndex++;
			templateName = this.className + " template" + this._templateNameIndex;
			if (!this._nameToTemplate.exists(templateName)) break;
		}
		return templateName;
	}
	
	public function templateNameExists(name:String):Bool
	{
		return this._nameToTemplate.exists(name);
	}
	
	public function addTemplate(template:ValEditTemplate):Void
	{
		if (template.name == null) template.name = makeTemplateName();
		this._nameToTemplate.set(template.name, template);
		this.numTemplates++;
	}
	
	public function getTemplateByName(name:String):ValEditTemplate
	{
		return _nameToTemplate.get(name);
	}
	
	public function getTemplateList(?templateList:Array<ValEditTemplate>):Array<ValEditTemplate>
	{
		if (templateList == null) templateList = new Array<ValEditTemplate>();
		
		for (template in _nameToTemplate)
		{
			templateList.push(template);
		}
		
		return templateList;
	}
	
	public function removeTemplate(template:ValEditTemplate):Void
	{
		this._nameToTemplate.remove(template.name);
		this.numTemplates--;
	}
	
	public function removeTemplateByName(name:String):Void
	{
		this._nameToTemplate.remove(name);
		this.numTemplates--;
	}
	
	/**
	   
	   @param	container
	   @param	object
	   @param	parentValue
	**/
	public function addContainer(container:DisplayObjectContainer, object:Dynamic, parentValue:ExposedValue = null):ExposedCollection
	{
		var collection:ExposedCollection;
		if (this._pool.length != 0) 
		{
			collection = this._pool.pop();
		}
		else
		{
			collection = this.sourceCollection.clone();
			collection.buildUI();
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
			collection.buildUI();
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