package valedit;
import feathers.data.ArrayCollection;
import feathers.data.TreeCollection;
import feathers.data.TreeNode;
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
	
	static public var uiContainerDefault:DisplayObjectContainer;
	
	static public var classCollection(default, null):ArrayCollection<String> = new ArrayCollection<String>();
	static public var objectCollection(default, null):TreeCollection<ValEditObject> = new TreeCollection<ValEditObject>();
	
	static private var _classToObjectCollection:Map<String, ArrayCollection<ValEditObject>> = new Map<String, ArrayCollection<ValEditObject>>();
	static private var _classToTreeNode:Map<String, TreeNode<ValEditObject>> = new Map<String, TreeNode<ValEditObject>>();
	static private var _objectToValEditObject:ObjectMap<Dynamic, ValEditObject> = new ObjectMap<Dynamic, ValEditObject>();
	static private var _objectToTreeNode:ObjectMap<Dynamic, TreeNode<ValEditObject>> = new ObjectMap<Dynamic, TreeNode<ValEditObject>>();
	
	static private var _classMap:Map<String, ValEditClass> = new Map<String, ValEditClass>();
	static private var _displayMap:Map<DisplayObjectContainer, ValEditClass> = new Map<DisplayObjectContainer, ValEditClass>();
	static private var _uiClassMap:Map<String, Void->IValueUI> = new Map<String, Void->IValueUI>();
	
	static public function registerClass<T>(type:Class<T>, collection:ExposedCollection, canBeCreated:Bool = true):Void
	{
		var className:String = Type.getClassName(type);
		if (_classMap.exists(className))
		{
			trace("ValEdit.registerClass ::: Class " + className + " already registered");
			return;
		}
		
		var v:ValEditClass = new ValEditClass(type, className, collection, canBeCreated);
		
		_classMap.set(className, v);
		
		if (canBeCreated)
		{
			classCollection.add(className);
			
			var valObject:ValEditObject = new ValEditObject(className, null);
			var node:TreeNode<ValEditObject> = new TreeNode(valObject, []);
			objectCollection.addAt(node, [objectCollection.getLength()]);
			_classToTreeNode.set(className, node);
			
			var objCollection:ArrayCollection<ValEditObject> = new ArrayCollection<ValEditObject>();
			_classToObjectCollection.set(className, objCollection);
		}
	}
	
	static public function unregisterClass<T>(type:Class<T>):Void
	{
		// TODO
		var className:String = Type.getClassName(type);
		if (!_classMap.exists(className))
		{
			trace("ValEdit.unregisterClass ::: Class " + className + " not registered");
			return;
		}
		
		var valClass:ValEditClass = _classMap.get(className);
		var objectList:Array<Dynamic> = valClass.getObjectList();
		
		if (valClass.canBeCreated)
		{
			for (obj in objectList)
			{
				destroyObjectInternal(obj, valClass);
			}
		}
		else
		{
			for (obj in objectList)
			{
				unregisterObjectInternal(obj, valClass);
			}
		}
	}
	
	static public function getValEditClassByClass(clss:Class<Dynamic>):ValEditClass
	{
		return _classMap.get(Type.getClassName(clss));
	}
	
	static public function getValEditClassByClassName(className:String):ValEditClass
	{
		return _classMap.get(className);
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
	
	static public function getObjectCollectionForClass(clss:Class<Dynamic>):ArrayCollection<ValEditObject>
	{
		return _classToObjectCollection.get(Type.getClassName(clss));
	}
	
	static public function getObjectCollectionForClassName(className:String):ArrayCollection<ValEditObject>
	{
		return _classToObjectCollection.get(className);
	}
	
	static public function createObjectWithClass<T>(clss:Class<T>, ?name:String, ?params:Array<Dynamic>):T
	{
		if (params == null) params = [];
		var className:String = Type.getClassName(clss);
		var valClass:ValEditClass = _classMap.get(className);
		var object:T = Type.createInstance(clss, params);
		
		registerObjectInternal(object, valClass, name);
		
		return object;
	}
	
	static public function createObjectWithClassName(className:String, ?name:String, ?params:Array<Dynamic>):Dynamic
	{
		if (params == null) params = [];
		var valClass:ValEditClass = _classMap.get(className);
		var object:Dynamic = Type.createInstance(valClass.classReference, params);
		
		registerObjectInternal(object, valClass, name);
		
		return object;
	}
	
	static private function registerObjectInternal(object:Dynamic, valClass:ValEditClass, ?name:String):Void
	{
		if (name == null) name = valClass.makeObjectName();
		valClass.addObject(object, name);
		
		// UI related stuff
		var valObject:ValEditObject = new ValEditObject(name, object);
		_objectToValEditObject.set(object, valObject);
		var node:TreeNode<ValEditObject> = new TreeNode<ValEditObject>(valObject);
		_objectToTreeNode.set(object, node);
		var objCollection:ArrayCollection<ValEditObject> = _classToObjectCollection.get(valClass.className);
		objCollection.add(valObject);
		var classNode:TreeNode<ValEditObject> = _classToTreeNode.get(valClass.className);
		var location:Array<Int> = objectCollection.locationOf(classNode);
		location.push(classNode.children.length);
		objectCollection.addAt(node, location);
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
		var node:TreeNode<ValEditObject> = _objectToTreeNode.get(object);
		_objectToTreeNode.remove(object);
		
		var objCollection:ArrayCollection<ValEditObject> = _classToObjectCollection.get(valClass.className);
		objCollection.remove(valObject);
		
		objectCollection.remove(node);
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
}