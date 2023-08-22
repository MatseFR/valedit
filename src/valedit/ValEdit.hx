package valedit;
import haxe.Constraints.Function;
import haxe.ds.Map;
import openfl.display.DisplayObject;
import valedit.utils.PropertyMap;

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
	
	static private var _baseClassToClassList:Map<String, Array<String>> = new Map<String, Array<String>>();
	static private var _classMap:Map<String, ValEditClass> = new Map<String, ValEditClass>();
	
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
			v.objectCollection = collection;
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
			v.propertyMap = settings.propertyMap;
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
			v.propertyMap = PropertyMap.fromPool();
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
	
	static public function createObjectWithClass(clss:Class<Dynamic>, ?id:String, ?params:Array<Dynamic>):ValEditObject
	{
		return createObjectWithClassName(Type.getClassName(clss), id, params);
	}
	
	static public function createObjectWithClassName(className:String, ?id:String, ?params:Array<Dynamic>, ?valObject:ValEditObject, ?collection:ExposedCollection):ValEditObject
	{
		if (params == null) params = [];
		var valClass:ValEditClass = _classMap.get(className);
		
		if (valObject == null) valObject = ValEditObject.fromPool(valClass, id);
		valObject.object = Type.createInstance(valClass.classReference, params);
		
		var collectionProvided:Bool = collection != null;
		if (collection == null)
		{
			collection = valClass.getCollection();
		}
		valObject.collection = collection;
		if (collectionProvided)
		{
			collection.applyToObject(valObject.object);
		}
		collection.object = valObject;
		
		valObject.propertyMap = valClass.propertyMap;
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
		var collection:ExposedCollection = valClass.getTemplateCollection();
		
		if (constructorCollection != null)
		{
			constructorCollection.copyValuesTo(collection);
		}
		
		if (template == null) 
		{
			template = ValEditTemplate.fromPool(valClass, id, collection, constructorCollection);
			template.object = createObjectWithTemplate(template, template.collection, false);
		}
		else
		{
			template.collection = collection;
		}
		
		registerTemplateInternal(template);
		
		return template;
	}
	
	static public function createObjectWithTemplate(template:ValEditTemplate, ?id:String, ?valObject:ValEditObject, ?collection:ExposedCollection, registerToTemplate:Bool = true):ValEditObject
	{
		var valClass:ValEditClass = template.clss;
		
		if (valObject == null) valObject = new ValEditObject(valClass, id);
		var params:Array<Dynamic> = [];
		if (template.constructorCollection != null)
		{
			template.constructorCollection.toValueArray(params);
		}
		
		valObject.object = Type.createInstance(valClass.classReference, params);
		
		valObject.template = template;
		if (registerToTemplate)
		{
			template.addInstance(valObject);
		}
		
		valObject.propertyMap = valClass.propertyMap;
		
		template.collection.applyToObject(valObject.object);
		
		if (collection == null)
		{
			collection = valClass.getCollection();
		}
		valObject.collection = collection;
		collection.object = valObject;
		
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
			var func:Function = Reflect.field(valObject.object, valObject.clss.disposeFunctionName);
			Reflect.callMethod(valObject.object, func, []);
		}
		else if (valObject.clss.disposeCustom != null)
		{
			Reflect.callMethod(valObject.clss.disposeCustom, valObject.clss.disposeCustom, [valObject.object]);
		}
		
		if (valObject.template != null)
		{
			valObject.template.removeInstance(valObject);
		}
		
		unregisterObjectInternal(valObject);
		
		valObject.pool();
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
		destroyObject(template.object);
		
		unregisterTemplateInternal(template);
		
		template.pool();
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