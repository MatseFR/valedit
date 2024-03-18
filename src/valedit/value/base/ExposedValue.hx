package valedit.value.base;
import haxe.Constraints.Function;
import haxe.Timer;
import openfl.errors.ArgumentError;
import openfl.errors.Error;
import openfl.events.EventDispatcher;
import valedit.events.ValueEvent;
import valedit.ui.IValueUI;
import valedit.value.base.ExposedValueWithCollection;
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
	
	public var canCopyValueOnClone:Bool = true;
	/* Tells wether value should be checked for change when calling ExposedCollection's or ExposedGroup's getActionChanges function. Default is true. */
	public var checkForChange:Bool = true;
	public var collection(get, set):ExposedCollection;
	public var concatenatedPropertyName(get, never):String;
	/* used as value when object is null */
	public var defaultValue:Dynamic = null;
	/* all extras are executed when an ExposedValue's value changes */
	public var extras(get, never):ValueExtraContainer;
	/* Tells wether value should be read from the object or not
	 * if stored value is null it will read from object, otherwise stored value is used
	 * this is especially useful for rotation : one might want to have an animation with many rotations,
	 * while the object might restrict the value to 180/-180 or PI/-PI */
	public var isAbsolute:Bool = false;
	public var isConstructor(get, set):Bool;
	public var isEditable(get, set):Bool;
	public var isGroup(default, null):Bool;
	public var isNullable:Bool = false;
	public var isReadOnly(get, set):Bool;
	private var isReadOnlyInternal(get, set):Bool;
	/* tells whether this value is real (true, default) or not (false).
	 * Values that are not "real" : ExposedName, ExposedNote, ExposedSeparator, ExposedSpacing... */
	public var isRealValue(get, never):Bool;
	public var isTweenable(get, set):Bool;
	#if valeditor
	/* time at which this value last changed, whatever the reason */
	public var lastChanged:Float = ValEdit.TIME_STAMP_ORIGIN;
	/* time at which this value was last modified explicitely by user (through UI) */
	public var lastModified:Float = ValEdit.TIME_STAMP_ORIGIN;
	#end
	public var name:String;
	public var object(get, set):Dynamic;
	public var parentValue:ExposedValueWithCollection;
	public var propertyName:String;
	public var tweenValue(get, never):Dynamic;
	public var uiControl(get, set):IValueUI;
	public var updateCollectionOnChange:Bool = true;
	public var updateCollectionLocked:Bool = false;
	#if valeditor
	/* When set to true, ValEditor will check that value to decide if 2 objects should be considered the same or not. Default is false. */
	public var useForObjectMatching:Bool = false;
	public var valEditorObject(get, set):ValEditorObject;
	#end
	public var value(get, set):Dynamic;
	public var visible(get, set):Bool;
	
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
	
	private var _isConstructor:Bool = false;
	private function get_isConstructor():Bool { return this._isConstructor; }
	private function set_isConstructor(value:Bool):Bool
	{
		return this._isConstructor = value;
	}
	
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
		if (this._isReadOnly == value) return value;
		this._isReadOnly = value;
		ValueEvent.dispatch(this, ValueEvent.ACCESS_CHANGE, this);
		return this._isReadOnly;
	}
	
	private var _isReadOnlyInternal:Bool = false;
	private function get_isReadOnlyInternal():Bool { return this._isReadOnlyInternal; }
	private function set_isReadOnlyInternal(value:Bool):Bool
	{
		if (this._isReadOnlyInternal == value) return value;
		this._isReadOnlyInternal = value;
		ValueEvent.dispatch(this, ValueEvent.ACCESS_CHANGE, this);
		return this._isReadOnlyInternal;
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
		
		this._object = value;
		this._extras.object = value;
		ValueEvent.dispatch(this, ValueEvent.OBJECT_CHANGE, this);
		return this._object;
	}
	
	private function get_tweenValue():Dynamic
	{
		if (this._storedValue != null)
		{
			return this._storedValue;
		}
		return this._object == null ? this.defaultValue : Reflect.getProperty(this._object, this.propertyName);
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
	
	#if valeditor
	private var _valEditorObject:ValEditorObject;
	private function get_valEditorObject():ValEditorObject { return this._valEditorObject; }
	private function set_valEditorObject(value:ValEditorObject):ValEditorObject
	{
		return this._valEditorObject = value;
	}
	#end
	
	private function get_value():Dynamic
	{
		if (this._object == null)
		{
			return this._storedValue == null ? this.defaultValue : this._storedValue;
		}
		else
		{
			if (this.isAbsolute && this._storedValue != null)
			{
				return this._storedValue;
			}
			else
			{
				return Reflect.getProperty(this._object, this.propertyName);
			}
		}
	}
	private function set_value(value:Dynamic):Dynamic
	{
		if (this._object == null)
		{
			#if valeditor
			if (this._storedValue != value)
			{
				this._storedValue = value;
				this.lastChanged = Timer.stamp();
			}
			#else
			this._storedValue = value;
			#end
		}
		else if (this._storedValue != value)
		{
			this._storedValue = value;
			Reflect.setProperty(this._object, this.propertyName, value);
			#if valeditor
			this.lastChanged = ValEdit.TIME_STAMP_CURRENT;
			#end
			this._extras.execute();
			if (this.parentValue != null) this.parentValue.childValueChanged(this);
			if (this.updateCollectionOnChange && !this.updateCollectionLocked) this._collection.readValues();
			
			#if valeditor
			if (this._valEditorObject != null)
			{
				//this._valEditorObject.valueChange(this.propertyName);
				this._valEditorObject.valueChange(this);
			}
			#end
		}
		return value;
	}
	
	private var _visible:Bool = true;
	private function get_visible():Bool { return this._visible; }
	private function set_visible(value:Bool):Bool
	{
		if (this._visible == value) return value;
		return this._visible = value;
	}
	
	private var _storedValue:Dynamic = null;
	
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
		this.canCopyValueOnClone = true;
		this.checkForChange = true;
		this.collection = null;
		this.defaultValue = null;
		this._extras.clear();
		this._extras.owner = this;
		this.isAbsolute = false;
		this._isConstructor = false;
		this._isEditable = true;
		this.isNullable = false;
		this._isReadOnly = false;
		this._isReadOnlyInternal = false;
		#if valeditor
		this.lastChanged = ValEdit.TIME_STAMP_ORIGIN;
		this.lastModified = ValEdit.TIME_STAMP_ORIGIN;
		#end
		this.parentValue = null;
		this._storedValue = null;
		this._object = null;
		this.uiControl = null;
		#if valeditor
		this.useForObjectMatching = false;
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
	
	public function getPropertyNames():Array<String>
	{
		var names:Array<String> = [this.propertyName];
		if (this.parentValue != null)
		{
			var parent:ExposedValue = this.parentValue;
			while (parent != null)
			{
				names.unshift(parent.propertyName);
				parent = parent.parentValue;
			}
		}
		return names;
	}
	
	public function apply():Void
	{
		if (this._object == null || this._storedValue == null)
		{
			return;
		}
		Reflect.setProperty(this._object, this.propertyName, this._storedValue);
		this._extras.applyToObject(this._object);
	}
	
	public function applyToObject(object:Dynamic, applyIfDefaultValue:Bool = false):Void
	{
		if (!applyIfDefaultValue && this._object == null && this._storedValue == null)
		{
			return;
		}
		if (this._storedValue == null)
		{
			Reflect.setProperty(object, this.propertyName, this.value);
		}
		else
		{
			Reflect.setProperty(object, this.propertyName, this._storedValue);
		}
		this._extras.applyToObject(object);
	}
	
	public function readValue(dispatchEventIfChange:Bool = true):Void
	{
		if (this.isAbsolute && this._storedValue != null) return;
		
		var val:Dynamic = this.value;
		if (this._storedValue != val)
		{
			this._storedValue = val;
			if (this._uiControl != null) this._uiControl.updateExposedValue();
			if (dispatchEventIfChange) ValueEvent.dispatch(this, ValueEvent.VALUE_CHANGE, this);
		}
	}
	
	public function readValueFromObject(object:Dynamic, dispatchEventIfChange:Bool = false):Void
	{
		if (this.isAbsolute && this._storedValue != null) return;
		
		var val:Dynamic = Reflect.getProperty(object, this.propertyName);
		if (this._storedValue != val)
		{
			this._storedValue = val;
			if (this._uiControl != null) this._uiControl.updateExposedValue();
			if (dispatchEventIfChange) ValueEvent.dispatch(this, ValueEvent.VALUE_CHANGE, this);
		}
	}
	
	public function reassignValue():Void
	{
		if (this._storedValue != null)
		{
			var val:Dynamic = this._storedValue;
			this._storedValue = null;
			this.value = val;
		}
		else
		{
			this.value = this.value;
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
		value.canCopyValueOnClone = this.canCopyValueOnClone;
		value.checkForChange = this.checkForChange;
		value.defaultValue = this.defaultValue;
		if (copyValue && this.canCopyValueOnClone)
		{
			cloneValue(value);
		}
		value.isAbsolute = this.isAbsolute;
		value.isEditable = this._isEditable;
		value.isNullable = this.isNullable;
		value.isReadOnly = this._isReadOnly;
		value.isReadOnlyInternal = this._isReadOnlyInternal;
		value.isTweenable = this._isTweenable;
		value.updateCollectionOnChange = this.updateCollectionOnChange;
		#if valeditor
		value.useForObjectMatching = this.useForObjectMatching;
		#end
		value.visible = this._visible;
		this._extras.clone(value._extras);
	}
	
	public function cloneValue(toValue:ExposedValue):Void
	{
		if (this._storedValue != null)
		{
			toValue.value = this._storedValue;
		}
		else
		{
			toValue.value = this.value;
		}
	}
	
	public function loadComplete():Void
	{
		
	}
	
	public function fromJSON(json:Dynamic):Void
	{
		this.propertyName = json.propName;
		this._extras.fromJSON(json.extras);
	}
	
	public function fromJSONSave(json:Dynamic):Void
	{
		//this.value = json.value;
		this._storedValue = json.value;
		#if valeditor
		if (json.lastChanged != null)
		{
			this.lastChanged = json.lastChanged;
		}
		if (json.lastModified != null)
		{
			this.lastModified = json.lastModified;
		}
		#end
	}
	
	public function toJSON(json:Dynamic = null):Dynamic
	{
		if (json == null) json = {};
		json.clss = Type.getClassName(Type.getClass(this));
		json.propName = this.propertyName;
		json.extras = this._extras.toJSON();
		return json;
	}
	
	public function toJSONSave(json:Dynamic):Void
	{
		var data:Dynamic = {
			value:this.value,
		};
		#if valeditor
		data.lastChanged = this.lastChanged;
		data.lastModified = this.lastModified;
		#end
		Reflect.setField(json, this.propertyName, data);
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