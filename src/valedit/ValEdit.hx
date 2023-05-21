package valedit;
import editor.SelectionController;
import feathers.data.ArrayCollection;
import haxe.ds.Map;
import haxe.ds.ObjectMap;
import openfl.display.DisplayObjectContainer;
import openfl.errors.Error;
import valedit.ui.IValueUI;

/**
 * ...
 * @author Matse
 */
class ValEdit 
{
	static public var EXPOSED_VALUE_MARKER:String = "@@@";
	#if starling
	static public var STARLING_SUBTEXTURE_MARKER:String = "@@@";
	#end
	
	static public var selection(default, null):SelectionController = new SelectionController();
	static public var uiContainerDefault:DisplayObjectContainer;
	
	static public var categoryCollection(default, null):ArrayCollection<String> = new ArrayCollection<String>();
	static public var classCollection(default, null):ArrayCollection<String> = new ArrayCollection<String>();
	static public var objectCollection(default, null):ArrayCollection<ValEditObject> = new ArrayCollection<ValEditObject>();
	static public var templateCollection(default, null):ArrayCollection<ValEditTemplate> = new ArrayCollection<ValEditTemplate>();
	
	static private var _categoryToClassCollection:Map<String, ArrayCollection<String>> = new Map<String, ArrayCollection<String>>();
	static private var _categoryToObjectCollection:Map<String, ArrayCollection<ValEditObject>> = new Map<String, ArrayCollection<ValEditObject>>();
	static private var _categoryToTemplateCollection:Map<String, ArrayCollection<ValEditTemplate>> = new Map<String, ArrayCollection<ValEditTemplate>>();
	static private var _classToObjectCollection:Map<String, ArrayCollection<ValEditObject>> = new Map<String, ArrayCollection<ValEditObject>>();
	static private var _classToTemplateCollection:Map<String, ArrayCollection<ValEditTemplate>> = new Map<String, ArrayCollection<ValEditTemplate>>();
	static private var _objectToValEditObject:ObjectMap<Dynamic, ValEditObject> = new ObjectMap<Dynamic, ValEditObject>();
	
	static private var _baseClassToClassList:Map<String, Array<String>> = new Map<String, Array<String>>();
	static private var _classMap:Map<String, ValEditClass> = new Map<String, ValEditClass>();
	static private var _displayMap:Map<DisplayObjectContainer, ValEditClass> = new Map<DisplayObjectContainer, ValEditClass>();
	static private var _uiClassMap:Map<String, Void->IValueUI> = new Map<String, Void->IValueUI>();
	
	static public function registerClass<T>(type:Class<T>, collection:ExposedCollection, canBeCreated:Bool = true, categoryList:Array<String> = null, ?constructorCollection:ExposedCollection):Void
	{
		var className:String = Type.getClassName(type);
		if (_classMap.exists(className))
		{
			trace("ValEdit.registerClass ::: Class " + className + " already registered");
			return;
		}
		
		var v:ValEditClass = new ValEditClass(type, className, collection, canBeCreated, constructorCollection);
		_classMap.set(className, v);
		
		if (categoryList != null)
		{
			var strCollection:ArrayCollection<String>;
			for (category in categoryList)
			{
				if (!_categoryToClassCollection.exists(category))
				{
					categoryCollection.add(category);
					_categoryToClassCollection.set(category, new ArrayCollection<String>());
					_categoryToObjectCollection.set(category, new ArrayCollection<ValEditObject>());
					_categoryToTemplateCollection.set(category, new ArrayCollection<ValEditTemplate>());
				}
				strCollection = _categoryToClassCollection.get(category);
				strCollection.add(className);
				
				v.addCategory(category);
			}
		}
		
		var clss:Class<Dynamic> = type;
		var superName:String;
		var nameList:Array<String>;
		
		nameList = _baseClassToClassList.get(className);
		if (nameList == null)
		{
			nameList = new Array<String>();
			_baseClassToClassList.set(className, nameList);
		}
		nameList.push(className);
		
		var objCollection:ArrayCollection<ValEditObject>;
		if (!_classToObjectCollection.exists(className))
		{
			objCollection = new ArrayCollection<ValEditObject>();
			_classToObjectCollection.set(className, objCollection);
		}
		
		var templateCollection:ArrayCollection<ValEditTemplate>;
		if (!_classToTemplateCollection.exists(className))
		{
			templateCollection = new ArrayCollection<ValEditTemplate>();
			_classToTemplateCollection.set(className, templateCollection);
		}
		
		while (true)
		{
			clss = Type.getSuperClass(clss);
			if (clss == null) break;
			superName = Type.getClassName(clss);
			
			v.addSuperClassName(superName);
			
			nameList = _baseClassToClassList.get(superName);
			if (nameList == null)
			{
				nameList = new Array<String>();
				nameList.push(superName);
				_baseClassToClassList.set(superName, nameList);
			}
			nameList.push(className);
			
			if (!_classToObjectCollection.exists(superName))
			{
				objCollection = new ArrayCollection<ValEditObject>();
				_classToObjectCollection.set(superName, objCollection);
			}
			
			if (!_classToTemplateCollection.exists(superName))
			{
				templateCollection = new ArrayCollection<ValEditTemplate>();
				_classToTemplateCollection.set(superName, templateCollection);
			}
		}
		
		if (canBeCreated)
		{
			classCollection.add(className);
			
			//var objCollection:ArrayCollection<ValEditObject> = new ArrayCollection<ValEditObject>();
			//_classToObjectCollection.set(className, objCollection);
		}
	}
	
