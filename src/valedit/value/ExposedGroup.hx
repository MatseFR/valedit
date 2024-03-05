package valedit.value;
import openfl.errors.Error;
import valedit.ExposedCollection;
import valedit.animation.TweenData;
import valedit.animation.TweenProperties;
import valedit.value.base.ExposedValue;
import valedit.events.ValueEvent;
import valedit.ui.IGroupUI;
import valedit.ui.IValueUI;
import valeditor.editor.action.MultiAction;
import valeditor.editor.action.value.ValueClone;
import valeditor.editor.action.value.ValueUIUpdate;

#if valeditor
import valeditor.ValEditor;
#end

/**
 * ...
 * @author Matse
 */
@:access(valedit.value.base.ExposedValue)
class ExposedGroup extends ExposedValue
{
	static private var _POOL:Array<ExposedGroup> = new Array<ExposedGroup>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(name:String, isCollapsable:Bool = true, isCollapsedDefault:Bool = false):ExposedGroup
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(name, isCollapsable, isCollapsedDefault);
		return new ExposedGroup(name, isCollapsable, isCollapsedDefault);
	}
	
	public var isCollapsable:Bool;
	public var isCollapsedDefault:Bool;
	
	override function set_collection(value:ExposedCollection):ExposedCollection 
	{
		for (val in this._valueList)
		{
			val.collection = value;
		}
		return super.set_collection(value);
	}
	
	override function set_isConstructor(value:Bool):Bool 
	{
		if (this._isConstructor == value) return value;
		for (val in this._valueList)
		{
			val.isConstructor = value;
		}
		return super.set_isConstructor(value);
	}
	
	override function set_isEditable(value:Bool):Bool 
	{
		if (this._isEditable == value) return value;
		for (val in this._valueList)
		{
			val.isEditable = value;
		}
		return super.set_isEditable(value);
	}
	
	override function set_isReadOnly(value:Bool):Bool 
	{
		if (this._isReadOnly == value) return value;
		for (val in this._valueList)
		{
			val.isReadOnly = value;
		}
		return super.set_isReadOnly(value);
	}
	
	override function set_object(value:Dynamic):Dynamic
	{
		for (val in this._valueList)
		{
			val.object = value;
		}
		return super.set_object(value);
	}
	
	#if valeditor
	override function set_uiControl(value:IValueUI):IValueUI 
	{
		if (this._uiControl == value) return value;
		super.set_uiControl(value);
		if (value != null)
		{
			this._uiGroup = cast(value);
			buildUI();
		}
		else
		{
			this._uiGroup = null;
		}
		return value;
	}
	#end
	
	private var _groupList:Array<ExposedGroup> = new Array<ExposedGroup>();
	private var _groupMap:Map<String, ExposedGroup> = new Map<String, ExposedGroup>();
	private var _valueList:Array<ExposedValue> = new Array<ExposedValue>();
	private var _valueMap:Map<String, ExposedValue> = new Map<String, ExposedValue>();
	#if valeditor
	private var _isUIBuilt:Bool = false;
	private var _uiGroup:IGroupUI;
	#end
	
	/**
	   
	   @param	name
	   @param	isCollapsable
	   @param	isCollapsedDefault
	**/
	public function new(name:String, isCollapsable:Bool = true, isCollapsedDefault:Bool = false) 
	{
		super(name);
		this.isGroup = true;
		this.isCollapsable = isCollapsable;
		this.isCollapsedDefault = isCollapsedDefault;
	}
	
	override public function clear():Void 
	{
		super.clear();
		for (value in this._valueList)
		{
			value.pool();
		}
		this._groupList.resize(0);
		this._groupMap.clear();
		this._valueList.resize(0);
		this._valueMap.clear();
		#if valeditor
		if (this._uiGroup != null)
		{
			this._uiGroup.pool();
			this._uiGroup = null;
		}
		this._isUIBuilt = false;
		#end
	}
	
	public function pool():Void 
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(name:String, isCollapsable:Bool, isCollapsedDefault:Bool):ExposedGroup
	{
		setNames(name, null);
		this.isCollapsable = isCollapsable;
		this.isCollapsedDefault = isCollapsedDefault;
		return this;
	}
	
	public function checkVisibility():Void
	{
		if (this._visible)
		{
			for (value in this._valueList)
			{
				if (value.visible) return;
			}
			this.visible = false;
		}
		else
		{
			for (value in this._valueList)
			{
				if (value.visible)
				{
					this.visible = true;
					return;
				}
			}
		}
		
		for (group in this._groupList)
		{
			group.checkVisibility();
		}
	}
	
	override public function apply():Void 
	{
		for (value in this._valueList)
		{
			value.apply();
		}
	}
	
	override public function applyToObject(object:Dynamic, applyIfDefaultValue:Bool = false):Void 
	{
		for (value in this._valueList)
		{
			value.applyToObject(object, applyIfDefaultValue);
		}
	}
	
	public function checkForObjectMatch(otherGroup:ExposedGroup):Bool
	{
		var otherGrp:ExposedGroup;
		var otherValue:ExposedValue;
		var group:ExposedGroup;
		
		for (value in this._valueList)
		{
			if (!value.isRealValue) continue;
			if (value.isGroup)
			{
				group = cast value;
				otherGrp = otherGroup.getGroup(group.name);
				if (!group.checkForObjectMatch(otherGrp)) return false;
			}
			else if (value.useForObjectMatching)
			{
				otherValue = otherGroup.getValue(value.propertyName);
				if (value.value != otherValue.value) return false;
			}
		}
		
		return true;
	}
	
	public function copyValuesFrom(fromGroup:ExposedGroup, ?action:MultiAction):Void
	{
		var fromGrp:ExposedGroup;
		var fromValue:ExposedValue;
		var group:ExposedGroup;
		
		if (action != null)
		{
			var valueClone:ValueClone;
			for (value in this._valueList)
			{
				if (!value.isRealValue) continue;
				if (value.isGroup)
				{
					group = cast value;
					fromGrp = fromGroup.getGroup(group.name);
					if (fromGrp != null)
					{
						group.copyValuesFrom(fromGrp, action);
					}
				}
				else
				{
					fromValue = fromGroup.getValue(value.propertyName);
					if (fromValue != null)
					{
						valueClone = ValueClone.fromPool();
						valueClone.setup(fromValue, value);
						action.add(valueClone);
					}
				}
			}
		}
		else
		{
			for (value in this._valueList)
			{
				if (!value.isRealValue) continue;
				if (value.isGroup)
				{
					group = cast value;
					fromGrp = fromGroup.getGroup(group.name);
					if (fromGrp != null)
					{
						group.copyValuesFrom(fromGrp);
					}
				}
				else
				{
					fromValue = fromGroup.getValue(value.propertyName);
					if (fromValue != null)
					{
						fromValue.cloneValue(value);
					}
				}
			}
		}
	}
	
	public function copyValuesTo(toGroup:ExposedGroup):Void
	{
		var toGrp:ExposedGroup;
		var toValue:ExposedValue;
		var group:ExposedGroup;
		
		for (value in this._valueList)
		{
			if (!value.isRealValue) continue;
			if (value.isGroup)
			{
				group = cast value;
				toGrp = toGroup.getGroup(group.name);
				if (toGrp != null)
				{
					group.copyValuesTo(toGrp);
				}
			}
			else
			{
				toValue = toGroup.getValue(value.propertyName);
				if (toValue != null)
				{
					value.cloneValue(toValue);
				}
			}
		}
	}
	
	override public function readValue(dispatchEventIfChange:Bool = true):Void 
	{
		for (value in this._valueList)
		{
			value.readValue(dispatchEventIfChange);
		}
	}
	
	private function onValueChange(evt:ValueEvent):Void
	{
		dispatchEvent(evt);
	}
	
	/**
	   
	   @param	value
	**/
	public function addValue(value:ExposedValue):Void
	{
		if (!value.hasEventListener(ValueEvent.VALUE_CHANGE))
		{
			value.addEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
		}
		
		value.isConstructor = this.isConstructor;
		value.isEditable = this._isEditable;
		value.isReadOnly = this._isReadOnly;
		
		this._valueList.push(value);
		this._valueMap[value.propertyName] = value;
		
		if (Std.isOfType(value, ExposedGroup))
		{
			this._groupList.push(cast value);
			this._groupMap[value.propertyName] = cast value;
		}
		
		#if valeditor
		if (this._isUIBuilt)
		{
			if (value._uiControl == null)
			{
				ValEditor.toUIControl(value);
			}
			this._uiGroup.addExposedControl(value._uiControl);
		}
		#end
	}
	
	
	public function addValueAfter(value:ExposedValue, afterValueName:String):Void
	{
		if (!value.hasEventListener(ValueEvent.VALUE_CHANGE))
		{
			value.addEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
		}
		
		value.isConstructor = this.isConstructor;
		value.isEditable = this._isEditable;
		value.isReadOnly = this._isReadOnly;
		
		var afterValue:ExposedValue = this._valueMap[afterValueName];
		if (afterValue == null)
		{
			throw new Error("ExposedGroup.addValueAfter ::: no value with name " + afterValueName);
		}
		
		var index:Int = this._valueList.indexOf(afterValue);
		this._valueList.insert(index + 1, value);
		this._valueMap[value.propertyName] = value;
		
		if (Std.isOfType(value, ExposedGroup))
		{
			this._groupList.push(cast value);
			this._groupMap[value.propertyName] = cast value;
		}
		
		#if valeditor
		if (_isUIBuilt && value._uiControl == null)
		{
			var control:IValueUI = ValEditor.toUIControl(value);
			this._uiGroup.addExposedControlAfter(control, afterValue._uiControl);
		}
		#end
	}
	
	public function addValueBefore(value:ExposedValue, beforeValueName:String):Void
	{
		if (!value.hasEventListener(ValueEvent.VALUE_CHANGE))
		{
			value.addEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
		}
		
		value.isConstructor = this.isConstructor;
		value.isEditable = this._isEditable;
		value.isReadOnly = this._isReadOnly;
		
		var beforeValue:ExposedValue = this._valueMap[beforeValueName];
		if (beforeValue == null)
		{
			throw new Error("ExposedGroup.addValueBefore ::: no value with name " + beforeValueName);
		}
		
		var index:Int = this._valueList.indexOf(beforeValue);
		this._valueList.insert(index, value);
		this._valueMap[value.propertyName] = value;
		
		if (Std.isOfType(value, ExposedGroup))
		{
			this._groupList.push(cast value);
			this._groupMap[value.propertyName] = cast value;
		}
		
		#if valeditor
		if (this._isUIBuilt && value._uiControl == null)
		{
			var control:IValueUI = ValEditor.toUIControl(value);
			this._uiGroup.addExposedControlBefore(control, beforeValue._uiControl);
		}
		#end
	}
	
	#if valeditor
	private function buildUI():Void
	{
		if (this._isUIBuilt) return;
		var control:IValueUI;
		for (val in this._valueList)
		{
			control = ValEditor.toUIControl(val);
			this._uiGroup.addExposedControl(control);
		}
		this._isUIBuilt = true;
	}
	
	public function getActionChanges(targetGroup:ExposedGroup, action:MultiAction):Void
	{
		var group:ExposedGroup;
		var targetGrp:ExposedGroup;
		var targetValue:ExposedValue;
		var valueClone:ValueClone;
		var valueUIUpdate:ValueUIUpdate;
		
		for (value in this._valueList)
		{
			if (!value.isRealValue) continue;
			if (!value.checkForChange) continue;
			if (value.isGroup)
			{
				group = cast value;
				targetGrp = targetGroup.getGroup(group.name);
				if (targetGrp != null)
				{
					group.getActionChanges(targetGrp, action);
				}
			}
			else
			{
				targetValue = targetGroup.getValue(value.propertyName);
				if (targetValue != null && value.value != targetValue.value)
				{
					valueClone = ValueClone.fromPool();
					valueClone.setup(targetValue, value);
					action.add(valueClone);
					
					valueUIUpdate = ValueUIUpdate.fromPool();
					valueUIUpdate.setup(targetValue);
					action.addPost(valueUIUpdate);
				}
			}
		}
	}
	#end
	
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
		var value:ExposedValue = this._valueMap[propertyName];
		if (value != null) return value;
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
		}
		
		if (value == null)
		{
			for (group in this._groupList)
			{
				value = group.removeValueByName(propertyName);
				if (value != null) break;
			}
		}
		
		if (value != null)
		{
			value.removeEventListener(ValueEvent.VALUE_CHANGE, onValueChange);
		}
		return value;
	}
	
	override public function toValueArray(values:Array<Dynamic>):Void 
	{
		for (value in this._valueList)
		{
			value.toValueArray(values);
		}
	}
	
	public function getTweenData(tweenData:TweenData, tweenProperties:TweenProperties, targetGroup:ExposedGroup):Bool
	{
		var hasTween:Bool = false;
		var targetValue:ExposedValue;
		
		for (value in this._valueList)
		{
			if (value.isGroup)
			{
				if (cast(value, ExposedGroup).getTweenData(tweenData, tweenProperties, targetGroup.getGroup(value.propertyName)))
				{
					hasTween = true;
				}
			}
			else if (value.isTweenable)
			{
				if (Std.isOfType(value, ExposedObject))
				{
					if (cast(value, ExposedObject).getTweenData(tweenData, cast targetGroup.getValue(value.propertyName)))
					{
						hasTween = true;
					}
				}
				else
				{
					targetValue = targetGroup.getValue(value.propertyName);
					if (value.value != targetValue.value)
					{
						tweenProperties.addProperty(value.propertyName, value.value, targetValue.value);
						hasTween = true;
					}
				}
			}
		}
		
		return hasTween;
	}
	
	/**
	   
	   @return
	**/
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var group:ExposedGroup = fromPool(this.name, this.isCollapsable, this.isCollapsedDefault);
		
		for (val in this._valueList)
		{
			group.addValue(val.clone(copyValue));
		}
		
		return group;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		if (json.values != null)
		{
			var data:Array<Dynamic> = json.values;
			var value:ExposedValue;
			for (node in data)
			{
				value = ExposedValue.valueFromJSON(node);
				this.addValue(value);
			}
		}
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
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
		
		return super.toJSON(json);
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		for (value in this._valueList)
		{
			value.toJSONSimple(json);
		}
	}
	
}