package valedit.value.base;
import haxe.Constraints.Function;
import valedit.ExposedCollection;
import valedit.events.ValueEvent;
import valedit.value.base.ExposedValue;
#if valeditor
import openfl.display.BitmapData;
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
	// Choices
	public var choiceList(default, null):Array<String>;
	/** if not null and choiceListObjectFunctionName is null, this function will be called to retrieve choices */
	public var choiceListFunction:Function;
	/** if true the collection will be used as a parameter when calling choiceListFunction. Default is false. */
	public var choiceListFunctionUseCollectionAsParameter:Bool;
	/** if true the object will be used as a parameter when calling choiceListFunction. Default is false. */
	public var choiceListFunctionUseObjectAsParameter:Bool;
	/** if not null, this function will be called on the object to retrieve choices */
	public var choiceListObjectFunctionName:String;
	/** parameters to use when calling choiceListObjectFunctionName */
	public var choiceListObjectFunctionParams:Array<Dynamic> = new Array<Dynamic>();
	/** if not null, this property will be read to retrieve choices */
	public var choiceListProperty:String;
	
	public var choiceSaved:String;
	
	#if valeditor
	// Icons
	public var iconFromValueProperty:String;
	
	public var iconList(default, null):Array<BitmapData>;
	
	public var iconListFunction:Function;
	
	public var iconListFunctionUseCollectionAsParameter:Bool;
	
	public var iconListFunctionUseObjectAsParameter:Bool;
	
	public var iconListObjectFunctionName:String;
	
	public var iconListObjectFunctionParams:Array<Dynamic> = new Array<Dynamic>();
	
	public var iconListProperty:String;
	#end
	
	// Values
	public var valueList(default, null):Array<Dynamic>;
	/** if not null and valueListObjectFunctionName is null, this function will be called to retrieve values */
	public var valueListFunction:Function;
	/** if true the collection will be used as a parameter when calling valueListFunction. Default is false. */
	public var valueListFunctionUseCollectionAsParameter:Bool;
	/** if true the object will be used as a parameter when calling valueListFunction. Default is false. */
	public var valueListFunctionUseObjectAsParameter:Bool;
	/** if not null, this function will be called on the object to retrieve values */
	public var valueListObjectFunctionName:String;
	/** parameters to use when calling valueListObjectFunctionName */
	public var valueListObjectFunctionParams:Array<Dynamic> = new Array<Dynamic>();
	/** if not null, this property will be read to retrieve values */
	public var valueListProperty:String;
	
	private var _choicesAndValuesUpdateWithPropertyNames:Array<String> = new Array<String>();
	
	@:access(valedit.ExposedCollection)
	override function set_collection(value:ExposedCollection):ExposedCollection 
	{
		if (this._collection != null)
		{
			for (propertyName in this._choicesAndValuesUpdateWithPropertyNames)
			{
				this._collection.unregisterForValueChange(propertyName, this.choicesAndValuesUpdate);
			}
		}
		if (value != null)
		{
			for (propertyName in this._choicesAndValuesUpdateWithPropertyNames)
			{
				value.registerForValueChange(propertyName, this.choicesAndValuesUpdate);
			}
		}
		return super.set_collection(value);
	}
	
	#if valeditor
	public var contentJustify:Bool = true;
	public var prompt:String = "- select -";
	public var requestedMaxRowCount:Int = 12;
	public var requestedMinRowCount:Int = 1;
	
	public var listPercentWidth:Float = 100;
	/* if true, moving up or down using keyboard will select the item. Default is false. */
	public var selectOnKeyboardNavigation:Bool = false;
	#end
	
	override function set_object(value:Dynamic):Dynamic 
	{
		if (value != null) //&& this.choiceList.length == 0)
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
			
			if (this.choiceList.length == 0) retrieveChoiceList(targetObject);
			if (this.valueList.length == 0) retrieveValueList(targetObject);
			#if valeditor
			if (this.iconList.length == 0) retrieveIconList(targetObject);
			#end
			
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
		else //if (this.choiceList.length == 0)
		{
			if (this.choiceList.length == 0) retrieveChoiceList(value);
			if (this.valueList.length == 0) retrieveValueList(value);
			#if valeditor
			if (this.iconList.length == 0) retrieveIconList(value);
			#end
		}
		return super.set_object(value);
	}

	public function new(propertyName:String, name:String = null, choiceList:Array<String> = null, valueList:Array<Dynamic> = null #if valeditor , iconList:Array<BitmapData> = null#end) 
	{
		super(propertyName, name);
		if (choiceList == null) choiceList = new Array<String>();
		if (valueList == null) valueList = new Array<Dynamic>();
		#if valeditor
		if (iconList == null) iconList = new Array<BitmapData>();
		#end
		this.choiceList = choiceList;
		this.valueList = valueList;
		#if valeditor
		this.iconList = iconList;
		#end
	}
	
	override public function clear():Void 
	{
		super.clear();
		this.choiceList = null;
		this.choiceListFunction = null;
		this.choiceListFunctionUseCollectionAsParameter = false;
		this.choiceListFunctionUseObjectAsParameter = false;
		this.choiceListObjectFunctionName = null;
		this.choiceListObjectFunctionParams.resize(0);
		this.choiceListProperty = null;
		this.choiceSaved = null;
		#if valeditor
		this.iconFromValueProperty = null;
		this.iconList = null;
		this.iconListFunction = null;
		this.iconListFunctionUseCollectionAsParameter = false;
		this.iconListFunctionUseObjectAsParameter = false;
		this.iconListObjectFunctionName = null;
		this.iconListObjectFunctionParams.resize(0);
		this.iconListProperty = null;
		#end
		this.valueList = null;
		this.valueListFunction = null;
		this.valueListFunctionUseCollectionAsParameter = false;
		this.valueListFunctionUseObjectAsParameter = false;
		this.valueListObjectFunctionName = null;
		this.valueListObjectFunctionParams.resize(0);
		this.valueListProperty = null;
		#if valeditor
		this.prompt = "- select -";
		this.listPercentWidth = 100;
		this.selectOnKeyboardNavigation = false;
		this._choicesAndValuesUpdateWithPropertyNames.resize(0);
		#end
	}
	
	private function setTo(propertyName:String, name:String, choiceList:Array<String>, valueList:Array<Dynamic> #if valeditor , iconList:Array<BitmapData>#end):ExposedSelectBase
	{
		setNames(propertyName, name);
		if (choiceList == null) choiceList = new Array<String>();
		if (valueList == null) valueList = new Array<Dynamic>();
		#if valeditor
		if (iconList == null) iconList = new Array<BitmapData>();
		#end
		this.choiceList = choiceList;
		this.valueList = valueList;
		#if valeditor
		this.iconList = iconList;
		#end
		this.isInPool = false;
		return this;
	}
	
	#if valeditor
	override function clone_internal(value:ExposedValue, copyValue:Bool = false):Void 
	{
		var select:ExposedSelectBase = cast value;
		select.prompt = this.prompt;
		select.listPercentWidth = this.listPercentWidth;
		select.selectOnKeyboardNavigation = this.selectOnKeyboardNavigation;
		select.choiceListFunction = this.choiceListFunction;
		select.choiceListFunctionUseCollectionAsParameter = this.choiceListFunctionUseCollectionAsParameter;
		select.choiceListFunctionUseObjectAsParameter = this.choiceListFunctionUseObjectAsParameter;
		select.choiceListObjectFunctionName = this.choiceListObjectFunctionName;
		select.choiceListObjectFunctionParams = this.choiceListObjectFunctionParams.copy();
		select.choiceListProperty = this.choiceListProperty;
		#if valeditor
		select.iconFromValueProperty = this.iconFromValueProperty;
		select.iconListFunction = this.iconListFunction;
		select.iconListFunctionUseCollectionAsParameter = this.iconListFunctionUseCollectionAsParameter;
		select.iconListFunctionUseObjectAsParameter = this.iconListFunctionUseObjectAsParameter;
		select.iconListObjectFunctionName = this.iconListObjectFunctionName;
		select.iconListObjectFunctionParams = this.iconListObjectFunctionParams.copy();
		select.iconListProperty = this.iconListProperty;
		#end
		select.valueListFunction = this.valueListFunction;
		select.valueListFunctionUseCollectionAsParameter = this.valueListFunctionUseCollectionAsParameter;
		select.valueListFunctionUseObjectAsParameter = this.valueListFunctionUseObjectAsParameter;
		select.valueListObjectFunctionName = this.valueListObjectFunctionName;
		select.valueListObjectFunctionParams = this.valueListObjectFunctionParams;
		select.valueListProperty = this.valueListProperty;
		for (propertyName in this._choicesAndValuesUpdateWithPropertyNames)
		{
			select._choicesAndValuesUpdateWithPropertyNames[select._choicesAndValuesUpdateWithPropertyNames.length] = propertyName;
		}
		super.clone_internal(value, copyValue);
	}
	
	@:access(valedit.ExposedCollection)
	public function addChoicesAndValuesUpdatePropertyName(propertyName:String):Void
	{
		this._choicesAndValuesUpdateWithPropertyNames[this._choicesAndValuesUpdateWithPropertyNames.length] = propertyName;
		if (this._collection != null)
		{
			this._collection.registerForValueChange(propertyName, this.choicesAndValuesUpdate);
		}
	}
	
	@:access(valedit.ExposedCollection)
	public function removeChoicesAndValuesUpdatePropertyName(propertyName:String):Void
	{
		this._choicesAndValuesUpdateWithPropertyNames.splice(this._choicesAndValuesUpdateWithPropertyNames.indexOf(propertyName), 1);
		if (this._collection != null)
		{
			this._collection.unregisterForValueChange(propertyName, this.choicesAndValuesUpdate);
		}
	}
	
	private function choicesAndValuesUpdate(value:ExposedValue):Void
	{
		retrieveChoiceList(this.object);
		retrieveValueList(this.object);
		#if valeditor
		retrieveIconList(this.object);
		#end
		ValueEvent.dispatch(this, ValueEvent.DATA_CHANGE, this);
	}
	#end
	
	/**
	   if value is null choice is used as value
	   @param	choice
	   @param	value
	**/
	public function add(choice:String, value:Dynamic = null #if valeditor , icon:BitmapData = null#end):Void
	{
		if (value == null) value = choice;
		this.choiceList[this.choiceList.length] = choice;
		this.valueList[this.valueList.length] = value;
		#if valeditor
		this.iconList[this.iconList.length] = icon;
		#end
		if (this.defaultValue == null) this.defaultValue = value;
	}
	
	public function removeChoice(choice:String):Void
	{
		var index:Int = this.choiceList.indexOf(choice);
		if (index != -1)
		{
			this.choiceList.splice(index, 1);
			this.valueList.splice(index, 1);
			#if valeditor
			this.iconList.splice(index, 1);
			#end
		}
	}
	
	public function removeValue(value:Dynamic):Void
	{
		var index:Int = this.valueList.indexOf(value);
		if (index != -1)
		{
			this.choiceList.splice(index, 1);
			this.valueList.splice(index, 1);
			#if valeditor
			this.iconList.splice(index, 1);
			#end
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
			if (this.choiceListFunctionUseCollectionAsParameter)
			{
				this.choiceList = Reflect.callMethod(null, this.choiceListFunction, [this.collection]);
			}
			else if (this.choiceListFunctionUseObjectAsParameter)
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
		else if (this.choiceListProperty != null && forObject != null)
		{
			this.choiceList = Reflect.getProperty(forObject, this.choiceListProperty);
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
			if (this.valueListFunctionUseCollectionAsParameter)
			{
				this.valueList = Reflect.callMethod(null, this.valueListFunction, [this.collection]);
			}
			else if (this.valueListFunctionUseObjectAsParameter)
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
		else if (this.valueListProperty != null && forObject != null)
		{
			this.valueList = Reflect.getProperty(forObject, this.valueListProperty);
		}
	}
	
	#if valeditor
	public function retrieveIconList(forObject:Dynamic = null):Void
	{
		if (forObject != null && this.iconListObjectFunctionName != null)
		{
			this.iconList = Reflect.callMethod(forObject, Reflect.getProperty(forObject, this.iconListObjectFunctionName), this.iconListObjectFunctionParams);
		}
		else if (this.iconListFunction != null)
		{
			if (this.iconListFunctionUseCollectionAsParameter)
			{
				this.iconList = Reflect.callMethod(null, this.iconListFunction, [this.collection]);
			}
			else if (this.iconListFunctionUseObjectAsParameter)
			{
				if (forObject != null)
				{
					this.iconList = Reflect.callMethod(null, this.iconListFunction, [forObject]);
				}
			}
			else
			{
				this.iconList = Reflect.callMethod(null, this.iconListFunction, []);
			}
		}
		else if (this.iconListProperty != null && forObject != null)
		{
			this.iconList = Reflect.getProperty(forObject, this.iconListProperty);
		}
		else if (this.iconFromValueProperty != null)
		{
			if (this.iconList == null)
			{
				this.iconList = new Array<BitmapData>();
			}
			else
			{
				this.iconList.resize(0);
			}
			
			if (this.valueList != null)
			{
				var count:Int = this.valueList.length;
				for (i in 0...count)
				{
					this.iconList[i] = Reflect.getProperty(this.valueList[i], this.iconFromValueProperty);
				}
			}
		}
		else
		{
			if (this.iconList == null)
			{
				this.iconList = new Array<BitmapData>();
			}
			else
			{
				this.iconList.resize(0);
			}
			
			if (this.valueList != null)
			{
				this.iconList.resize(this.valueList.length);
			}
		}
	}
	#end
	
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
				if (this.choiceListFunctionUseCollectionAsParameter)
				{
					this.choiceList = Reflect.callMethod(null, this.choiceListFunction, [this.collection]);
				}
				else
				{
					this.choiceList = Reflect.callMethod(null, this.choiceListFunction, []);
				}
			}
			
			if (this.valueListFunction != null && !this.valueListFunctionUseObjectAsParameter)
			{
				if (this.valueListFunctionUseCollectionAsParameter)
				{
					this.valueList = Reflect.callMethod(null, this.valueListFunction, [this.collection]);
				}
				else
				{
					this.valueList = Reflect.callMethod(null, this.valueListFunction, []);
				}
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