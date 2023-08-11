package valedit.value.base;
import haxe.Constraints.Function;
import openfl.errors.ArgumentError;
import openfl.errors.Error;
import openfl.events.EventDispatcher;
import valedit.events.ValueEvent;
import valedit.ui.IValueUI;
import valedit.value.base.ExposedValueWithChildren;
import valedit.value.extra.ValueExtraContainer;
#if valeditor
import valeditor.ValEditorObject;
#end

/**
 * ...
 * @author Matse
 */
abstract class ExposedValue extends EventDispatcher
{
	static private var _FACTORIES:Map<String, Function> = new Map<String, Function>();
	
	static public function registerFactory(exposedValueClass:Class<Dynamic>, factory:Function):Void
	{
		var className:String = Type.getClassName(exposedValueClass);
		_FACTORIES.set(className, factory);
	}
	
	public var collection(get, set):ExposedCollection;
	public var concatenatedPropertyName(get, never):String;
	/* used as value when object is null */
	public var defaultValue:Dynamic = null;
	/* all extras are executed when an ExposedValue's value changes */
	public var extras(get, never):ValueExtraContainer;
	public var isEditable(get, set):Bool;
	public var isGroup(default, null):Bool;
	public var isNullable:Bool = false;
	public var isReadOnly(get, set):Bool;
	public var isReadOnlyLocked(get, set):Bool;
	/* tells whether this value is real (true, default) or not (false).
	 * Values that are not "real" : ExposedName, ExposedNote, ExposedSeparator, ExposedSpacing... */
	public var isRealValue(get, never):Bool;
	public var isTweenable(get, set):Bool;
	public var name:String;
	public var object(get, set):Dynamic;
	public var parentValue:ExposedValueWithChildren;
	public var propertyName:String;
	public var uiControl(get, set):IValueUI;
	public var updateCollectionUIOnChange:Bool = true;
	public var value(get, set):Dynamic;
	
	private var _collection:ExposedCollection;
	private function get_collection():ExposedCollection { return this._collection; }
	private function set_collection(value:ExposedCollection):ExposedCollection
	{
		this._extras.collection = value;
		return this._collection = value;
	}
	
	private function get_concatenatedPropertyName():String
	{
		var name:String = this.propertyName;
		var parent:ExposedValue = this.parentValue;
		while (parent != null)
		{
			name = parent.name + "." + name;
			parent = parent.parentValue;
		}
		
		return name;
	}
	
	private var _extras:ValueExtraContainer = new ValueExtraContainer();
	private function get_extras():ValueExtraContainer { return this._extras; }
	
	private var _isEditable:Bool = true;
	private function get_isEditable():Bool { return this._isEditable; }
	private function set_isEditable(value:Bool):Bool
	{
		if (this._isEditable == value) return value;
		this._isEditable = value;
		ValueEvent.dispatch(this, ValueEvent.EDITABLE_CHANGE, this);
		return this._isEditable;
	}
	
	private var _isReadOnly:Bool = false;
	private function get_isReadOnly():Bool { return this._isReadOnly; }
	private function set_isReadOnly(value:Bool):Bool
	{
		if (this._isReadOnlyLocked || this._isReadOnly == value) return value;
		this._isReadOnly = value;
		ValueEvent.dispatch(this, ValueEvent.ACCESS_CHANGE, this);
		return this._isReadOnly;
	}
	
	private var _isReadOnlyLocked:Bool = false;
	private function get_isReadOnlyLocked():Bool { return this._isReadOnlyLocked; }
	private function set_isReadOnlyLocked(value:Bool):Bool
	{
		if (this._isReadOnlyLocked == value) return value;
		return this._isReadOnlyLocked = value;
	}
	
	private var _isRealValue:Bool = true;
	private function get_isRealValue():Bool { return this._isRealValue; }
	
	private var _isTweenable:Bool = false;
	private function get_isTweenable():Bool { return this._isTweenable; }
	private function set_isTweenable(value:Bool):Bool
	{
		if (value)
		{
			throw new Error(Type.getClassName(Type.getClass(this)) + " cannot be tweenable");
		}
		return this._isTweenable;
	}
	
	private var _object:Dynamic;
	private function get_object():Dynamic { return this._object; }
	private function set_object(value:Dynamic):Dynamic
	{
		if (this._object == value) return value;
		var nullObject:Bool = this._object == null;
		if (Std.isOfType(value, ValEditObject))
		{
			this._valEditObject = cast value;
			#if valeditor
			if (Std.isOfType(value, ValEditorObject))
			{
				this._valEditorObject = cast value;
			}
			#end
			this._object = this._valEditObject.object;
			this._extras.object = this._valEditObject.object;
		}
		else
		{
			this._valEditObject = null;
			#if valeditor
			this._valEditorObject = null;
			#end
			this._object = value;
			this._extras.object = value;
		}
		if (nullObject && this._storedValue != null)
		{
			var value:Dynamic = this._storedValue;
			this._storedValue = null;
			this.value = value;
		}
		this._storedValue = null;
		ValueEvent.dispatch(this, ValueEvent.OBJECT_CHANGE, this);
		return this._object;
	}
	
	private var _uiControl:IValueUI;
	private function get_uiControl():IValueUI { return this._uiControl; }
	private function set_uiControl(value:IValueUI):IValueUI
	{
		if (this._uiControl == value) return value;
		if (value != null)
		{
			value.exposedValue = this;
		}
		else if (this._uiControl != null)
		{
			this._uiControl.exposedValue = null;
		}
		return this._uiControl = value;
	}
	
