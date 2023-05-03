package valedit;
import openfl.errors.Error;
import openfl.events.EventDispatcher;
import valedit.events.ValueEvent;
import valedit.ui.IValueUI;
import valedit.value.extra.ValueExtraContainer;

/**
 * ...
 * @author Matse
 */
class ExposedValue extends EventDispatcher
{
	public var collection(get, set):ExposedCollection;
	/* used as value when object is null */
	public var defaultValue:Dynamic = null;
	public var extras(get, never):ValueExtraContainer;
	public var isEditable(get, set):Bool;
	/* tells whether this value is real (true, default) or not (false) */
	public var isRealValue(get, never):Bool;
	public var name:String;
	public var object(get, set):Dynamic;
	public var parentValue:ExposedValue;
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
	
	private var _extras:ValueExtraContainer = new ValueExtraContainer();
	private function get_extras():ValueExtraContainer { return this._extras; }
	
	private var _isEditable:Bool = true;
	private function get_isEditable():Bool { return this._isEditable; }
	private function set_isEditable(value:Bool):Bool
	{
		if (this._isEditable == value) return value;
		this._isEditable = value;
		ValueEvent.dispatch(this, ValueEvent.EDITABLE_CHANGE);
		for (val in this._childValues)
		{
			val.isEditable = this._isEditable;
		}
		return this._isEditable;
	}
	
	private var _isRealValue:Bool = true;
	private function get_isRealValue():Bool { return this._isRealValue; }
	
	private var _object:Dynamic;
	private function get_object():Dynamic { return this._object; }
	private function set_object(value:Dynamic):Dynamic
	{
		if (this._object == value) return value;
		var nullObject:Bool = this._object == null;
		this._object = value;
		if (nullObject && this._storedValue != null)
		{
			Reflect.setProperty(this._object, propertyName, this._storedValue);
		}
		this._storedValue = null;
		this._extras.object = value;
		ValueEvent.dispatch(this, ValueEvent.OBJECT_CHANGE);
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
		return _uiControl = value;
	}
	
	private function get_value():Dynamic
	{
		if (this._object == null)
		{
			return this._storedValue == null ? defaultValue : this._storedValue;
		}
		else
		{
			return Reflect.getProperty(this._object, propertyName);
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
			Reflect.setProperty(this._object, propertyName, value);
			this._extras.execute();
			if (parentValue != null) parentValue.childValueChanged();
			if (updateCollectionUIOnChange) this._collection.uiCollection.update(this._uiControl);
		}
		return value;
	}
	
	private var _storedValue:Dynamic;
	private var _childValues:Array<ExposedValue> = new Array<ExposedValue>();
	
	/**
	   
	   @param	propertyName
	   @param	name
	**/
	public function new(propertyName:String, name:String = null) 
	{
		super();
		this.propertyName = propertyName;
		if (name == null) name = propertyName;
		this.name = name;
		this._extras.owner = this;
	}
	
	/**
	   
	**/
	public function clear():Void
	{
		this._object = null;
		this._extras.object = null;
	}
	
	/**
	   
	   @param	value
	**/
	public function addChildValue(value:ExposedValue):Void
	{
		this._childValues.push(value);
	}
	
	/**
	   
	   @param	value
	**/
	public function removeChildValue(value:ExposedValue):Void
	{
		this._childValues.remove(value);
	}
	
	/**
	   
	**/
	public function childValueChanged():Void
	{
		if (updateCollectionUIOnChange) 
		{
			this._collection.uiCollection.update(_uiControl);
			if (parentValue != null) parentValue.childValueChanged();
		}
	}
	
	/**
	   
	   @return
	**/
	public function clone():ExposedValue
	{
		throw new Error("You have to override ExposedValue.clone");
	}
	
	private function clone_internal(value:ExposedValue):Void
	{
		value.defaultValue = this.defaultValue;
		value.isEditable = this._isEditable;
		value.updateCollectionUIOnChange = this.updateCollectionUIOnChange;
		this._extras.clone(value._extras);
	}
	
	public function fromJSON(json:Dynamic):Void
	{
		//name = json.name;
		propertyName = json.propName;
	}
	
	public function toJSON(json:Dynamic = null):Dynamic
	{
		if (json == null) json = {};
		json.clss = Type.getClassName(Type.getClass(this));
		//json.name = name;
		json.propName = propertyName;
		return json;
	}
	
	/**
	   
	   @param	json
	   @return
	**/
	static public function valueFromJSON(json:Dynamic):ExposedValue
	{
		var clss:Class<Dynamic> = Type.resolveClass(json.clss);
		var value:ExposedValue = Type.createInstance(clss, []);
		value.fromJSON(json);
		return value;
	}
	
}