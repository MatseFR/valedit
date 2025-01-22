package valedit.value.base;
import haxe.Constraints.Function;
import valedit.value.base.ExposedValue;
#if valeditor
import valeditor.ValEditorObject;
#else
import valedit.ValEditObject;
#end

/**
 * ...
 * @author Matse
 */
abstract class ExposedSelectBase extends ExposedValue 
{
	public var choiceList(default, null):Array<String>;
	/** if not null and choiceListObjectFunctionName is null, this function will be called to retrieve choices */
	public var choiceListFunction:Function;
	/** if true the object will be used as a parameter when calling choiceListFunction. Default is false. */
	public var choiceListFunctionUseObjectAsParameter:Bool;
	/** if not null, this function will be called on the object to retrieve choices */
	public var choiceListObjectFunctionName:String;
	/** parameters to use when calling choiceListObjectFunctionName */
	public var choiceListObjectFunctionParams:Array<Dynamic> = new Array<Dynamic>();
	
	public var choiceSaved:String;
	
	public var valueList(default, null):Array<Dynamic>;
	/** if not null and valueListObjectFunctionName is null, this function will be called to retrieve values */
	public var valueListFunction:Function;
	/** if true the object will be used as a parameter when calling valueListFunction. Default is false. */
	public var valueListFunctionUseObjectAsParameter:Bool;
	/** if not null, this function will be called on the object to retrieve values */
	public var valueListObjectFunctionName:String;
	/** parameters to use when calling valueListObjectFunctionName */
	public var valueListObjectFunctionParams:Array<Dynamic> = new Array<Dynamic>();
	
	#if valeditor
	public var contentJustify:Bool = true;
	public var requestedMaxRowCount:Int = 12;
	public var requestedMinRowCount:Int = 1;
	
	public var listPercentWidth:Float = 100;
	/* if true, moving up or down using keyboard will select the item. Default is false. */
	public var selectOnKeyboardNavigation:Bool = false;
	#end
	
	override function set_object(value:Dynamic):Dynamic 
	{
		if (value != null && this.choiceList.length == 0)
		{
			var targetObject:Dynamic;
			#if valeditor
			if (Std.isOfType(value, ValEditorObject))
			{
				targetObject = cast(value, ValEditorObject).object;
			}
			#else
			if (Std.isOfType(value, ValEditObject))
			{
				targetObject = cast(value, ValEditObject).object;
			}
			#end
			else
			{
				targetObject = value;
			}
			if (this.choiceListObjectFunctionName != null)
			{
				this.choiceList = Reflect.callMethod(targetObject, Reflect.getProperty(targetObject, this.choiceListObjectFunctionName), this.choiceListObjectFunctionParams);
			}
			else if (this.choiceListFunction != null)
			{
				if (this.choiceListFunctionUseObjectAsParameter)
				{
					this.choiceList = Reflect.callMethod(null, this.choiceListFunction, [targetObject]);
				}
				else
				{
					this.choiceList = Reflect.callMethod(null, this.choiceListFunction, []);
				}
			}
			
			if (this.valueListObjectFunctionName != null)
			{
				this.valueList = Reflect.callMethod(targetObject, Reflect.getProperty(targetObject, this.valueListObjectFunctionName), this.valueListObjectFunctionParams);
			}
			else if (this.valueListFunction != null)
			{
				if (this.valueListFunctionUseObjectAsParameter)
				{
					this.valueList = Reflect.callMethod(null, this.valueListFunction, [targetObject]);
				}
				else
				{
					this.valueList = Reflect.callMethod(null, this.valueListFunction, []);
				}
			}
			
			if (this.choiceSaved != null)
			{
				var index:Int = this.choiceList.indexOf(this.choiceSaved);
				if (index != -1)
				{
					this.value = this.valueList[index];
				}
				this.choiceSaved = null;
			}
		}
		else if (this.choiceList.length == 0)
		{
			if (this.choiceListFunction != null)
			{
				if (this.choiceListFunctionUseObjectAsParameter)
				{
					//this.choiceList = Reflect.callMethod(null, this.choiceListFunction, [targetObject]);
				}
				else
				{
					this.choiceList = Reflect.callMethod(null, this.choiceListFunction, []);
				}
			}
			
			if (this.valueListFunction != null)
			{
				if (this.valueListFunctionUseObjectAsParameter)
				{
					//this.valueList = Reflect.callMethod(null, this.valueListFunction, [targetObject]);
				}
				else
				{
					this.valueList = Reflect.callMethod(null, this.valueListFunction, []);
				}
			}
		}
		return super.set_object(value);
	}

	public function new(propertyName:String, name:String = null, choiceList:Array<String> = null, valueList:Array<Dynamic> = null) 
	{
		super(propertyName, name);
		if (choiceList == null) choiceList = new Array<String>();
		if (valueList == null) valueList = new Array<Dynamic>();
		this.choiceList = choiceList;
		this.valueList = valueList;
	}
	
	override public function clear():Void 
	{
		super.clear();
		this.choiceList = null;
		this.choiceListFunction = null;
		this.choiceListFunctionUseObjectAsParameter = false;
		this.choiceListObjectFunctionName = null;
		this.choiceListObjectFunctionParams.resize(0);
		this.choiceSaved = null;
		this.valueList = null;
		this.valueListFunction = null;
		this.valueListFunctionUseObjectAsParameter = false;
		this.valueListObjectFunctionName = null;
		this.valueListObjectFunctionParams.resize(0);
		#if valeditor
		this.listPercentWidth = 100;
		this.selectOnKeyboardNavigation = false;
		#end
	}
	
