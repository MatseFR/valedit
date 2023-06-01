package valedit;
import editor.SelectionController;
import feathers.data.ArrayCollection;
import haxe.ds.Map;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.errors.Error;
import ui.InteractiveFactories;
import valedit.ui.IValueUI;
import valedit.util.PropertyMap;
import valedit.util.RegularPropertyName;

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
	
	static public var currentContainer(get, set):ValEditContainer;
	static private var _currentContainer:ValEditContainer;
	static private function get_currentContainer():ValEditContainer { return _currentContainer; }
	static private function set_currentContainer(value:ValEditContainer):ValEditContainer
	{
		if (value == _currentContainer) return value;
		if (_currentContainer != null)
		{
			_currentContainer.close();
		}
		_currentContainer = value;
		if (_currentContainer != null)
		{
			_currentContainer.open();
		}
		return _currentContainer;
	}
	
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
	
	static private var _baseClassToClassList:Map<String, Array<String>> = new Map<String, Array<String>>();
	static private var _classMap:Map<String, ValEditClass> = new Map<String, ValEditClass>();
	static private var _displayMap:Map<DisplayObjectContainer, ValEditClass> = new Map<DisplayObjectContainer, ValEditClass>();
	static private var _uiClassMap:Map<String, Void->IValueUI> = new Map<String, Void->IValueUI>();
	
	static public function registerClass<T>(type:Class<T>, collection:ExposedCollection, canBeCreated:Bool = true, objectType:Int = -1, ?constructorCollection:ExposedCollection, ?settings:ValEditClassSettings, ?categoryList:Array<String>):Void
	{
		var clss:Class<Dynamic>;
		var className:String = Type.getClassName(type);
		if (_classMap.exists(className))
		{
			trace("ValEdit.registerClass ::: Class " + className + " already registered");
			return;
		}
		
		if (objectType == -1)
		{
			clss = type;
			if (clss == DisplayObject)
			{
				objectType = ObjectType.DISPLAY_OPENFL;
			}
			#if starling
			else if (clss == starling.display.DisplayObject)
			{
				objectType = ObjectType.DISPLAY_STARLING;
			}
			#end
			else
			{
				while (true)
				{
					clss = Type.getSuperClass(clss);
					if (clss == null) break;
					if (clss == DisplayObject)
					{
						objectType = ObjectType.DISPLAY_OPENFL;
						break;
					}
					#if starling
					else if (clss == starling.display.DisplayObject)
					{
						objectType = ObjectType.DISPLAY_STARLING;
						break;
					}
					#end
				}
			}
			
			if (objectType == -1)
			{
				objectType = ObjectType.OTHER;
			}
		}
		
		var v:ValEditClass = new ValEditClass(type, className, collection, canBeCreated, objectType, constructorCollection);
		_classMap.set(className, v);
		
		if (settings != null)
		{
			v.interactiveFactory = settings.interactiveFactory;
			v.proxyClass = settings.proxyClass;
			v.propertyMap = settings.propertyMap;
			v.proxyPropertyMap = settings.proxyPropertyMap;
			v.addToDisplayCustom = settings.addToDisplayCustom;
			v.removeFromDisplayCustom = settings.removeFromDisplayCustom;
			v.hasRadianRotation = settings.hasRadianRotation;
		}
		else
		{
			v.hasRadianRotation = objectType == ObjectType.DISPLAY_STARLING;
		}
		
		if (v.propertyMap == null)
		{
			v.propertyMap = new PropertyMap();
		}
		
		if ((v.proxyClass != null || v.proxyFactory != null) && v.proxyPropertyMap == null)
		{
			v.proxyPropertyMap = new PropertyMap();
		}
		
		if (collection.hasValue(RegularPropertyName.PIVOT_X))
		{
			v.hasPivotProperties = true;
		}
		else
		{
			if (v.proxyPropertyMap != null)
			{
				v.hasPivotProperties = v.proxyPropertyMap.hasPropertyRegular(RegularPropertyName.PIVOT_X);
			}
			else
			{
				v.hasPivotProperties = v.propertyMap.hasPropertyRegular(RegularPropertyName.PIVOT_X);
			}
		}
		
		if (collection.hasValue(RegularPropertyName.TRANSFORM))
		{
			v.hasTransformProperty = true;
		}
		else
		{
			if (v.proxyPropertyMap != null)
			{
				v.hasTransformProperty = v.proxyPropertyMap.hasPropertyRegular(RegularPropertyName.TRANSFORM);
			}
			else
			{
				v.hasTransformProperty = v.propertyMap.hasPropertyRegular(RegularPropertyName.TRANSFORM);
			}
		}
		
		if (collection.hasValue(RegularPropertyName.TRANSFORMATION_MATRIX))
		{
			v.hasTransformationMatrixProperty = true;
		}
		else
		{
			if (v.proxyPropertyMap != null)
			{
				v.hasTransformationMatrixProperty = v.proxyPropertyMap.hasPropertyRegular(RegularPropertyName.TRANSFORMATION_MATRIX);
			}
			else
			{
				v.hasTransformationMatrixProperty = v.propertyMap.hasPropertyRegular(RegularPropertyName.TRANSFORMATION_MATRIX);
			}
		}
		
		if (v.interactiveFactory == null)
		{
			switch (v.objectType)
			{
				case ObjectType.DISPLAY_OPENFL :
					v.interactiveFactory = InteractiveFactories.openFL_default;
				
				#if starling
				case ObjectType.DISPLAY_STARLING :
					v.interactiveFactory = InteractiveFactories.starling_default;
				#end
				
				case ObjectType.OTHER :
					// nothing here
				
				default :
					throw new Error("ValEdit.registerClass");
			}
		}
		
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
		
		clss = type;
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
		
		var objectList:Array<ValEditObject> = valClass.getObjectList();
		
		if (valClass.canBeCreated)
		{
			for (obj in objectList)
			{
				destroyObjectInternal(obj);
			}
			
			classCollection.remove(className);
			_classToObjectCollection.remove(className);
		}
		else
		{
			for (obj in objectList)
			{
				unregisterObjectInternal(obj);
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
	static public function edit(object:Dynamic, ?container:DisplayObjectContainer, ?parentValue:ExposedValue):ExposedCollection
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
		
		if (Std.isOfType(object, ValEditObject))
		{
			valClass = cast(object, ValEditObject).clss;
		}
		else
		{
			clss = Type.getClass(object);
			className = Type.getClassName(clss);
			valClass = _classMap[className];
		}
		
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
	
	static public function createObjectWithClass<T>(clss:Class<T>, ?id:String, ?params:Array<Dynamic>):ValEditObject
	{
		return createObjectWithClassName(Type.getClassName(clss), id, params);
	}
	
	static public function createObjectWithClassName(className:String, ?id:String, ?params:Array<Dynamic>):ValEditObject
	{
		if (params == null) params = [];
		var valClass:ValEditClass = _classMap.get(className);
		var valObject:ValEditObject = new ValEditObject(valClass, id);
		valObject.realObject = Type.createInstance(valClass.classReference, params);
		
		if (valClass.proxyClass != null)
		{
			valObject.object = Type.createInstance(valClass.proxyClass, []);
		}
		else if (valClass.proxyFactory != null)
		{
			valObject.object = valClass.proxyFactory(valObject);
		}
		else
		{
			valObject.object = valObject.realObject;
		}
		
		valObject.propertyMap = valClass.proxyPropertyMap != null ? valClass.proxyPropertyMap : valClass.propertyMap;
		valObject.realPropertyMap = valClass.propertyMap;
		valObject.hasPivotProperties = valClass.hasPivotProperties;
		valObject.hasTransformProperty = valClass.hasTransformProperty;
		valObject.hasTransformationMatrixProperty = valClass.hasTransformationMatrixProperty;
		valObject.hasRadianRotation = valClass.hasRadianRotation;
		
		valObject.ready();
		
		valObject.interactiveObject = valClass.interactiveFactory(valObject);
		
		registerObjectInternal(valObject);
		
		return valObject;
	}
	
	static public function createTemplateWithClass<T>(clss:Class<T>, ?id:String, ?constructorCollection:ExposedCollection):ValEditTemplate
	{
		return createTemplateWithClassName(Type.getClassName(clss), id, constructorCollection);
	}
	
	static public function createTemplateWithClassName(className:String, ?id:String, ?constructorCollection:ExposedCollection):ValEditTemplate
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
		var template:ValEditTemplate = new ValEditTemplate(valClass, id, object, collection, constructorCollection);
		
		registerTemplateInternal(template, valClass);
		
		return template;
	}
	
	static public function createObjectWithTemplate(template:ValEditTemplate, ?id:String):ValEditObject
	{
		var valClass:ValEditClass = _classMap.get(template.className);
		var valObject:ValEditObject = new ValEditObject(valClass, id);
		var params:Array<Dynamic> = [];
		if (template.constructorCollection != null)
		{
			template.constructorCollection.toValueArray(params);
		}
		
		valObject.realObject = Type.createInstance(valClass.classReference, params);
		
		template.collection.applyToObject(valObject.realObject);
		
		if (valClass.proxyClass != null)
		{
			valObject.object = Type.createInstance(valClass.proxyClass, []);
		}
		else if (valClass.proxyFactory != null)
		{
			valObject.object = valClass.proxyFactory(valObject);
		}
		else
		{
			valObject.object = valObject.realObject;
		}
		
		valObject.interactiveObject = valClass.interactiveFactory(valObject);
		valObject.propertyMap = valClass.proxyPropertyMap != null ? valClass.proxyPropertyMap : valClass.propertyMap;
		valObject.realPropertyMap = valClass.propertyMap;
		
		valObject.ready();
		
		registerObjectInternal(valObject);
		
		return valObject;
	}
	
	static private function registerObjectInternal(valObject:ValEditObject):Void
	{
		if (valObject.id == null) valObject.id = valObject.clss.makeObjectID();
		valObject.clss.addObject(valObject);
		
		//var valObject:ValEditObject = new ValEditObject(name, object, valClass.className);
		//_objectToValEditObject.set(object, valObject);
		
		objectCollection.add(valObject);
		
		var objCollection:ArrayCollection<ValEditObject> = _classToObjectCollection.get(valObject.className);
		objCollection.add(valObject);
		
		for (className in valObject.clss.superClassNames)
		{
			objCollection = _classToObjectCollection.get(className);
			objCollection.add(valObject);
		}
		
		for (category in valObject.clss.categories)
		{
			objCollection = _categoryToObjectCollection.get(category);
			objCollection.add(valObject);
		}
		
		if (currentContainer != null)
		{
			currentContainer.add(valObject);
		}
	}
	
	//static public function registerObject(object:Dynamic, name:String = null):Void
	//{
		//var clss:Class<Dynamic> = Type.getClass(object);
		//var className:String = Type.getClassName(clss);
		//var valClass:ValEditClass = _classMap.get(className);
		//
		//while (valClass == null)
		//{
			//clss = Type.getSuperClass(clss);
			//if (clss == null) break;
			//className = Type.getClassName(clss);
			//valClass = _classMap.get(className);
		//}
		//
		//if (valClass == null)
		//{
			//throw new Error("ValEdit.registerObject ::: no registered Class found for object Class " + Type.getClassName(Type.getClass(object)));
		//}
		//
		//registerObjectInternal(object, valClass, name);
	//}
	
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
	
	static public function destroyObject(valObject:ValEditObject):Void
	{
		//var clss:Class<Dynamic> = Type.getClass(object);
		//var className:String = Type.getClassName(clss);
		//var valClass:ValEditClass = _classMap.get(className);
		//
		//while (valClass == null)
		//{
			//clss = Type.getSuperClass(clss);
			//if (clss == null) break;
			//className = Type.getClassName(clss);
			//valClass = _classMap.get(className);
			//if (!valClass.hasObject(object))
			//{
				//// this could happen if the object was created/registered before a class "closer" to its class was registered
				//// in this case we should try to look deeper in the superclasses
				//valClass = null;
			//}
		//}
		//
		//if (valClass == null)
		//{
			//throw new Error("ValEdit.destroyObject ::: no registered Class found for object Class " + Type.getClassName(Type.getClass(object)));
		//}
		
		destroyObjectInternal(valObject);
	}
	
	//static public function destroyObjectWithValEditClass(object:Dynamic, valClass:ValEditClass):Void
	//{
		//destroyObjectInternal(object, valClass);
	//}
	
	static private function destroyObjectInternal(valObject:ValEditObject):Void
	{
		unregisterObjectInternal(valObject);
	}
	
	static private function unregisterObjectInternal(valObject:ValEditObject):Void
	{
		valObject.clss.removeObject(valObject);
		
		// UI related stuff
		//var valObject:ValEditObject = _objectToValEditObject.get(object);
		//_objectToValEditObject.remove(object);
		
		objectCollection.remove(valObject);
		
		var objCollection:ArrayCollection<ValEditObject> = _classToObjectCollection.get(valObject.className);
		objCollection.remove(valObject);
		
		for (className in valObject.clss.superClassNames)
		{
			objCollection = _classToObjectCollection.get(className);
			objCollection.remove(valObject);
		}
		
		for (category in valObject.clss.categories)
		{
			objCollection = _categoryToObjectCollection.get(category);
			objCollection.remove(valObject);
		}
	}
	
	static public function unregisterObject(valObject:ValEditObject):Void
	{
		//var clss:Class<Dynamic> = Type.getClass(object);
		//var className:String = Type.getClassName(clss);
		//var valClass:ValEditClass = _classMap.get(className);
		//
		//while (valClass == null)
		//{
			//clss = Type.getSuperClass(clss);
			//if (clss == null) break;
			//className = Type.getClassName(clss);
			//valClass = _classMap.get(className);
			//if (!valClass.hasObject(object))
			//{
				//// this could happen if the object was created/registered before a class "closer" to its class was registered
				//// in this case we should try to look deeper in the superclasses
				//valClass = null;
			//}
		//}
		//
		//if (valClass == null)
		//{
			//throw new Error("ValEdit.unregisterObject ::: no registered Class found for object Class " + Type.getClassName(Type.getClass(object)));
		//}
		
		unregisterObjectInternal(valObject);
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
	
	//static public function getObjectID(object:Dynamic):String
	//{
		//var clss:Class<Dynamic> = Type.getClass(object);
		//var className:String = Type.getClassName(clss);
		//return _classMap.get(className).getObjectID(object);
	//}
	
	//static public function getObjectNameWithClass(object:Dynamic, clss:Class<Dynamic>):String
	//{
		//var className:String = Type.getClassName(clss);
		//return _classMap.get(className).getObjectID(object);
	//}
	
	//static public function getObjectNameWithClassName(object:Dynamic, className:String):String
	//{
		//return _classMap.get(className).getObjectID(object);
	//}
	
	static public function getObjectWithClass(name:String, clss:Class<Dynamic>):Dynamic
	{
		var className:String = Type.getClassName(clss);
		return _classMap.get(className).getObjectByID(name);
	}
	
	static public function getObjectWithClassName(name:String, className:String):Dynamic
	{
		return _classMap.get(className).getObjectByID(name);
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