package valedit;
import openfl.display.DisplayObjectContainer;
import openfl.errors.Error;
import valedit.ui.UICollection;
import valedit.value.ExposedGroup;

/**
 * ...
 * @author Matse
 */
class ExposedCollection 
{
	public var object(get, set):Dynamic;
	public var parentValue(get, set):ExposedValue;
	public var uiCollection(default, null):UICollection;
	public var uiContainer(get, set):DisplayObjectContainer;
	
	private var _object:Dynamic;
	private function get_object():Dynamic { return _object; }
	private function set_object(value:Dynamic):Dynamic
	{
		if (_object == value) return value;
		for (val in _valueList)
		{
			val.object = value;
		}
		return _object = value;
	}
	
	private var _parentValue:ExposedValue;
	private function get_parentValue():ExposedValue { return _parentValue; }
	private function set_parentValue(value:ExposedValue):ExposedValue
	{
		if (_parentValue == value) return value;
		if (_parentValue != null)
		{
			for (val in _valueList)
			{
				_parentValue.removeChildValue(val);
			}
		}
		
		if (value != null)
		{
			for (val in _valueList)
			{
				value.addChildValue(val);
			}
		}
		
		for (val in _valueList)
		{
			val.parentValue = value;
		}
		return _parentValue = value;
	}
	
	private var _uiContainer:DisplayObjectContainer;
	private function get_uiContainer():DisplayObjectContainer { return _uiContainer; }
	private function set_uiContainer(value:DisplayObjectContainer):DisplayObjectContainer
	{
		if (uiCollection == null) buildUI();
		uiCollection.uiContainer = value;
		return _uiContainer = value;
	}
	
	private var _groupList:Array<ExposedGroup> = new Array<ExposedGroup>();
	private var _groupMap:Map<String, ExposedGroup> = new Map<String, ExposedGroup>();
	private var _valueList:Array<ExposedValue> = new Array<ExposedValue>();
	private var _valueMap:Map<String, ExposedValue> = new Map<String, ExposedValue>();
	
	/**
	   
	**/
	public function new() 
	{
		
	}
	
	/**
	   
	   @param	value
	   @param	groupName
	**/
	public function addValue(value:ExposedValue, groupName:String = null):Void
	{
		value.collection = this;
		if (groupName != null)
		{
			_groupMap[groupName].addValue(value);
		}
		else
		{
			_valueList.push(value);
			_valueMap[value.propertyName] = value;
			if (Std.isOfType(value, ExposedGroup))
			{
				_groupList.push(cast value);
				_groupMap[value.name] = cast value;
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
		if (groupName != null)
		{
			_groupMap[groupName].addValueAfter(value, afterValueName);
		}
		else
		{
			var afterValue:ExposedValue = _valueMap[afterValueName];
			if (afterValue == null)
			{
				throw new Error("ExposedCollection.addValueAfter ::: no value with name " + afterValueName);
			}
			var index:Int = _valueList.indexOf(afterValue);
			_valueList.insert(index + 1, value);
			_valueMap[value.name] = value;
			if (Std.isOfType(value, ExposedGroup))
			{
				_groupList.push(cast value);
				_groupMap[value.name] = cast value;
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
		if (groupName != null)
		{
			_groupMap[groupName].addValueBefore(value, beforeValueName);
		}
		else
		{
			var beforeValue:ExposedValue = _valueMap[beforeValueName];
			if (beforeValue == null)
			{
				throw new Error("ExposedCollection.addValueBefore ::: no value with name " + beforeValueName);
			}
			var index:Int = _valueList.indexOf(beforeValue);
			_valueList.insert(index, value);
			_valueMap[value.name] = value;
			if (Std.isOfType(value, ExposedGroup))
			{
				_groupList.push(cast value);
				_groupMap[value.name] = cast value;
			}
		}
	}
	
	/**
	   
	**/
	public function buildUI():Void
	{
		if (uiCollection != null) return;
		
		uiCollection = new UICollection();
		
		for (value in _valueList)
		{
			uiCollection.addUI(ValEdit.toUIControl(value));
		}
	}
	
	/**
	   
	   @param	name
	   @param	includeSubGroups
	   @return
	**/
	public function getGroup(name:String, includeSubGroups:Bool = false):ExposedGroup
	{
		var group:ExposedGroup = _groupMap[name];
		if (group != null) return group;
		
		if (includeSubGroups)
		{
			for (grp in _groupList)
			{
				group = grp.getGroup(name);
				if (group != null) return group;
			}
		}
		return null;
	}
	
	/**
	   
	   @param	propertyName
	   @return
	**/
	public function getValue(propertyName:String):ExposedValue
	{
		var value:ExposedValue;
		if (_valueMap.exists(propertyName)) return _valueMap[propertyName];
		for (group in _groupList)
		{
			value = group.getValue(propertyName);
			if (value != null) return value;
		}
		return null;
	}
	
	/**
	   
	   @param	propertyName
	   @return
	**/
	public function hasValue(propertyName:String):Bool
	{
		if (_valueMap.exists(propertyName)) return true;
		for (group in _groupList)
		{
			if (group.hasValue(propertyName)) return true;
		}
		return false;
	}
	
	/**
	   
	   @param	value
	**/
	public function removeValue(value:ExposedValue):Void
	{
		removeValueByName(value.propertyName);
	}
	
	/**
	   
	   @param	name
	   @return
	**/
	public function removeValueByName(propertyName:String):ExposedValue
	{
		var value:ExposedValue;
		value = _valueMap[propertyName];
		if (value != null)
		{
			_valueList.remove(value);
			_valueMap.remove(propertyName);
			return value;
		}
		
		for (group in _groupList)
		{
			value = group.removeValueByName(propertyName);
			if (value != null) return value;
		}
		return null;
	}
	
	/**
	   
	   @return
	**/
	public function clone():ExposedCollection
	{
		var collection:ExposedCollection = new ExposedCollection();
		
		for (val in _valueList)
		{
			collection.addValue(val.clone());
		}
		
		return collection;
	}
	
}