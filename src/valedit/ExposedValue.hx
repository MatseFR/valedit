package valedit;
import openfl.errors.Error;
import openfl.events.EventDispatcher;
import valedit.events.ValueEvent;
import valedit.ui.IValueUI;

/**
 * ...
 * @author Matse
 */
class ExposedValue extends EventDispatcher
{
	public var collection(get, set):ExposedCollection;
	/* used as value when object is null */
	public var defaultValue:Dynamic = null;
	public var isEditable(get, set):Bool;
	public var name:String;
	public var object(get, set):Dynamic;
	public var parentValue:ExposedValue;
	public var propertyName:String;
	public var uiControl(get, set):IValueUI;
	public var updateCollectionUIOnChange:Bool = true;
	public var value(get, set):Dynamic;
	
	private var _collection:ExposedCollection;
	private function get_collection():ExposedCollection { return _collection; }
	private function set_collection(value:ExposedCollection):ExposedCollection
	{
		return _collection = value;
	}
	
	private var _isEditable:Bool = true;
	private function get_isEditable():Bool { return _isEditable; }
	private function set_isEditable(value:Bool):Bool
	{
		if (_isEditable == value) return value;
		_isEditable = value;
		ValueEvent.dispatch(this, ValueEvent.EDITABLE_CHANGE);
		for (val in _childValues)
		{
			val.isEditable = _isEditable;
		}
		return _isEditable;
	}
	
	private var _object:Dynamic;
	private function get_object():Dynamic { return _object; }
	private function set_object(value:Dynamic):Dynamic
	{
		if (_object == value) return value;
		var nullObject:Bool = _object == null;
		_object = value;
		if (nullObject && _storedValue != null)
		{
			Reflect.setProperty(_object, propertyName, _storedValue);
		}
		_storedValue = null;
		ValueEvent.dispatch(this, ValueEvent.OBJECT_CHANGE);
		return _object;
	}
	
	private var _uiControl:IValueUI;
	private function get_uiControl():IValueUI { return _uiControl; }
	private function set_uiControl(value:IValueUI):IValueUI
	{
		if (_uiControl == value) return value;
		if (value != null)
		{
			value.exposedValue = this;
		}
		return _uiControl = value;
	}
	
	private function get_value():Dynamic
	{
		if (_object == null)
		{
			return _storedValue == null ? defaultValue : _storedValue;
		}
		else
		{
			return Reflect.getProperty(_object, propertyName);
		}
	}
	private function set_value(value:Dynamic):Dynamic
	{
		if (_object == null)
		{
			_storedValue = value;
		}
		else if (_storedValue != value)
		{
			_storedValue = value;
			Reflect.setProperty(_object, propertyName, value);
			if (parentValue != null) parentValue.childValueChanged();
			if (updateCollectionUIOnChange) _collection.uiCollection.update(_uiControl);
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
	}
	
	/**
	   
	**/
	public function clear():Void
	{
		_object = null;
	}
	
	/**
	   
	   @param	value
	**/
	public function addChildValue(value:ExposedValue):Void
	{
		_childValues.push(value);
	}
	
	/**
	   
	   @param	value
	**/
	public function removeChildValue(value:ExposedValue):Void
	{
		_childValues.remove(value);
	}
	
	/**
	   
	**/
	public function childValueChanged():Void
	{
		if (updateCollectionUIOnChange) 
		{
			_collection.uiCollection.update(_uiControl);
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
		value.defaultValue = defaultValue;
		value.isEditable = isEditable;
		value.updateCollectionUIOnChange = updateCollectionUIOnChange;
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