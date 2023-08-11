package valedit;
import openfl.display.DisplayObjectContainer;
import openfl.errors.Error;
import openfl.events.EventDispatcher;
import valedit.animation.TweenProperties;
import valedit.events.ValueEvent;
import valedit.value.ExposedGroup;
import valedit.value.base.ExposedValue;
import valedit.value.base.ExposedValueWithChildren;
#if valeditor
import valeditor.ValEditor;
import valedit.ui.UICollection;
#end

/**
 * ...
 * @author Matse
 */
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
	
	public var isEditable(get, set):Bool;
	public var isReadOnly(get, set):Bool;
	public var object(get, set):Dynamic;
	public var parentValue(get, set):ExposedValueWithChildren;
	#if valeditor
	public var uiCollection(default, null):UICollection;
	public var uiContainer(get, set):DisplayObjectContainer;
	#end
	
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
			val.isReadOnly = value;
		}
		return this._isReadOnly = value;
	}
	
	private var _object:Dynamic;
	private function get_object():Dynamic { return _object; }
	private function set_object(value:Dynamic):Dynamic
	{
		if (this._object == value) return value;
		for (val in this._valueList)
		{
			val.object = value;
		}
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
	#end
	
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
	
	//public function dispose():Void
	//{
		//
	//}
	
	public function applyToObject(object:Dynamic):Void
	{
		for (value in this._valueList)
		{
			value.applyToObject(object);
		}
	}
	
	public function readValues():Void
	{
		for (value in this._valueList)
		{
			value.readValue();
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
		value.addEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
		if (groupName != null)
		{
			this._groupMap[groupName].addValue(value);
		}
		else
		{
			value.isEditable = this._isEditable;
			value.isReadOnly = this._isReadOnly;
			this._valueList.push(value);
			this._valueMap[value.propertyName] = value;
			if (Std.isOfType(value, ExposedGroup))
			{
				this._groupList.push(cast value);
				this._groupMap[value.name] = cast value;
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
		value.addEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
		if (groupName != null)
		{
			this._groupMap[groupName].addValueAfter(value, afterValueName);
		}
		else
		{
			value.isEditable = this._isEditable;
			value.isReadOnly = this._isReadOnly;
			var afterValue:ExposedValue = this._valueMap[afterValueName];
			if (afterValue == null)
			{
				throw new Error("ExposedCollection.addValueAfter ::: no value with name " + afterValueName);
			}
			var index:Int = this._valueList.indexOf(afterValue);
			this._valueList.insert(index + 1, value);
			this._valueMap[value.name] = value;
			if (Std.isOfType(value, ExposedGroup))
			{
				this._groupList.push(cast value);
				this._groupMap[value.name] = cast value;
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
		value.addEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
		if (groupName != null)
		{
			this._groupMap[groupName].addValueBefore(value, beforeValueName);
		}
		else
		{
			value.isEditable = this._isEditable;
			value.isReadOnly = this._isReadOnly;
			var beforeValue:ExposedValue = this._valueMap[beforeValueName];
			if (beforeValue == null)
			{
				throw new Error("ExposedCollection.addValueBefore ::: no value with name " + beforeValueName);
			}
			var index:Int = this._valueList.indexOf(beforeValue);
			this._valueList.insert(index, value);
			this._valueMap[value.name] = value;
			if (Std.isOfType(value, ExposedGroup))
			{
				this._groupList.push(cast value);
				this._groupMap[value.name] = cast value;
			}
		}
	}
	
	#if valeditor
	public function buildUI():Void
	{
		if (this.uiCollection != null) return;
		
		this.uiCollection = new UICollection();
		
		for (value in this._valueList)
		{
			this.uiCollection.addUI(ValEditor.toUIControl(value));
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
		var value:ExposedValue;
		value = this._valueMap[propertyName];
		if (value != null)
		{
			value.removeEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
			this._valueList.remove(value);
			this._valueMap.remove(propertyName);
			return value;
		}
		
		for (group in this._groupList)
		{
			value = group.removeValueByName(propertyName);
			if (value != null)
			{
				value.removeEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
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
	
	public function getTweenProperties(targetCollection:ExposedCollection):TweenProperties
	{
		var targetValue:ExposedValue;
		var tweenProperties:TweenProperties = TweenProperties.fromPool();
		for (value in this._valueList)
		{
			if (value.isGroup)
			{
				cast(value, ExposedGroup).getTweenProperties(targetCollection.getGroup(value.name), tweenProperties);
			}
			else if (value.isTweenable)
			{
				targetValue = targetCollection.getValue(value.name);
				if (value.value != targetValue.value)
				{
					tweenProperties.addProperty(value.name, targetValue.value);
				}
			}
		}
		
		if (tweenProperties.numProperties != 0)
		{
			return tweenProperties;
		}
		else
		{
			tweenProperties.pool();
			return null;
		}
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