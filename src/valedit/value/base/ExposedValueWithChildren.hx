package valedit.value.base;

import valedit.value.base.ExposedValue;
import valedit.events.ValueEvent;

/**
 * ...
 * @author Matse
 */
abstract class ExposedValueWithChildren extends ExposedValue 
{
	override function set_isEditable(value:Bool):Bool 
	{
		if (this._isEditable == value) return value;
		this._isEditable = value;
		ValueEvent.dispatch(this, ValueEvent.EDITABLE_CHANGE, this);
		for (val in this._childValues)
		{
			val.isEditable = this._isEditable;
		}
		return this._isEditable;
	}
	
	override function set_isReadOnly(value:Bool):Bool 
	{
		if (this._isReadOnlyLocked || this._isReadOnly == value) return value;
		this._isReadOnly = value;
		ValueEvent.dispatch(this, ValueEvent.ACCESS_CHANGE, this);
		for (val in this._childValues)
		{
			val.isReadOnly = this._isReadOnly;
		}
		return this._isReadOnly;
	}
	
	override function set_isReadOnlyLocked(value:Bool):Bool 
	{
		if (this._isReadOnlyLocked == value) return value;
		for (val in this._childValues)
		{
			val.isReadOnlyLocked = value;
		}
		return this._isReadOnlyLocked = value;
	}
	
	private var _childValues:Array<ExposedValue> = new Array<ExposedValue>();

	public function new(propertyName:String, name:String=null) 
	{
		super(propertyName, name);
	}
	
	public function addChildValue(value:ExposedValue):Void
	{
		value.parentValue = this;
		this._childValues.push(value);
	}
	
	public function removeChildValue(value:ExposedValue):Void
	{
		value.parentValue = null;
		this._childValues.remove(value);
	}
	
	public function childValueChanged():Void
	{
		this._collection.readValues();
		if (this.parentValue != null) this.parentValue.childValueChanged();
	}
	
	override public function applyToObject(object:Dynamic, applyIfDefaultValue:Bool = false):Void 
	{
		super.applyToObject(object, applyIfDefaultValue);
		
		for (value in this._childValues)
		{
			value.applyToObject(object, applyIfDefaultValue);
		}
	}
	
	override public function readValue(dispatchEventIfChange:Bool = true):Void 
	{
		super.readValue(dispatchEventIfChange);
		
		for (value in this._childValues)
		{
			value.readValue(dispatchEventIfChange);
		}
	}
	
	override public function forceReadOnly(value:Bool):Void 
	{
		super.forceReadOnly(value);
		
		for (val in this._childValues)
		{
			val.forceReadOnly(value);
		}
	}
	
	override public function setReadOnlyAndLock(value:Bool):Void 
	{
		super.setReadOnlyAndLock(value);
		
		for (val in this._childValues)
		{
			val.setReadOnlyAndLock(value);
		}
	}
	
}