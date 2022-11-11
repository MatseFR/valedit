package valedit;
import openfl.errors.Error;
import openfl.events.Event;
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
	public var isEditable:Bool = true;
	public var name:String;
	public var object(get, set):Dynamic;
	public var parentValue:ExposedValue;
	public var uiControl(get, set):IValueUI;
	public var updateCollectionUIOnChange:Bool = true;
	public var value(get, set):Dynamic;
	
	private var _collection:ExposedCollection;
	private function get_collection():ExposedCollection { return _collection; }
	private function set_collection(value:ExposedCollection):ExposedCollection
	{
		return _collection = value;
	}
	
	private var _object:Dynamic;
	private function get_object():Dynamic { return _object; }
	private function set_object(value:Dynamic):Dynamic
	{
		if (_object == value) return value;
		_object = value;
		_storedValue = null;
		//dispatchEvent(new Event(Event.CHANGE));
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
			return defaultValue;
		}
		else
		{
			return Reflect.getProperty(_object, name);
		}
	}
	private function set_value(value:Dynamic):Dynamic
	{
		if (_object == null)
		{
			defaultValue = value;
		}
		else if (_storedValue != value)
		{
			_storedValue = value;
			Reflect.setProperty(_object, name, value);
			if (parentValue != null) parentValue.childValueChanged();
			if (updateCollectionUIOnChange) _collection.uiCollection.update(_uiControl);
		}
		return value;
	}
	
	private var _storedValue:Dynamic;
	private var _childValues:Array<ExposedValue> = new Array<ExposedValue>();
	
	/**
	   
	   @param	name
	**/
	public function new(name:String) 
	{
		super();
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
	}
	
}