package valedit;
import haxe.Constraints.Function;
import haxe.ds.Map;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.errors.Error;
import valedit.ui.IValueUI;
import valedit.util.PropertyMap;

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
	
	static public var uiContainerDefault:DisplayObjectContainer;
	
	static private var _baseClassToClassList:Map<String, Array<String>> = new Map<String, Array<String>>();
	static private var _classMap:Map<String, ValEditClass> = new Map<String, ValEditClass>();
	static private var _displayMap:Map<DisplayObjectContainer, ValEditClass> = new Map<DisplayObjectContainer, ValEditClass>();
	static private var _uiClassMap:Map<String, Void->IValueUI> = new Map<String, Void->IValueUI>();
	
	static public function registerClass(type:Class<Dynamic>, collection:ExposedCollection, canBeCreated:Bool = true, ?isDisplayObject:Bool, ?displayObjectType:Int, ?constructorCollection:ExposedCollection, ?settings:ValEditClassSettings, ?categoryList:Array<String>, ?v:ValEditClass):ValEditClass
	{
		var clss:Class<Dynamic>;
		var className:String = Type.getClassName(type);
		if (_classMap.exists(className))
		{
			trace("ValEdit.registerClass ::: Class " + className + " already registered");
			return null;
		}
		
		if (isDisplayObject == null || (isDisplayObject && displayObjectType == null))
		{
			clss = type;
			if (clss == DisplayObject)
			{
				isDisplayObject = true;
				displayObjectType = DisplayObjectType.OPENFL;
			}
			#if starling
			else if (clss == starling.display.DisplayObject)
			{
				isDisplayObject = true;
				displayObjectType = DisplayObjectType.STARLING;
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
						isDisplayObject = true;
						displayObjectType = DisplayObjectType.OPENFL;
						break;
					}
					#if starling
					else if (clss == starling.display.DisplayObject)
					{
						isDisplayObject = true;
						displayObjectType = DisplayObjectType.STARLING;
						break;
					}
					#end
				}
			}
			
			if (isDisplayObject == null)
			{
				isDisplayObject = false;
			}
		}
		
		if (v == null)
		{
			v = new ValEditClass(type, className, collection, canBeCreated, isDisplayObject, constructorCollection);
			if (isDisplayObject)
			{
				v.displayObjectType = displayObjectType;
			}
		}
		else
		{
			v.classReference = type;
			v.className = className;
			v.sourceCollection = collection;
			v.canBeCreated = canBeCreated;
			v.isDisplayObject = isDisplayObject;
			if (isDisplayObject)
			{
				v.displayObjectType = displayObjectType;
			}
			v.constructorCollection = constructorCollection;
		}
		_classMap.set(className, v);
		
		if (settings != null)
		{
			v.disposeFunctionName = settings.objectDisposeFunctionName;
			v.proxyClass = settings.proxyClass;
			v.propertyMap = settings.propertyMap;
			v.proxyPropertyMap = settings.proxyPropertyMap;
			v.disposeCustom = settings.disposeCustom;
			v.addToDisplayCustom = settings.addToDisplayCustom;
			v.removeFromDisplayCustom = settings.removeFromDisplayCustom;
		}
		else
		{
			#if starling
			if (displayObjectType == DisplayObjectType.STARLING)
			{
				v.disposeFunctionName = "dispose";
			}
			#end
		}
		
		if (v.propertyMap == null)
		{
			v.propertyMap = new PropertyMap();
		}
		
		if ((v.proxyClass != null || v.proxyFactory != null) && v.proxyPropertyMap == null)
		{
			v.proxyPropertyMap = new PropertyMap();
		}
		
		if (categoryList != null)
		{
			for (category in categoryList)
			{
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
		}
		
		return v;
	}
	
	static public function unregisterClass(type:Class<Dynamic>):Void
	{
		var className:String = Type.getClassName(type);
		if (!_classMap.exists(className))
		{
			trace("ValEdit.unregisterClass ::: Class " + className + " not registered");
			return;
		}
		
		var valClass:ValEditClass = _classMap.get(className);
		_classMap.remove(className);
		
		var objectList:Array<ValEditObject> = valClass.getObjectList();
		
		if (valClass.canBeCreated)
		{
			for (obj in objectList)
			{
				destroyObjectInternal(obj);
			}
		}
		else
		{
			for (obj in objectList)
			{
				unregisterObjectInternal(obj);
			}
		}
		
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
		
		for (superName in valClass.superClassNames)
		{
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
	
	static public function registerUIClass(exposedValueClass:Class<Dynamic>, factory:Void->IValueUI):Void
	{
		var className:String = Type.getClassName(exposedValueClass);
		if (_uiClassMap.exists(className))
		{
			trace("ValEdit.registerUIClass ::: Class " + className + " already registered");
			return;
		}
		
		_uiClassMap[className] = factory;
	}
	
	static public function unregisterUIClass(exposedValueClass:Class<Dynamic>):Void
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
	
	static public function createObjectWithClass(clss:Class<Dynamic>, ?id:String, ?params:Array<Dynamic>):ValEditObject
	{
		return createObjectWithClassName(Type.getClassName(clss), id, params);
	}
	
	static public function createObjectWithClassName(className:String, ?id:String, ?params:Array<Dynamic>, ?valObject:ValEditObject):ValEditObject
	{
		if (params == null) params = [];
		var valClass:ValEditClass = _classMap.get(className);
		
		if (valObject == null) valObject = new ValEditObject(valClass, id);
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
		
		valObject.ready();
		
		registerObjectInternal(valObject);
		
		return valObject;
	}
	
	static public function createTemplateWithClass(clss:Class<Dynamic>, ?id:String, ?constructorCollection:ExposedCollection):ValEditTemplate
	{
		return createTemplateWithClassName(Type.getClassName(clss), id, constructorCollection);
	}
	
	static public function createTemplateWithClassName(className:String, ?id:String, ?constructorCollection:ExposedCollection, ?template:ValEditTemplate):ValEditTemplate
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
		
		if (template == null) 
		{
			template = new ValEditTemplate(valClass, id, object, collection, constructorCollection);
		}
		else
		{
			template.object = object;
			template.collection = collection;
			template.constructorCollection = constructorCollection;
		}
		
		registerTemplateInternal(template);
		
		return template;
	}
	
	static public function createObjectWithTemplate(template:ValEditTemplate, ?id:String, ?valObject:ValEditObject):ValEditObject
	{
		var valClass:ValEditClass = _classMap.get(template.className);
		
		if (valObject == null) valObject = new ValEditObject(valClass, id);
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
	}
	
	static private function registerTemplateInternal(template:ValEditTemplate):Void
	{
		template.clss.addTemplate(template);
	}
	
	static public function destroyObject(valObject:ValEditObject):Void
	{
		destroyObjectInternal(valObject);
	}
	
	static private function destroyObjectInternal(valObject:ValEditObject):Void
	{
		if (valObject.clss.disposeFunctionName != null)
		{
			var func:Function = Reflect.field(valObject.realObject, valObject.clss.disposeFunctionName);
			Reflect.callMethod(valObject.realObject, func, []);
		}
		else if (valObject.clss.disposeCustom != null)
		{
			Reflect.callMethod(valObject.clss.disposeCustom, valObject.clss.disposeCustom, [valObject.realObject]);
		}
		
		unregisterObjectInternal(valObject);
	}
	
	static private function unregisterObjectInternal(valObject:ValEditObject):Void
	{
		valObject.clss.removeObject(valObject);
	}
	
	static public function unregisterObject(valObject:ValEditObject):Void
	{
		unregisterObjectInternal(valObject);
	}
	
	static public function destroyTemplate(template:ValEditTemplate):Void
	{
		destroyTemplateInternal(template);
	}
	
	static private function destroyTemplateInternal(template:ValEditTemplate):Void
	{
		unregisterTemplateInternal(template);
	}
	
	static private function unregisterTemplateInternal(template:ValEditTemplate):Void
	{
		template.clss.removeTemplate(template);
	}
	
	static public function unregisterTemplate(template:ValEditTemplate):Void
	{
		unregisterTemplateInternal(template);
	}
	
	static public function getClassListForBaseClass(baseClassName:String):Array<String>
	{
		return _baseClassToClassList.get(baseClassName);
	}
	
	static public function getValEditClassByClass(clss:Class<Dynamic>):ValEditClass
	{
		return _classMap.get(Type.getClassName(clss));
	}
	
	static public function getValEditClassByClassName(className:String):ValEditClass
	{
		return _classMap.get(className);
	}
	
	static public function getObjectClass(object:Dynamic):Class<Dynamic>
	{
		return Type.getClass(object);
	}
	
	static public function getObjectClassName(object:Dynamic):String
	{
		return Type.getClassName(Type.getClass(object));
	}
	
	static public function getObjectWithClass(name:String, clss:Class<Dynamic>):Dynamic
	{
		var className:String = Type.getClassName(clss);
		return _classMap.get(className).getObjectByID(name);
	}
	
	static public function getObjectWithClassName(name:String, className:String):Dynamic
	{
		return _classMap.get(className).getObjectByID(name);
	}
	
}