	private function setTo(propertyName:String, name:String, choiceList:Array<String>, valueList:Array<Dynamic>):ExposedSelectBase
	{
		setNames(propertyName, name);
		if (choiceList == null) choiceList = new Array<String>();
		if (valueList == null) valueList = new Array<Dynamic>();
		this.choiceList = choiceList;
		this.valueList = valueList;
		this.isInPool = false;
		return this;
	}
	
	#if valeditor
	override function clone_internal(value:ExposedValue, copyValue:Bool = false):Void 
	{
		var select:ExposedSelectBase = cast value;
		select.listPercentWidth = this.listPercentWidth;
		select.selectOnKeyboardNavigation = this.selectOnKeyboardNavigation;
		select.choiceListFunction = this.choiceListFunction;
		select.choiceListFunctionUseObjectAsParameter = this.choiceListFunctionUseObjectAsParameter;
		select.choiceListObjectFunctionName = this.choiceListObjectFunctionName;
		select.choiceListObjectFunctionParams = this.choiceListObjectFunctionParams.copy();
		select.valueListFunction = this.valueListFunction;
		select.valueListFunctionUseObjectAsParameter = this.valueListFunctionUseObjectAsParameter;
		select.valueListObjectFunctionName = this.valueListObjectFunctionName;
		select.valueListObjectFunctionParams = this.valueListObjectFunctionParams;
		super.clone_internal(value, copyValue);
	}
	#end
	
	/**
	   if value is null choice is used as value
	   @param	choice
	   @param	value
	**/
	public function add(choice:String, value:Dynamic = null):Void
	{
		if (value == null) value = choice;
		this.choiceList.push(choice);
		this.valueList.push(value);
		if (this.defaultValue == null) this.defaultValue = value;
	}
	
	public function removeChoice(choice:String):Void
	{
		var index:Int = this.choiceList.indexOf(choice);
		if (index != -1)
		{
			this.choiceList.splice(index, 1);
			this.valueList.splice(index, 1);
		}
	}
	
	public function removeValue(value:Dynamic):Void
	{
		var index:Int = this.valueList.indexOf(value);
		if (index != -1)
		{
			this.choiceList.splice(index, 1);
			this.valueList.splice(index, 1);
		}
	}
	
	public function retrieveChoiceList(forObject:Dynamic = null):Void
	{
		if (forObject != null && this.choiceListObjectFunctionName != null)
		{
			this.choiceList = Reflect.callMethod(forObject, Reflect.getProperty(forObject, this.choiceListObjectFunctionName), this.choiceListObjectFunctionParams);
		}
		else if (this.choiceListFunction != null)
		{
			if (this.choiceListFunctionUseObjectAsParameter)
			{
				if (forObject != null)
				{
					this.choiceList = Reflect.callMethod(null, this.choiceListFunction, [forObject]);
				}
			}
			else
			{
				this.choiceList = Reflect.callMethod(null, this.choiceListFunction, []);
			}
		}
	}
	
	public function retrieveValueList(forObject:Dynamic = null):Void
	{
		if (forObject != null && this.valueListObjectFunctionName != null)
		{
			this.valueList = Reflect.callMethod(forObject, Reflect.getProperty(forObject, this.valueListObjectFunctionName), this.valueListObjectFunctionParams);
		}
		else if (this.valueListFunction != null)
		{
			if (this.valueListFunctionUseObjectAsParameter)
			{
				if (forObject != null)
				{
					this.valueList = Reflect.callMethod(null, this.valueListFunction, [forObject]);
				}
			}
			else
			{
				this.valueList = Reflect.callMethod(null, this.valueListFunction, []);
			}
		}
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		
		var choice:String = json.choice;
		if (choice != null)
		{
			var index:Int = this.choiceList.indexOf(choice);
			if (index != -1)
			{
				this.value = this.valueList[index];
			}
		}
	}
	
	override public function fromJSONSave(json:Dynamic):Void 
	{
		var choice:String = json.choice;
		
		if (this.choiceList.length == 0)
		{
			if (this.choiceListFunction != null && !this.choiceListFunctionUseObjectAsParameter)
			{
				this.choiceList = Reflect.callMethod(null, this.choiceListFunction, []);
			}
			
			if (this.valueListFunction != null && !this.valueListFunctionUseObjectAsParameter)
			{
				this.valueList = Reflect.callMethod(null, this.valueListFunction, []);
			}
		}
		
		if (choice != null)
		{
			var index:Int = this.choiceList.indexOf(choice);
			if (index != -1 && index < this.valueList.length)
			{
				this._storedValue = this.valueList[index];
			}
			else
			{
				this.choiceSaved = choice;
			}
		}
		
		#if valeditor
		if (json.lastChanged != null)
		{
			this.lastChanged = json.lastChanged;
		}
		if (json.lastModified != null)
		{
			this.lastModified = json.lastModified;
		}
		#end
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		
		var index:Int = this.valueList.indexOf(this.value);
		if (index != -1)
		{
			json.choice = this.choiceList[index];
		}
		
		return super.toJSON(json);
	}
	
	override public function toJSONSave(json:Dynamic, includeNotVisible:Bool = false, refValue:ExposedValue = null):Void 
	{
		var data:Dynamic = {};
		
		var index:Int = this.valueList.indexOf(this.value);
		if (index != -1)
		{
			data.choice = this.choiceList[index];
		}
		
		#if valeditor
		data.lastChanged = this.lastChanged;
		data.lastModified = this.lastModified;
		#end
		Reflect.setField(json, this.propertyName, data);
	}
	
}