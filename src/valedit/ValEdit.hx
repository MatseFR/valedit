package valedit;
import haxe.ds.Map;
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
	
	static private var _classMap:Map<String, ValEditClass> = new Map<String, ValEditClass>();
	static private var _classMapByName:Map<String, ValEditClass> = new Map<String, ValEditClass>();
	static private var _displayMap:Map<DisplayObjectContainer, ValEditClass> = new Map<DisplayObjectContainer, ValEditClass>();
	static private var _uiClassMap:Map<String, Void->IValueUI> = new Map<String, Void->IValueUI>();
	
	static public function registerClass<T>(type:Class<T>, collection:ExposedCollection, name:String = null):Void
	{
		var className:String = Type.getClassName(type);
		if (_classMap.exists(className))
		{
			trace("ValEdit.registerClass ::: Class '" + className + "' already registered");
			return;
		}
		
		if (name == null) name = className;
		
		var v:ValEditClass = new ValEditClass();
		v.classReference = type;
		v.name = name;
		v.sourceCollection = collection;
		
		_classMap[className] = v;
		_classMapByName[name] = v;
	}
	
	static public function registerUIClass<T>(exposedValueClass:Class<T>, factory:Void->IValueUI):Void
	{
		var className:String = Type.getClassName(exposedValueClass);
		if (_uiClassMap.exists(className))
		{
			trace("ValEdit.registerUIClass ::: Class '" + className + "' already registered");
			return;
		}
		
		_uiClassMap[className] = factory;
	}
	
	/**
	   
	   @param	object	instance of a registered Class
	   @param	uiContainer	if left null uiContainerDefault is used
	**/
	static public function edit(object:Dynamic, container:DisplayObjectContainer = null, parentValue:ExposedValue = null):ExposedCollection
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
			throw new Error("ValEdit.edit ::: unknown Class '" + className + "'");
		}
	}
	
	/**
	   
	   @param	container
	**/
	static public function clearContainer(container:DisplayObjectContainer = null):Void
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
}