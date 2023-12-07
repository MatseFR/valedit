package valedit;
import haxe.Constraints.Function;
import haxe.ds.Map;
import haxe.macro.Compiler;
import openfl.display.DisplayObject;
import valedit.asset.AssetLib;
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
	
	static public var VERSION:String = Compiler.getDefine("valedit");
	
	static public var assetLib:AssetLib;
	
	static private var _baseClassToClassList:Map<String, Array<String>> = new Map<String, Array<String>>();
	static private var _classMap:Map<String, ValEditClass> = new Map<String, ValEditClass>();
	static private var _templateMap:Map<String, ValEditTemplate> = new Map<String, ValEditTemplate>();
	
	static public function init(completeCallback:Void->Void):Void
	{
		if (assetLib == null)
		{
			assetLib = new AssetLib();
			assetLib.init(false);
		}
		
		assetLib.load(completeCallback);
	}
	
	static public function getClassSettings(type:Class<Dynamic>, settings:ValEditClassSettings = null):ValEditClassSettings
	{
		if (settings == null) settings = ValEditClassSettings.fromPool();
		
		getClassDisplayObjectSettings(type, settings);
		
		#if starling
		if (settings.isDisplayObject && settings.displayObjectType == DisplayObjectType.STARLING)
		{
			settings.disposeFunctionName = "dispose";
		}
		#end
		
		return settings;
	}
	
	static public function getClassDisplayObjectSettings(type:Class<Dynamic>, settings:ValEditClassSettings):Void
	{
		var clss:Class<Dynamic> = type;
		if (clss == DisplayObject)
		{
			settings.isDisplayObject = true;
			settings.displayObjectType = DisplayObjectType.OPENFL;
		}
		#if starling
		if (clss == starling.display.DisplayObject)
		{
			settings.isDisplayObject = true;
			settings.displayObjectType = DisplayObjectType.STARLING;
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
					settings.isDisplayObject = true;
					settings.displayObjectType = DisplayObjectType.OPENFL;
					break;
				}
				#if starling
				else if (clss == starling.display.DisplayObject)
				{
					settings.isDisplayObject = true;
					settings.displayObjectType = DisplayObjectType.STARLING;
					break;
				}
				#end
			}
		}
	}
	
	static public function registerClass(type:Class<Dynamic>, settings:ValEditClassSettings, ?v:ValEditClass):ValEditClass
	{
		var className:String = Type.getClassName(type);
		if (_classMap.exists(className))
		{
			trace("ValEdit.registerClass ::: Class " + className + " already registered");
			return null;
		}
		
		if (v == null)
		{
			v = ValEditClass.fromPool(type);
		}
		
		v.addToDisplayFunction = settings.addToDisplayFunction;
		v.addToDisplayFunctionName = settings.addToDisplayFunctionName;
		v.className = className;
		v.constructorCollection = settings.constructorCollection;
		v.creationFunction = settings.creationFunction;
		v.creationInitFunction = settings.creationInitFunction;
		v.creationInitFunctionName = settings.creationInitFunctionName;
		v.displayObjectType = settings.displayObjectType;
		v.disposeFunction = settings.disposeFunction;
		v.disposeFunctionName = settings.disposeFunctionName;
		v.isDisplayObject = settings.isDisplayObject;
		v.objectCollection = settings.objectCollection;
		v.propertyMap = settings.propertyMap;
		v.removeFromDisplayFunction = settings.removeFromDisplayFunction;
		v.removeFromDisplayFunctionName = settings.removeFromDisplayFunctionName;
		v.templateCollection = settings.templateCollection;
		
		if (v.propertyMap == null)
		{
			v.propertyMap = PropertyMap.fromPool();
		}
		
		_classMap.set(className, v);
		
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
	
	static public function registerClassSimple(type:Class<Dynamic>, objectCollection:ExposedCollection, templateCollection:ExposedCollection = null, constructorCollection:ExposedCollection = null, ?v:ValEditClass):ValEditClass
	{
		var settings:ValEditClassSettings = ValEditClassSettings.fromPool();
		settings.objectCollection = objectCollection;
		settings.templateCollection = templateCollection;
		settings.constructorCollection = constructorCollection;
		getClassSettings(type, settings);
		
		v = registerClass(type, settings, v);
		
		settings.pool();
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
		
		//if (valClass.canBeCreated)
		//{
			for (obj in objectList)
			{
				destroyObjectInternal(obj);
			}
		//}
		//else
		//{
			//for (obj in objectList)
			//{
				//unregisterObjectInternal(obj);
			//}
		//}
		
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
		valObject.defaultCollection = collection;
		if (collectionProvided)
		{
			collection.applyAndSetObject(valObject.object);
		}
		else
		{
			collection.readAndSetObject(valObject.object);
		}
		
		valObject.propertyMap = valClass.propertyMap;
		valObject.ready();
		
		registerObjectInternal(valObject);
		
		return valObject;
	}
	
	static public function createTemplateWithClass(clss:Class<Dynamic>, id:String, ?constructorCollection:ExposedCollection):ValEditTemplate
	{
		return createTemplateWithClassName(Type.getClassName(clss), id, constructorCollection);
	}
	
	static public function createTemplateWithClassName(className:String, id:String, ?constructorCollection:ExposedCollection, ?template:ValEditTemplate):ValEditTemplate
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
			template.object.currentCollection.readValues();
		}
		else
		{
			template.collection = collection;
		}
		
		registerTemplateInternal(template);
		
		return template;
	}
	
	static public function createObjectWithTemplate(template:ValEditTemplate, id:String, ?valObject:ValEditObject, ?collection:ExposedCollection, registerToTemplate:Bool = true):ValEditObject
	{
		var valClass:ValEditClass = template.clss;
		
		if (valObject == null) valObject = ValEditObject.fromPool(valClass, id);
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
			collection.readAndSetObject(valObject.object);
		}
		else
		{
			collection.applyAndSetObject(valObject.object);
		}
		valObject.defaultCollection = collection;
		
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
		_templateMap.set(template.id, template);
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
		
		if (valObject.clss.disposeFunction != null)
		{
			Reflect.callMethod(valObject.clss.disposeFunction, valObject.clss.disposeFunction, [valObject.object]);
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
	
	static public function getTemplate(id:String):ValEditTemplate
	{
		return _templateMap.get(id);
	}
	
	static public function getObjectClass(object:Dynamic):Class<Dynamic>
	{
		return Type.getClass(object);
	}
	
	static public function getObjectClassName(object:Dynamic):String
	{
		return Type.getClassName(Type.getClass(object));
	}
	
	static public function getObjectWithClass(name:String, clss:Class<Dynamic>):ValEditObject
	{
		var className:String = Type.getClassName(clss);
		return _classMap.get(className).getObjectByID(name);
	}
	
	static public function getObjectWithClassName(name:String, className:String):ValEditObject
	{
		return _classMap.get(className).getObjectByID(name);
	}
	
	static public function getValEditObjectFromObject(object:Dynamic):ValEditObject
	{
		var clss:ValEditClass = getValEditClassByClassName(getObjectClassName(object));
		if (clss == null) return null;
		return clss.getValEditObjectFromObject(object);
	}
	
}