	static public function unregisterClass<T>(type:Class<T>):Void
	{
		var className:String = Type.getClassName(type);
		if (!_classMap.exists(className))
		{
			trace("ValEdit.unregisterClass ::: Class " + className + " not registered");
			return;
		}
		
		var valClass:ValEditClass = _classMap.get(className);
		
		var strCollection:ArrayCollection<String>;
		for (category in valClass.categories)
		{
			strCollection = _categoryToClassCollection.get(category);
			strCollection.remove(className);
			if (strCollection.length == 0)
			{
				// no more class associated with this category : remove category
				categoryCollection.remove(category);
				_categoryToClassCollection.remove(category);
				_categoryToObjectCollection.remove(category);
				_categoryToTemplateCollection.remove(category);
			}
		}
		
		var objectList:Array<Dynamic> = valClass.getObjectList();
		
		if (valClass.canBeCreated)
		{
			for (obj in objectList)
			{
				destroyObjectInternal(obj, valClass);
			}
			
			classCollection.remove(className);
			_classToObjectCollection.remove(className);
		}
		else
		{
			for (obj in objectList)
			{
				unregisterObjectInternal(obj, valClass);
			}
		}
		
		var clss:Class<Dynamic> = type;
		var superName:String;
		var nameList:Array<String>;
		
		nameList = _baseClassToClassList.get(className);
		if (nameList != null)
		{
			nameList.remove(className);
			if (nameList.length == 0)
			{
				_baseClassToClassList.remove(className);
			}
		}
		
		while (true)
		{
			clss = Type.getSuperClass(clss);
			if (clss == null) break;
			superName = Type.getClassName(clss);
			nameList = _baseClassToClassList.get(superName);
			if (nameList != null)
			{
				nameList.remove(className);
				if (nameList.length == 0)
				{
					_baseClassToClassList.remove(superName);
				}
			}
		}
	}
	
	static public function registerUIClass<T>(exposedValueClass:Class<T>, factory:Void->IValueUI):Void
	{
		var className:String = Type.getClassName(exposedValueClass);
		if (_uiClassMap.exists(className))
		{
			trace("ValEdit.registerUIClass ::: Class " + className + " already registered");
			return;
		}
		
		_uiClassMap[className] = factory;
	}
	
	static public function unregisterUIClass<T>(exposedValueClass:Class<T>):Void
	{
		var className:String = Type.getClassName(exposedValueClass);
		if (!_uiClassMap.exists(className))
		{
			trace("ValEdit.unregisterUIClass ::: Class " + className + " not registered");
		}
		
		_uiClassMap.remove(className);
	}
	
	/**
	   
	   @param	object	instance of a registered Class
	   @param	uiContainer	if left null uiContainerDefault is used
	**/
	static public function edit<T>(object:T, ?container:DisplayObjectContainer, ?parentValue:ExposedValue):ExposedCollection
	{
		if (container == null) container = uiContainerDefault;
		if (container == null)
		{
			throw new Error("ValEdit.edit ::: null container");
		}
		
		clearContainer(container);
		
		if (object == null) return null;
		
		var clss:Class<Dynamic> = Type.getClass(object);
		var className:String = Type.getClassName(clss);
		var valClass:ValEditClass = _classMap[className];
		
		if (valClass != null)
		{
			_displayMap[container] = valClass;
			return valClass.addContainer(container, object, parentValue);
		}
		else
		{
			while (true)
			{
				clss = Type.getSuperClass(clss);
				if (clss == null) break;
				className = Type.getClassName(clss);
				valClass = _classMap[className];
				if (valClass != null)
				{
					_displayMap[container] = valClass;
					return valClass.addContainer(container, object, parentValue);
				}
			}
			throw new Error("ValEdit.edit ::: unknown Class " + Type.getClassName(Type.getClass(object)));
		}
	}
	
