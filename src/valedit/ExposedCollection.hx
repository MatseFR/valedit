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
		if (this._object == value) return value;
		for (val in this._valueList)
		{
			val.object = value;
		}
		return this._object = value;
	}
	
	private var _parentValue:ExposedValue;
	private function get_parentValue():ExposedValue { return _parentValue; }
	private function set_parentValue(value:ExposedValue):ExposedValue
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
		
		for (val in this._valueList)
		{
			val.parentValue = value;
		}
		return this._parentValue = value;
	}
	
	private var _uiContainer:DisplayObjectContainer;
	private function get_uiContainer():DisplayObjectContainer { return _uiContainer; }
	private function set_uiContainer(value:DisplayObjectContainer):DisplayObjectContainer
	{
		if (this.uiCollection == null) buildUI();
		this.uiCollection.uiContainer = value;
		return this._uiContainer = value;
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
	
	public function clear():Void
	{
		
	}
	
	public function dispose():Void
	{
		
	}
	
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
	
	/**
	   
	   @param	value
	   @param	groupName
	**/
	public function addValue(value:ExposedValue, groupName:String = null):Void
	{
		value.collection = this;
		if (groupName != null)
		{
			this._groupMap[groupName].addValue(value);
		}
		else
		{
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
		if (groupName != null)
		{
			this._groupMap[groupName].addValueAfter(value, afterValueName);
		}
		else
		{
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
		if (groupName != null)
		{
			this._groupMap[groupName].addValueBefore(value, beforeValueName);
		}
		else
		{
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
	
	/**
	   
	**/
	public function buildUI():Void
	{
		if (this.uiCollection != null) return;
		
		this.uiCollection = new UICollection();
		
		for (value in this._valueList)
		{
			this.uiCollection.addUI(ValEdit.toUIControl(value));
		}
	}
	
	/**
	   
	   @param	name
	   @param	includeSubGroups
	   @return
	**/
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
	
	/**
	   
	   @param	propertyName
	   @return
	**/
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
	
	/**
	   
	   @param	propertyName
	   @return
	**/
	public function hasValue(propertyName:String):Bool
	{
		if (this._valueMap.exists(propertyName)) return true;
		for (group in this._groupList)
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
		value = this._valueMap[propertyName];
		if (value != null)
		{
			this._valueList.remove(value);
			this._valueMap.remove(propertyName);
			return value;
		}
		
		for (group in this._groupList)
		{
			value = group.removeValueByName(propertyName);
			if (value != null) return value;
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
	
	/**
	   
	   @return
	**/
	public function clone():ExposedCollection
	{
		var collection:ExposedCollection = new ExposedCollection();
		
		for (val in this._valueList)
		{
			collection.addValue(val.clone());
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