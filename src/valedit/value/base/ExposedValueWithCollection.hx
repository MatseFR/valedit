package valedit.value.base;

import valedit.animation.TweenData;
import valedit.value.base.ExposedValue;
import valedit.events.ValueEvent;

/**
 * ...
 * @author Matse
 */
@:access(valedit.ExposedCollection)
abstract class ExposedValueWithCollection extends ExposedValue 
{
	public var childCollection(get, set):ExposedCollection;
	
	private var _childCollection:ExposedCollection;
	private function get_childCollection() { return this._childCollection; }
	private function set_childCollection(value:ExposedCollection):ExposedCollection
	{
		if (this._childCollection == value) return value;
		if (this._childCollection != null)
		{
			this._childCollection.removeEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
		}
		this._childCollection = value;
		if (this._childCollection != null)
		{
			this._childCollection.parentValue = this;
			this._childCollection.valEditorObject = this._valEditorObject;
			this._childCollection.isEditable = this._isEditable;
			this._childCollection.isReadOnly = this._isReadOnly;
			this._childCollection.isReadOnlyInternal = this._isReadOnlyInternal;
			applyNonTweenableProperties();
			applyNonTweenableDeepProperties();
			this._childCollection.addEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
		}
		return this._childCollection;
	}
	
	override function set_isEditable(value:Bool):Bool 
	{
		if (this._isEditable == value) return value;
		this._isEditable = value;
		ValueEvent.dispatch(this, ValueEvent.EDITABLE_CHANGE, this);
		if (this._childCollection != null)
		{
			this._childCollection.isEditable = this._isEditable;
		}
		return this._isEditable;
	}
	
	override function set_isReadOnly(value:Bool):Bool 
	{
		if (this._isReadOnly == value) return value;
		this._isReadOnly = value;
		ValueEvent.dispatch(this, ValueEvent.ACCESS_CHANGE, this);
		if (this._childCollection != null)
		{
			this._childCollection.isReadOnly = this._isReadOnly;
		}
		return this._isReadOnly;
	}
	
	override function set_isReadOnlyInternal(value:Bool):Bool 
	{
		if (this._isReadOnlyInternal == value) return value;
		this._isReadOnlyInternal = value;
		ValueEvent.dispatch(this, ValueEvent.ACCESS_CHANGE, this);
		if (this._childCollection != null)
		{
			this._childCollection.isReadOnlyInternal = this._isReadOnlyInternal;
		}
		return this._isReadOnlyInternal;
	}
	
	private var _childCollectionSaveData:Dynamic;
	private var _hasNonTweenableProperty:Bool = false;
	private var _nonTweenablePropertyNames:Array<String> = new Array<String>();
	private var _hasNonTweenableDeepProperty:Bool = false;
	private var _nonTweenableDeepPropertyNames:Array<Array<String>> = new Array<Array<String>>();

	public function new(propertyName:String, name:String=null) 
	{
		super(propertyName, name);
	}
	
	override public function clear():Void 
	{
		if (this._childCollection != null)
		{
			this._childCollection.pool();
			this.childCollection = null;
		}
		this._childCollectionSaveData = null;
		this._hasNonTweenableProperty = false;
		this._nonTweenablePropertyNames.resize(0);
		this._hasNonTweenableDeepProperty = false;
		this._nonTweenableDeepPropertyNames.resize(0);
		super.clear();
	}
	
	public function addNonTweenablePropertyName(propertyName:String):Void
	{
		this._hasNonTweenableProperty = true;
		this._nonTweenablePropertyNames[this._nonTweenablePropertyNames.length] = propertyName;
		if (this._childCollection != null)
		{
			applyNonTweenableProperty(propertyName);
		}
	}
	
	public function addNonTweenablePropertyNames(propertyNames:Array<String>):Void
	{
		if (propertyNames.length != 0) this._hasNonTweenableProperty = true;
		
		if (this._childCollection == null)
		{
			for (propertyName in propertyNames)
			{
				this._nonTweenablePropertyNames[this._nonTweenablePropertyNames.length] = propertyName;
			}
		}
		else
		{
			for (propertyName in propertyNames)
			{
				this._nonTweenablePropertyNames[this._nonTweenablePropertyNames.length] = propertyName;
				applyNonTweenableProperty(propertyName);
			}
		}
	}
	
