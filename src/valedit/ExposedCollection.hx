package valedit;
import openfl.display.DisplayObjectContainer;
import openfl.errors.Error;
import openfl.events.EventDispatcher;
import valedit.animation.TweenData;
import valedit.animation.TweenProperties;
import valedit.events.ValueEvent;
import valedit.value.ExposedGroup;
import valedit.value.ExposedObject;
import valedit.value.base.ExposedValue;
import valedit.value.base.ExposedValueWithChildren;
#if valeditor
import valeditor.ValEditor;
import valeditor.ValEditorObject;
import valedit.ui.UICollection;
#end

/**
 * ...
 * @author Matse
 */
@:access(valedit.value.base.ExposedValue)
class ExposedCollection extends EventDispatcher
{
	static private var _POOL:Array<ExposedCollection> = new Array<ExposedCollection>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool():ExposedCollection
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new ExposedCollection();
	}
	
	public var applyIfDefaultValue:Bool = false;
	public var isEditable(get, set):Bool;
	public var isReadOnly(get, set):Bool;
	public var object(get, set):Dynamic;
	public var parentValue(get, set):ExposedValueWithChildren;
	#if valeditor
	public var uiCollection(default, null):UICollection;
	public var uiContainer(get, set):DisplayObjectContainer;
	public var valEditorObject(get, set):ValEditorObject;
	#end
	/* when true, prevents a changed value from updating other values in the collection */
	public var valuesUpdateLocked(get, set):Bool;
	
	private var _isEditable:Bool = true;
	private function get_isEditable():Bool { return this._isEditable; }
	private function set_isEditable(value:Bool):Bool
	{
		if (this._isEditable == value) return value;
		for (val in this._valueList)
		{
			val.isEditable = value;
		}
		return this._isEditable = value;
	}
	
	private var _isReadOnly:Bool = false;
	private function get_isReadOnly():Bool { return this._isReadOnly; }
	private function set_isReadOnly(value:Bool):Bool
	{
		if (this._isReadOnly == value) return value;
		for (val in this._valueList)
		{
			val.isReadOnlyInternal = value;
		}
		return this._isReadOnly = value;
	}
	
	private var _object:Dynamic;
	private function get_object():Dynamic { return _object; }
	private function set_object(value:Dynamic):Dynamic
	{
		if (this._object == value) return value;
		
		var wasUpdateLocked:Bool = this._valuesUpdateLocked;
		if (!wasUpdateLocked) this.valuesUpdateLocked = true;
		for (val in this._valueList)
		{
			val.object = value;
		}
		this.valuesUpdateLocked = wasUpdateLocked;
		return this._object = value;
	}
	
	private var _parentValue:ExposedValueWithChildren;
	private function get_parentValue():ExposedValueWithChildren { return _parentValue; }
	private function set_parentValue(value:ExposedValueWithChildren):ExposedValueWithChildren
	{
		if (this._parentValue == value) return value;
		if (this._parentValue != null)
		{
			for (val in this._valueList)
			{
				this._parentValue.removeChildValue(val);
			}
		}
		
		if (value != null)
		{
			for (val in this._valueList)
			{
				value.addChildValue(val);
			}
		}
		return this._parentValue = value;
	}
	
	#if valeditor
	private var _uiContainer:DisplayObjectContainer;
	private function get_uiContainer():DisplayObjectContainer { return _uiContainer; }
	private function set_uiContainer(value:DisplayObjectContainer):DisplayObjectContainer
	{
		if (this._uiContainer == value) return value;
		
		if (value != null && this.uiCollection == null)
		{
			buildUI();
			this.uiCollection.uiContainer = value;
		}
		else if (value == null && this.uiCollection != null)
		{
			this.uiCollection.pool();
			this.uiCollection = null;
		}
		return this._uiContainer = value;
	}
	
	private var _valEditorObject:ValEditorObject;
	private function get_valEditorObject():ValEditorObject { return this._valEditorObject; }
	private function set_valEditorObject(value:ValEditorObject):ValEditorObject
	{
		if (this._valEditorObject == value) return value;
		
		for (val in this._valueList)
		{
			val.valEditorObject = value;
		}
		return this._valEditorObject = value;
	}
	#end
	
	private var _valuesUpdateLocked:Bool = false;
	private function get_valuesUpdateLocked():Bool { return this._valuesUpdateLocked; }
	private function set_valuesUpdateLocked(value:Bool):Bool
	{
		if (this._valuesUpdateLocked == value) return value;
		
		this._valuesUpdateLocked = value;
		for (val in this._valueList)
		{
			val.updateCollectionLocked = this._valuesUpdateLocked;
		}
		return this._valuesUpdateLocked;
	}
	
	private var _groupList:Array<ExposedGroup> = new Array<ExposedGroup>();
	private var _groupMap:Map<String, ExposedGroup> = new Map<String, ExposedGroup>();
	private var _valueList:Array<ExposedValue> = new Array<ExposedValue>();
	private var _valueMap:Map<String, ExposedValue> = new Map<String, ExposedValue>();
	
	/**
	   
	**/
	public function new() 
	{
		super();
	}
	
	public function clear():Void
	{
		#if valeditor
		if (this.uiCollection != null)
		{
			this.uiCollection.pool();
			this.uiCollection = null;
		}
		this._valEditorObject = null;
		#end
		for (value in this._valueList)
		{
			value.pool();
		}
		this._valueList.resize(0);
		this._valueMap.clear();
		this._groupList.resize(0);
		this._groupMap.clear();
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	public function applyAndSetObject(object:Dynamic, ?applyIfDefaultValue:Bool):Void
	{
		this.object = object;
		applyToObject(object, applyIfDefaultValue);
	}
	
	public function readAndSetObject(object:Dynamic):Void
	{
		this.object = object;
		readValuesFromObject(object);
	}
	
	public function applyToObject(object:Dynamic, ?applyIfDefaultValue:Bool):Void
	{
		if (applyIfDefaultValue == null)
		{
			applyIfDefaultValue = this.applyIfDefaultValue;
		}
		
		for (value in this._valueList)
		{
			value.applyToObject(object, applyIfDefaultValue);
		}
	}
	
	public function checkForObjectMatch(otherCollection:ExposedCollection):Bool
	{
		var otherGroup:ExposedGroup;
		var otherValue:ExposedValue;
		var group:ExposedGroup;
		
		for (value in this._valueList)
		{
			if (!value.isRealValue) continue;
			if (value.isGroup)
			{
				group = cast value;
				otherGroup = otherCollection.getGroup(group.name);
				if (!group.checkForObjectMatch(otherGroup)) return false;
			}
			else if (value.useForObjectMatching)
			{
				otherValue = otherCollection.getValue(value.propertyName);
				if (value.value != otherValue.value) return false;
			}
		}
		
		return true;
		
	}
	
	/* Looks for corresponding exposed values in fromCollection and copies their values */
	public function copyValuesFrom(fromCollection:ExposedCollection):Void
	{
		var fromGroup:ExposedGroup;
		var fromValue:ExposedValue;
		var group:ExposedGroup;
		
		for (value in this._valueList)
		{
			if (!value.isRealValue) continue;
			if (value.isGroup)
			{
				group = cast value;
				fromGroup = fromCollection.getGroup(group.name);
				if (fromGroup != null)
				{
					group.copyValuesFrom(fromGroup);
				}
			}
			else
			{
				fromValue = fromCollection.getValue(value.propertyName);
				if (fromValue != null)
				{
					value.value = fromValue.value;
				}
			}
		}
	}
	
	/* Looks for corresponding exposed values in toCollection and copies its values */
	public function copyValuesTo(toCollection:ExposedCollection):Void
	{
		var toGroup:ExposedGroup;
		var toValue:ExposedValue;
		var group:ExposedGroup;
		
		for (value in this._valueList)
		{
			if (!value.isRealValue) continue;
			if (value.isGroup)
			{
				group = cast value;
				toGroup = toCollection.getGroup(group.name);
				if (toGroup != null)
				{
					group.copyValuesTo(toGroup);
				}
			}
			else
			{
				toValue = toCollection.getValue(value.propertyName);
				if (toValue != null)
				{
					toValue.value = value.value;
				}
			}
		}
	}
	
	public function readValues(dispatchEventIfChange:Bool = true):Void
	{
		for (value in this._valueList)
		{
			value.readValue(dispatchEventIfChange);
		}
	}
	
	public function readValuesFromObject(object:Dynamic, dispatchEventIfChange:Bool = true):Void
	{
		for (value in this._valueList)
		{
			value.readValueFromObject(object, dispatchEventIfChange);
		}
	}
	
	public function restoreDefaultValues():Void
	{
		for (value in this._valueList)
		{
			value.restoreDefaultValue();
		}
	}
	
	private function onValueChange(evt:ValueEvent):Void
	{
		this.dispatchEvent(evt);
	}
	
	/**
	   
	   @param	value
	   @param	groupName
	**/
	public function addValue(value:ExposedValue, groupName:String = null):Void
	{
		value.collection = this;
		value.updateCollectionLocked = this._valuesUpdateLocked;
		if (value.isRealValue) value.addEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
		if (groupName != null)
		{
			this._groupMap[groupName].addValue(value);
		}
		else
		{
			value.isEditable = this._isEditable;
			value.isReadOnlyInternal = this._isReadOnly;
			this._valueList.push(value);
			this._valueMap[value.propertyName] = value;
			if (Std.isOfType(value, ExposedGroup))
			{
				this._groupList.push(cast value);
				this._groupMap[value.propertyName] = cast value;
			}
		}
	}
	
	/**
	 * 
	 * @param	value
	 * @param	afterValueName	the propertyName of the ExposedValue
	 * @param	groupName
	 */
	public function addValueAfter(value:ExposedValue, afterValueName:String, groupName:String = null):Void
	{
		value.collection = this;
		value.updateCollectionLocked = this._valuesUpdateLocked;
		if (value.isRealValue) value.addEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
		if (groupName != null)
		{
			this._groupMap[groupName].addValueAfter(value, afterValueName);
		}
		else
		{
			value.isEditable = this._isEditable;
			value.isReadOnlyInternal = this._isReadOnly;
			var afterValue:ExposedValue = this._valueMap[afterValueName];
			if (afterValue == null)
			{
				throw new Error("ExposedCollection.addValueAfter ::: no value with name " + afterValueName);
			}
			var index:Int = this._valueList.indexOf(afterValue);
			this._valueList.insert(index + 1, value);
			this._valueMap[value.propertyName] = value;
			if (Std.isOfType(value, ExposedGroup))
			{
				this._groupList.push(cast value);
				this._groupMap[value.propertyName] = cast value;
			}
		}
	}
	
	/**
	 * 
	 * @param	value
	 * @param	beforeValueName	the propertyName of the ExposedValue
	 * @param	groupName
	 */
	public function addValueBefore(value:ExposedValue, beforeValueName:String, groupName:String = null):Void
	{
		value.collection = this;
		value.updateCollectionLocked = this._valuesUpdateLocked;
		if (value.isRealValue) value.addEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
		if (groupName != null)
		{
			this._groupMap[groupName].addValueBefore(value, beforeValueName);
		}
		else
		{
			value.isEditable = this._isEditable;
			value.isReadOnlyInternal = this._isReadOnly;
			var beforeValue:ExposedValue = this._valueMap[beforeValueName];
			if (beforeValue == null)
			{
				throw new Error("ExposedCollection.addValueBefore ::: no value with name " + beforeValueName);
			}
			var index:Int = this._valueList.indexOf(beforeValue);
			this._valueList.insert(index, value);
			this._valueMap[value.propertyName] = value;
			if (Std.isOfType(value, ExposedGroup))
			{
				this._groupList.push(cast value);
				this._groupMap[value.propertyName] = cast value;
			}
		}
	}
	
	#if valeditor
	public function buildUI():Void
	{
		if (this.uiCollection != null) return;
		
		this.uiCollection = UICollection.fromPool();
		
		for (value in this._valueList)
		{
			if (!value.visible) continue;
			this.uiCollection.addUI(ValEditor.toUIControl(value));
		}
	}
	
	private function checkGroupsVisibility():Void
	{
		for (group in this._groupList)
		{
			group.checkVisibility();
		}
	}
	
	public function setVisible(propertyName:String, visible:Bool):Void
	{
		var value:ExposedValue = getValue(propertyName);
		value.visible = visible;
		checkGroupsVisibility();
		
		if (this.uiCollection != null)
		{
			var container:DisplayObjectContainer = this._uiContainer;
			this.uiContainer = null;
			this.uiContainer = container;
		}
	}
	
	public function setVisibleAll(visible:Bool):Void
	{
		for (value in this._valueList)
		{
			value.visible = visible;
		}
		checkGroupsVisibility();
		
		if (this.uiCollection != null)
		{
			var container:DisplayObjectContainer = this._uiContainer;
			this.uiContainer = null;
			this.uiContainer = container;
		}
	}
	
	public function setVisibleArray(propertyNames:Array<String>, visible:Bool):Void
	{
		var value:ExposedValue;
		for (propertyName in propertyNames)
		{
			value = getValue(propertyName);
			value.visible = visible;
		}
		
		checkGroupsVisibility();
		
		if (this.uiCollection != null)
		{
			var container:DisplayObjectContainer = this._uiContainer;
			this.uiContainer = null;
			this.uiContainer = container;
		}
	}
	#end
	
	public function getGroup(name:String, includeSubGroups:Bool = false):ExposedGroup
	{
		var group:ExposedGroup = this._groupMap[name];
		if (group != null) return group;
		
		if (includeSubGroups)
		{
			for (grp in this._groupList)
			{
				group = grp.getGroup(name);
				if (group != null) return group;
			}
		}
		return null;
	}
	
	public function getValue(propertyName:String):ExposedValue
	{
		var value:ExposedValue;
		if (this._valueMap.exists(propertyName)) return this._valueMap[propertyName];
		for (group in this._groupList)
		{
			value = group.getValue(propertyName);
			if (value != null) return value;
		}
		return null;
	}
	
	public function hasValue(propertyName:String):Bool
	{
		if (this._valueMap.exists(propertyName)) return true;
		for (group in this._groupList)
		{
			if (group.hasValue(propertyName)) return true;
		}
		return false;
	}
	
	public function removeValue(value:ExposedValue):Void
	{
		removeValueByName(value.propertyName);
	}
	
	public function removeValueByName(propertyName:String):ExposedValue
	{
		var value:ExposedValue = this._valueMap[propertyName];
		if (value != null)
		{
			if (value.isRealValue) value.removeEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
			this._valueList.remove(value);
			this._valueMap.remove(propertyName);
			return value;
		}
		
		for (group in this._groupList)
		{
			value = group.removeValueByName(propertyName);
			if (value != null)
			{
				if (value.isRealValue) value.removeEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
				return value;
			}
		}
		return null;
	}
	
	/**
	   Useful to create a constructor parameters array
	**/
	public function toValueArray(?values:Array<Dynamic>):Array<Dynamic>
	{
		if (values == null) values = new Array<Dynamic>();
		
		for (value in this._valueList)
		{
			value.toValueArray(values);
		}
		
		return values;
	}
	
	public function getTweenData(targetCollection:ExposedCollection, tweenData:TweenData = null, object:Dynamic = null):TweenData
	{
		if (tweenData == null) tweenData = TweenData.fromPool();
		var targetValue:ExposedValue;
		var tweenProperties:TweenProperties;
		if (object == null)
		{
			tweenProperties = tweenData.addObject(this._object);
		}
		else
		{
			tweenProperties = tweenData.addObject(object);
		}
		
		for (value in this._valueList)
		{
			if (value.isGroup)
			{
				cast(value, ExposedGroup).getTweenData(tweenData, tweenProperties, targetCollection.getGroup(value.propertyName));
			}
			else if (value.isTweenable)
			{
				if (Std.isOfType(value, ExposedObject))
				{
					cast(value, ExposedObject).getTweenData(tweenData, cast targetCollection.getValue(value.propertyName));
				}
				else
				{
					targetValue = targetCollection.getValue(value.propertyName);
					if (value.value != targetValue.value)
					{
						tweenProperties.addProperty(value.propertyName, value.value, targetValue.value);
					}
				}
			}
		}
		
		return tweenData;
	}
	
	public function clone(copyValues:Bool = false):ExposedCollection
	{
		var collection:ExposedCollection = new ExposedCollection();
		
		for (val in this._valueList)
		{
			collection.addValue(val.clone(copyValues));
		}
		
		return collection;
	}
	
	public function loadComplete():Void
	{
		for (value in this._valueList)
		{
			if (!value.isRealValue)
			{
				value.loadComplete();
			}
		}
	}
	
	public function fromJSON(json:Dynamic):Void
	{
		if (json.values != null)
		{
			var data:Array<Dynamic> = json.values;
			var value:ExposedValue;
			for (node in data)
			{
				value = ExposedValue.valueFromJSON(node);
				addValue(value);
			}
		}
	}
	
	public function fromJSONSave(json:Dynamic):Void
	{
		var data:Dynamic;
		var values:Dynamic = json.values;
		for (value in this._valueList)
		{
			data = Reflect.field(values, value.propertyName);
			if (data != null)
			{
				value.fromJSONSave(data);
			}
		}
	}
	
	public function toJSON(json:Dynamic = null):Dynamic
	{
		if (json == null) json = {};
		
		if (this._valueList.length != 0)
		{
			var data:Array<Dynamic> = new Array<Dynamic>();
			var valueJson:Dynamic;
			for (value in this._valueList)
			{
				valueJson = value.toJSON();
				if (valueJson != null) data.push(valueJson);
			}
			json.values = data;
		}
		
		return json;
	}
	
	/**
	   
	   @param	json
	   @param	includeNotVisible	if true, exposed values with visible = false are included
	   @param	refCollection	if not null, only exposed values with different values are included
	   @return
	**/
	public function toJSONSave(json:Dynamic = null, includeNotVisible:Bool = false, refCollection:ExposedCollection = null):Dynamic
	{
		if (json == null) json = {};
		
		var refValue:ExposedValue;
		var values:Dynamic = {};
		for (value in this._valueList)
		{
			if (!value.isRealValue) continue;
			if (!includeNotVisible && !value.visible) continue;
			if (refCollection != null)
			{
				refValue = refCollection.getValue(value.propertyName);
				if (refValue.value == value.value)
				{
					continue;
				}
			}
			value.toJSONSave(values);
		}
		json.values = values;
		
		return json;
	}
	
	public function toJSONSimple(json:Dynamic = null):Dynamic
	{
		if (json == null) json = {};
		
		for (value in this._valueList)
		{
			value.toJSONSimple(json);
		}
		
		return json;
	}
	
}