	static public function editConstructor(className:String, ?container:DisplayObjectContainer):ExposedCollection
	{
		if (container == null) container = uiContainerDefault;
		if (container == null)
		{
			throw new Error("ValEdit.editConstructor ::: null container");
		}
		
		clearContainer(container);
		
		if (className == null) return null;
		
		var valClass:ValEditClass = _classMap[className];
		if (valClass != null)
		{
			if (valClass.constructorCollection != null)
			{
				_displayMap[container] = valClass;
				return valClass.addConstructorContainer(container);
			}
			else
			{
				return null;
			}
		}
		else
		{
			throw new Error("ValEdit.edit ::: unknown Class " + className);
		}
	}
	
	/**
	   
	   @param	a registered Class
	   @param	uiContainer	if left null uiContainerDefault is used
	**/
	static public function editConstructorWithClass<T>(clss:Class<T>, ?container:DisplayObjectContainer):ExposedCollection
	{
		return editConstructor(Type.getClassName(clss), container);
	}
	
	
	static public function editTemplate(template:ValEditTemplate, ?container:DisplayObjectContainer):Void
	{
		if (container == null) container = uiContainerDefault;
		if (container == null)
		{
			throw new Error("ValEdit.editTemplate ::: null container");
		}
		
		clearContainer(container);
		
		if (template == null) return;
		
		var valClass:ValEditClass = _classMap.get(template.className);
		valClass.addTemplateContainer(container, template);
	}
	
	/**
	   
	   @param	container
	**/
	static public function clearContainer(?container:DisplayObjectContainer):Void
	{
		if (container == null) container = uiContainerDefault;
		if (container == null)
		{
			throw new Error("ValEdit.clearContainer ::: null container");
		}
		
		var valClass:ValEditClass = _displayMap[container];
		if (valClass != null)
		{
			valClass.removeContainer(container);
			_displayMap.remove(container);
		}
	}
	
	/**
	   
	   @param	exposedValue
	   @return
	**/
	static public function toUIControl<T>(exposedValue:T):IValueUI
	{
		var clss:Class<T> = Type.getClass(exposedValue);
		var className:String = Type.getClassName(clss);
		var control:IValueUI = _uiClassMap[className]();
		control.exposedValue = cast(exposedValue, ExposedValue);
		cast(exposedValue, ExposedValue).uiControl = control;
		return control;
	}
	
	static public function createObjectWithClass<T>(clss:Class<T>, ?name:String, ?params:Array<Dynamic>):T
	{
		return createObjectWithClassName(Type.getClassName(clss), name, params);
	}
	
	static public function createObjectWithClassName(className:String, ?name:String, ?params:Array<Dynamic>):Dynamic
	{
		if (params == null) params = [];
		var valClass:ValEditClass = _classMap.get(className);
		var object:Dynamic = Type.createInstance(valClass.classReference, params);
		
		registerObjectInternal(object, valClass, name);
		
		return object;
	}
	
	static public function createTemplateWithClass<T>(clss:Class<T>, ?name:String, ?constructorCollection:ExposedCollection):ValEditTemplate
	{
		return createTemplateWithClassName(Type.getClassName(clss), name, constructorCollection);
	}
	
	static public function createTemplateWithClassName(className:String, ?name:String, ?constructorCollection:ExposedCollection):ValEditTemplate
	{
		var params:Array<Dynamic>;
		if (constructorCollection != null)
		{
			params = constructorCollection.toValueArray();
		}
		else
		{
			params = [];
		}
		var valClass:ValEditClass = _classMap.get(className);
		var object:Dynamic = Type.createInstance(valClass.classReference, params);
		var collection:ExposedCollection = valClass.getCollection();
		collection.object = object;
		var template:ValEditTemplate = new ValEditTemplate(name, object, className, collection, constructorCollection);
		
		registerTemplateInternal(template, valClass);
		
		return template;
	}
	