	private function get_value():Dynamic
	{
		if (this._object == null)
		{
			return this._storedValue == null ? this.defaultValue : this._storedValue;
		}
		else
		{
			return Reflect.getProperty(this._object, this.propertyName);
		}
	}
	private function set_value(value:Dynamic):Dynamic
	{
		if (this._object == null)
		{
			this._storedValue = value;
		}
		else if (this._storedValue != value)
		{
			this._storedValue = value;
			Reflect.setProperty(this._object, this.propertyName, value);
			this._extras.execute();
			if (this.parentValue != null) this.parentValue.childValueChanged();
			if (this.updateCollectionUIOnChange) this._collection.readValues();
			
			#if valeditor
			if (this._valEditorObject != null)
			{
				this._valEditorObject.valueChange(this.propertyName);
			}
			#end
		}
		return value;
	}
	
	private var _valEditObject:ValEditObject;
	#if valeditor
	private var _valEditorObject:ValEditorObject;
	#end
	private var _storedValue:Dynamic;
	
	/**
	   
	   @param	propertyName
	   @param	name
	**/
	public function new(propertyName:String, name:String = null) 
	{
		super();
		setNames(propertyName, name);
		this._extras.owner = this;
	}
	
	/**
	   
	**/
	public function clear():Void
	{
		this.collection = null;
		this.defaultValue = null;
		this._isEditable = true;
		this.isNullable = false;
		this._isReadOnly = false;
		this._isReadOnlyLocked = false;
		this.parentValue = null;
		this._storedValue = null;
		this._object = null;
		this._extras.object = null;
		this.uiControl = null;
		this._valEditObject = null;
		#if valeditor
		this._valEditorObject = null;
		#end
	}
	
	abstract public function pool():Void;
	
	private function setNames(propertyName:String, name:String):Void
	{
		if (propertyName == null)
		{
			throw new ArgumentError("ExposedValue ::: propertyName cannot be null");
		}
		this.propertyName = propertyName;
		if (name == null) name = propertyName;
		this.name = name;
	}
	
	public function applyToObject(object:Dynamic):Void
	{
		Reflect.setProperty(object, this.propertyName, this.value);
		this._extras.applyToObject(object);
	}
	
	/** sets isReadOnly even if isReadOnlyLocked is true */
	public function forceReadOnly(value:Bool):Void
	{
		var wasLocked:Bool = this._isReadOnlyLocked;
		this._isReadOnlyLocked = false;
		this.isReadOnly = value;
		this._isReadOnlyLocked = wasLocked;
	}
	
	/** sets isReadOnly value and sets isReadOnlyLocked to true */
	public function setReadOnlyAndLock(value:Bool):Void
	{
		var wasLocked:Bool = this._isReadOnlyLocked;
		this._isReadOnlyLocked = false;
		this.isReadOnly = value;
		this._isReadOnlyLocked = wasLocked;
		this.isReadOnlyLocked = true;
	}
	
	public function readValue(dispatchEventIfChange:Bool = true):Void
	{
		var val:Dynamic = this.value;
		if (this._storedValue != val)
		{
			this._storedValue = val;
			if (this._uiControl != null) this._uiControl.updateExposedValue();
			if (dispatchEventIfChange) ValueEvent.dispatch(this, ValueEvent.VALUE_CHANGE, this);
		}
	}
	
	public function restoreDefaultValue():Void
	{
		if (this._storedValue != null)
		{
			this._storedValue = null;
			if (this._uiControl != null) this._uiControl.updateExposedValue();
		}
	}
	
	/**
	   
	**/
	public function valueChanged():Void
	{
		readValue(false);
	}
	
	/**
	   Useful to create a constructor parameters array
	**/
	public function toValueArray(values:Array<Dynamic>):Void
	{
		values.push(this.value);
	}
	
	/**
	   
	   @return
	**/
	public function clone(copyValue:Bool = false):ExposedValue
	{
		throw new Error("You have to override ExposedValue.clone");
	}
	
	private function clone_internal(value:ExposedValue, copyValue:Bool = false):Void
	{
		value.defaultValue = this.defaultValue;
		if (copyValue)
		{
			value.value = this.value;
		}
		value.isEditable = this._isEditable;
		value.isNullable = this.isNullable;
		value.isReadOnly = this._isReadOnly;
		value.isReadOnlyLocked = this._isReadOnlyLocked;
		value.isTweenable = this._isTweenable;
		value.updateCollectionUIOnChange = this.updateCollectionUIOnChange;
		this._extras.clone(value._extras);
	}
	
	public function fromJSON(json:Dynamic):Void
	{
		this.propertyName = json.propName;
		this._extras.fromJSON(json.extras);
	}
	
	public function toJSON(json:Dynamic = null):Dynamic
	{
		if (json == null) json = {};
		json.clss = Type.getClassName(Type.getClass(this));
		json.propName = this.propertyName;
		json.extras = this._extras.toJSON();
		return json;
	}
	
	public function toJSONSimple(json:Dynamic):Void
	{
		Reflect.setField(json, this.propertyName, this.value);
	}
	
	/**
	   
	   @param	json
	   @return
	**/
	static public function valueFromJSON(json:Dynamic):ExposedValue
	{
		var value:ExposedValue;
		var className:String = json.clss;
		var propName:String = json.propName;
		var factory:Function = _FACTORIES.get(className);
		
		if (factory != null)
		{
			#if neko
			value = Reflect.callMethod(factory, factory, [propName]);
			#else
			value = cast factory(propName);
			#end
		}
		else
		{
			var clss:Class<Dynamic> = Type.resolveClass(className);
			value = Type.createInstance(clss, []);
		}
		value.fromJSON(json);
		return value;
	}
	
}