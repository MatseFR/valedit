package valedit.value;
import openfl.errors.Error;
import valedit.ExposedCollection;
import valedit.ExposedValue;
import valedit.ui.IGroupUI;
import valedit.ui.IValueUI;

/**
 * ...
 * @author Matse
 */
class ExposedGroup extends ExposedValue
{
	public var isCollapsable:Bool;
	public var isCollapsedDefault:Bool;
	
	override function set_collection(value:ExposedCollection):ExposedCollection 
	{
		for (val in _valueList)
		{
			val.collection = value;
		}
		return super.set_collection(value);
	}
	
	override function set_isEditable(value:Bool):Bool 
	{
		for (val in _valueList)
		{
			val.isEditable = value;
		}
		return super.set_isEditable(value);
	}
	
	override function set_object(value:Dynamic):Dynamic
	{
		for (val in _valueList)
		{
			val.object = value;
		}
		return super.set_object(value);
	}
	
	override function set_uiControl(value:IValueUI):IValueUI 
	{
		if (_uiControl == value) return value;
		super.set_uiControl(value);
		if (value != null)
		{
			_uiGroup = cast(value);
			buildUI();
		}
		else
		{
			_uiGroup = null;
		}
		return value;
	}
	
	private var _groupList:Array<ExposedGroup> = new Array<ExposedGroup>();
	private var _groupMap:Map<String, ExposedGroup> = new Map<String, ExposedGroup>();
	private var _isUIBuilt:Bool = false;
	private var _uiGroup:IGroupUI;
	private var _valueList:Array<ExposedValue> = new Array<ExposedValue>();
	private var _valueMap:Map<String, ExposedValue> = new Map<String, ExposedValue>();
	
	/**
	   
	   @param	name
	   @param	isCollapsable
	   @param	isCollapsedDefault
	**/
	public function new(name:String, isCollapsable:Bool = true, isCollapsedDefault:Bool = false) 
	{
		super(name);
		this.isCollapsable = isCollapsable;
		this.isCollapsedDefault = isCollapsedDefault;
	}
	
	/**
	   
	   @param	value
	**/
	public function addValue(value:ExposedValue):Void
	{
		_valueList.push(value);
		_valueMap[value.name] = value;
		if (Std.isOfType(value, ExposedGroup))
		{
			_groupList.push(cast value);
			_groupMap[value.name] = cast value;
		}
		
		if (_isUIBuilt && value._uiControl == null)
		{
			var control:IValueUI = ValEdit.toUIControl(value);
			_uiGroup.addExposedControl(control);
		}
	}
	
	
	public function addValueAfter(value:ExposedValue, afterValueName:String):Void
	{
		var afterValue:ExposedValue = _valueMap[afterValueName];
		if (afterValue == null)
		{
			throw new Error("ExposedGroup.addValueAfter ::: no value with name " + afterValueName);
		}
		
		var index:Int = _valueList.indexOf(afterValue);
		_valueList.insert(index + 1, value);
		_valueMap[value.name] = value;
		
		if (Std.isOfType(value, ExposedGroup))
		{
			_groupList.push(cast value);
			_groupMap[value.name] = cast value;
		}
		
		if (_isUIBuilt && value._uiControl == null)
		{
			var control:IValueUI = ValEdit.toUIControl(value);
			_uiGroup.addExposedControlAfter(control, afterValue._uiControl);
		}
	}
	
	public function addValueBefore(value:ExposedValue, beforeValueName:String):Void
	{
		var beforeValue:ExposedValue = _valueMap[beforeValueName];
		if (beforeValue == null)
		{
			throw new Error("ExposedGroup.addValueBefore ::: no value with name " + beforeValueName);
		}
		
		var index:Int = _valueList.indexOf(beforeValue);
		_valueList.insert(index, value);
		_valueMap[value.name] = value;
		
		if (Std.isOfType(value, ExposedGroup))
		{
			_groupList.push(cast value);
			_groupMap[value.name] = cast value;
		}
		
		if (_isUIBuilt && value._uiControl == null)
		{
			var control:IValueUI = ValEdit.toUIControl(value);
			_uiGroup.addExposedControlBefore(control, beforeValue._uiControl);
		}
	}
	
	private function buildUI():Void
	{
		if (_isUIBuilt) return;
		var control:IValueUI;
		for (val in _valueList)
		{
			control = ValEdit.toUIControl(val);
			_uiGroup.addExposedControl(control);
		}
		_isUIBuilt = true;
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
	   
	   @param	name
	   @return
	**/
	public function getValue(name:String):ExposedValue
	{
		var value:ExposedValue = _valueMap[name];
		if (value != null) return value;
		for (group in _groupList)
		{
			value = group.getValue(name);
			if (value != null) return value;
		}
		return null;
	}
	
	/**
	   
	   @param	name
	   @return
	**/
	public function hasValue(name:String):Bool
	{
		if (_valueMap.exists(name)) return true;
		for (group in _groupList)
		{
			if (group.hasValue(name)) return true;
		}
		return false;
	}
	
	/**
	   
	   @param	value
	**/
	public function removeValue(value:ExposedValue):Void
	{
		removeValueByName(value.name);
	}
	
	/**
	   
	   @param	name
	   @return
	**/
	public function removeValueByName(name:String):ExposedValue
	{
		var value:ExposedValue;
		value = _valueMap[name];
		if (value != null)
		{
			_valueList.remove(value);
			_valueMap.remove(value.name);
		}
		
		if (value == null)
		{
			for (group in _groupList)
			{
				value = group.removeValueByName(name);
				if (value != null) break;
			}
		}
		return value;
	}
	
	/**
	   
	   @return
	**/
	override public function clone():ExposedValue 
	{
		var group:ExposedGroup = new ExposedGroup(this.name, isCollapsable, isCollapsedDefault);
		
		for (val in _valueList)
		{
			group.addValue(val.clone());
		}
		
		return group;
	}
	
}