	static public function createObjectWithTemplate(template:ValEditTemplate, ?name:String):Dynamic
	{
		var valClass:ValEditClass = _classMap.get(template.className);
		if (name == null) name = valClass.makeObjectName();
		var params:Array<Dynamic> = [];
		if (template.constructorCollection != null)
		{
			template.constructorCollection.toValueArray(params);
		}
		
		var object:Dynamic = Type.createInstance(valClass.classReference, params);
		
		template.collection.applyToObject(object);
		
		registerObjectInternal(object, valClass, name);
		
		return object;
	}
	
	static private function registerObjectInternal(object:Dynamic, valClass:ValEditClass, ?name:String):Void
	{
		if (name == null) name = valClass.makeObjectName();
		valClass.addObject(object, name);
		
		// UI related stuff
		var valObject:ValEditObject = new ValEditObject(name, object, valClass.className);
		_objectToValEditObject.set(object, valObject);
		
		objectCollection.add(valObject);
		
		var objCollection:ArrayCollection<ValEditObject> = _classToObjectCollection.get(valClass.className);
		objCollection.add(valObject);
		
		for (className in valClass.superClassNames)
		{
			objCollection = _classToObjectCollection.get(className);
			objCollection.add(valObject);
		}
		
		for (category in valClass.categories)
		{
			objCollection = _categoryToObjectCollection.get(category);
			objCollection.add(valObject);
		}
	}
	
	static public function registerObject(object:Dynamic, name:String = null):Void
	{
		var clss:Class<Dynamic> = Type.getClass(object);
		var className:String = Type.getClassName(clss);
		var valClass:ValEditClass = _classMap.get(className);
		
		while (valClass == null)
		{
			clss = Type.getSuperClass(clss);
			if (clss == null) break;
			className = Type.getClassName(clss);
			valClass = _classMap.get(className);
		}
		
		if (valClass == null)
		{
			throw new Error("ValEdit.registerObject ::: no registered Class found for object Class " + Type.getClassName(Type.getClass(object)));
		}
		
		registerObjectInternal(object, valClass, name);
	}
	
	static private function registerTemplateInternal(template:ValEditTemplate, valClass:ValEditClass):Void
	{
		valClass.addTemplate(template);
		
		templateCollection.add(template);
		
		var collection:ArrayCollection<ValEditTemplate> = _classToTemplateCollection.get(valClass.className);
		collection.add(template);
		
		for (className in valClass.superClassNames)
		{
			collection = _classToTemplateCollection.get(className);
			collection.add(template);
		}
		
		for (category in valClass.categories)
		{
			collection = _categoryToTemplateCollection.get(category);
			collection.add(template);
		}
	}
	
	static public function registerTemplate(template:ValEditTemplate):Void
	{
		var valClass:ValEditClass = _classMap.get(template.className);
		
		registerTemplateInternal(template, valClass);
	}
	
	static public function destroyObject(object:Dynamic):Void
	{
		var clss:Class<Dynamic> = Type.getClass(object);
		var className:String = Type.getClassName(clss);
		var valClass:ValEditClass = _classMap.get(className);
		
		while (valClass == null)
		{
			clss = Type.getSuperClass(clss);
			if (clss == null) break;
			className = Type.getClassName(clss);
			valClass = _classMap.get(className);
			if (!valClass.hasObject(object))
			{
				// this could happen if the object was created/registered before a class "closer" to its class was registered
				// in this case we should try to look deeper in the superclasses
				valClass = null;
			}
		}
		
		if (valClass == null)
		{
			throw new Error("ValEdit.destroyObject ::: no registered Class found for object Class " + Type.getClassName(Type.getClass(object)));
		}
		
		destroyObjectInternal(object, valClass);
	}
	
	static public function destroyObjectWithValEditClass(object:Dynamic, valClass:ValEditClass):Void
	{
		destroyObjectInternal(object, valClass);
	}
	
	static private function destroyObjectInternal(object:Dynamic, valClass:ValEditClass):Void
	{
		unregisterObjectInternal(object, valClass);
	}
	
	static private function unregisterObjectInternal(object:Dynamic, valClass:ValEditClass):Void
	{
		valClass.removeObject(object);
		
		// UI related stuff
		var valObject:ValEditObject = _objectToValEditObject.get(object);
		_objectToValEditObject.remove(object);
		
		objectCollection.remove(valObject);
		
		var objCollection:ArrayCollection<ValEditObject> = _classToObjectCollection.get(valClass.className);
		objCollection.remove(valObject);
		
		for (className in valClass.superClassNames)
		{
			objCollection = _classToObjectCollection.get(className);
			objCollection.remove(valObject);
		}
		
		for (category in valClass.categories)
		{
			objCollection = _categoryToObjectCollection.get(category);
			objCollection.remove(valObject);
		}
	}
	
