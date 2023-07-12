package valedit.value;

import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedSelect extends ExposedValue 
{
	static private var _POOL:Array<ExposedSelect> = new Array<ExposedSelect>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null, choiceList:Array<String> = null, valueList:Array<Dynamic> = null, listPercentWidth:Float = 100):ExposedSelect
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, choiceList, valueList, listPercentWidth);
		return new ExposedSelect(propertyName, name, choiceList, valueList, listPercentWidth);
	}
	
	public var choiceList(default, null):Array<String>;
	public var valueList(default, null):Array<Dynamic>;
	public var listPercentWidth:Float;
	
	/**
	   
	   @param	propertyName
	   @param	name
	   @param	choiceList
	   @param	valueList
	   @param	listPercentWidth
	**/
	public function new(propertyName:String, name:String = null, choiceList:Array<String> = null, valueList:Array<Dynamic> = null, listPercentWidth:Float = 100) 
	{
		super(propertyName, name);
		if (choiceList == null) choiceList = new Array<String>();
		if (valueList == null) valueList = new Array<Dynamic>();
		this.choiceList = choiceList;
		this.valueList = valueList;
		this.listPercentWidth = listPercentWidth;
	}
	
	override public function clear():Void 
	{
		super.clear();
		this.choiceList = null;
		this.valueList = null;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, choiceList:Array<String>, valueList:Array<Dynamic>, listPercentWidth:Float):ExposedSelect
	{
		setNames(propertyName, name);
		if (choiceList == null) choiceList = new Array<String>();
		if (valueList == null) valueList = new Array<Dynamic>();
		this.choiceList = choiceList;
		this.valueList = valueList;
		this.listPercentWidth = listPercentWidth;
		return this;
	}
	
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
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var select:ExposedSelect = new ExposedSelect(this.propertyName, this.name, choiceList != null ? choiceList.copy():null, valueList != null ? valueList.copy():null, listPercentWidth);
		super.clone_internal(select, copyValue);
		return select;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		//var index:Int = choiceList.indexOf(json.choice);
		//if (index != -1) this.value = valueList[index];
		this.value = json.value;
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		//var index:Int = valueList.indexOf(this.value);
		//if (index != -1) json.choice = choiceList[index];
		json.value = this.value;
		return super.toJSON(json);
	}
	
}