	private function applyNonTweenableProperties():Void
	{
		for (propertyName in this._nonTweenablePropertyNames)
		{
			applyNonTweenableProperty(propertyName);
		}
	}
	
	private function applyNonTweenableProperty(propertyName:String):Void
	{
		var value:ExposedValue = this._childCollection.getValue(propertyName);
		value.isTweenable = false;
	}
	
	public function addNonTweenableDeepPropertyName(propertyName:Array<String>):Void
	{
		this._hasNonTweenableDeepProperty = true;
		this._nonTweenableDeepPropertyNames[this._nonTweenableDeepPropertyNames.length] = propertyName;
		if (this._childCollection != null)
		{
			applyNonTweenableDeepProperty(propertyName);
		}
	}
	
	public function addNonTweenableDeepPropertyNames(propertyNames:Array<Array<String>>):Void
	{
		if (propertyNames.length != 0) this._hasNonTweenableDeepProperty = true;
		
		if (this._childCollection == null)
		{
			for (propertyName in propertyNames)
			{
				this._nonTweenableDeepPropertyNames[this._nonTweenableDeepPropertyNames.length] = propertyName;
			}
		}
		else
		{
			for (propertyName in propertyNames)
			{
				this._nonTweenableDeepPropertyNames[this._nonTweenableDeepPropertyNames.length] = propertyName;
				applyNonTweenableDeepProperty(propertyName);
			}
		}
	}
	
	private function applyNonTweenableDeepProperties():Void
	{
		for (propertyName in this._nonTweenableDeepPropertyNames)
		{
			applyNonTweenableDeepProperty(propertyName);
		}
	}
	
	private function applyNonTweenableDeepProperty(propertyName:Array<String>):Void
	{
		var parentValue:ExposedValueWithCollection = cast this._childCollection.getValue(propertyName[0]);
		if (propertyName.length == 2)
		{
			parentValue.addNonTweenablePropertyName(propertyName[1]);
		}
		else
		{
			parentValue.addNonTweenableDeepPropertyName(propertyName.slice(1));
		}
	}
	
	public function getTweenData(tweenData:TweenData, targetValue:ExposedValueWithCollection):Bool
	{
		if (this._childCollection != null && targetValue._childCollection != null)
		{
			return this._childCollection.getTweenData(targetValue._childCollection, tweenData);
		}
		
		return false;
	}
	
	private function onValueChange(evt:ValueEvent):Void
	{
		dispatchEvent(evt);
	}
	
	public function childValueChanged(value:ExposedValue):Void
	{
		this._collection.readValues();
		this._childCollection.readValues();
		if (this.parentValue != null) this.parentValue.childValueChanged(value);
	}
	
	override public function applyToObject(object:Dynamic, applyIfDefaultValue:Bool = false):Void 
	{
		super.applyToObject(object, applyIfDefaultValue);
		
		if (this._childCollection != null)
		{
			this._childCollection.applyToObject(object, applyIfDefaultValue);
		}
	}
	
	override public function readValue(dispatchEventIfChange:Bool = true):Void 
	{
		super.readValue(dispatchEventIfChange);
		
		if (this._childCollection != null)
		{
			this._childCollection.readValues(dispatchEventIfChange);
		}
	}
	
	override function clone_internal(value:ExposedValue, copyValue:Bool = false):Void 
	{
		var collectionValue:ExposedValueWithCollection = cast value;
		if (this._nonTweenablePropertyNames.length != 0)
		{
			collectionValue.addNonTweenablePropertyNames(this._nonTweenablePropertyNames);
		}
		if (this._nonTweenableDeepPropertyNames.length != 0)
		{
			collectionValue.addNonTweenableDeepPropertyNames(this._nonTweenableDeepPropertyNames);
		}
		super.clone_internal(value, copyValue);
	}
	
	override public function fromJSONSave(json:Dynamic):Void 
	{
		if (this._childCollection == null)
		{
			// store collection data, it will be applied to the collection when it will be created
			this._childCollectionSaveData = json.collection;
		}
		else
		{
			this._childCollection.fromJSONSave(json.collection);
		}
	}
	
	override public function toJSONSave(json:Dynamic):Void
	{
		var data:Dynamic = {};
		if (this._childCollection != null)
		{
			var collectionData:Dynamic = {};
			this._childCollection.toJSONSave(collectionData);
			data.collection = collectionData;
		}
		Reflect.setField(json, this.propertyName, data);
	}
	
}