	static public function unregisterObject(object:Dynamic):Void
	{
		var clss:Class<Dynamic> = Type.getClass(object);
		var className:String = Type.getClassName(clss);
		var valClass:ValEditClass = _classMap.get(className);
		
		while (valClass == null)
		{
			clss = Type.getSuperClass(clss);
			if (clss == null) break;
			className = Type.getClassName(clss);
			valClass = _classMap.get(className);
			if (!valClass.hasObject(object))
			{
				// this could happen if the object was created/registered before a class "closer" to its class was registered
				// in this case we should try to look deeper in the superclasses
				valClass = null;
			}
		}
		
		if (valClass == null)
		{
			throw new Error("ValEdit.unregisterObject ::: no registered Class found for object Class " + Type.getClassName(Type.getClass(object)));
		}
		
		unregisterObjectInternal(object, valClass);
	}
	
	static public function destroyTemplate(template:ValEditTemplate):Void
	{
		var valClass:ValEditClass = _classMap.get(template.className);
		destroyTemplateInternal(template, valClass);
	}
	
	static private function destroyTemplateInternal(template:ValEditTemplate, valClass:ValEditClass):Void
	{
		unregisterTemplateInternal(template, valClass);
	}
	
	static private function unregisterTemplateInternal(template:ValEditTemplate, valClass:ValEditClass):Void
	{
		valClass.removeTemplate(template);
		
		templateCollection.remove(template);
		
		var collection:ArrayCollection<ValEditTemplate> = _classToTemplateCollection.get(valClass.className);
		collection.remove(template);
		
		for (className in valClass.superClassNames)
		{
			collection = _classToTemplateCollection.get(className);
			collection.remove(template);
		}
		
		for (category in valClass.categories)
		{
			collection = _categoryToTemplateCollection.get(category);
			collection.remove(template);
		}
	}
	
	static public function unregisterTemplate(template:ValEditTemplate):Void
	{
		var valClass:ValEditClass = _classMap.get(template.className);
		unregisterTemplateInternal(template, valClass);
	}
	
	static public function getClassListForBaseClass(baseClassName:String):Array<String>
	{
		return _baseClassToClassList.get(baseClassName);
	}
	
	static public function getClassCollectionForCategory(category:String):ArrayCollection<String>
	{
		return _categoryToClassCollection.get(category);
	}
	
	static public function getValEditClassByClass(clss:Class<Dynamic>):ValEditClass
	{
		return _classMap.get(Type.getClassName(clss));
	}
	
	static public function getValEditClassByClassName(className:String):ValEditClass
	{
		return _classMap.get(className);
	}
	
	static public function getObjectCollectionForClass(clss:Class<Dynamic>):ArrayCollection<ValEditObject>
	{
		return _classToObjectCollection.get(Type.getClassName(clss));
	}
	
	static public function getObjectCollectionForClassName(className:String):ArrayCollection<ValEditObject>
	{
		return _classToObjectCollection.get(className);
	}
	
	static public function getObjectClass(object:Dynamic):Class<Dynamic>
	{
		return Type.getClass(object);
	}
	
	static public function getObjectClassName(object:Dynamic):String
	{
		return Type.getClassName(Type.getClass(object));
	}
	
	static public function getObjectName(object:Dynamic):String
	{
		var clss:Class<Dynamic> = Type.getClass(object);
		var className:String = Type.getClassName(clss);
		return _classMap.get(className).getObjectName(object);
	}
	
	static public function getObjectNameWithClass(object:Dynamic, clss:Class<Dynamic>):String
	{
		var className:String = Type.getClassName(clss);
		return _classMap.get(className).getObjectName(object);
	}
	
	static public function getObjectNameWithClassName(object:Dynamic, className:String):String
	{
		return _classMap.get(className).getObjectName(object);
	}
	
	static public function getObjectWithClass(name:String, clss:Class<Dynamic>):Dynamic
	{
		var className:String = Type.getClassName(clss);
		return _classMap.get(className).getObjectByName(name);
	}
	
	static public function getObjectWithClassName(name:String, className:String):Dynamic
	{
		return _classMap.get(className).getObjectByName(name);
	}
	
	static public function getTemplateCollectionForClassName(className:String):ArrayCollection<ValEditTemplate>
	{
		return _classToTemplateCollection.get(className);
	}
	
	static public function getTemplateCollectionForCategory(category:String):ArrayCollection<ValEditTemplate>
	{
		return _categoryToTemplateCollection.get(category);
	}
	
}