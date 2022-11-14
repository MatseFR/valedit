package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedSelect extends ExposedValue 
{
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
		
		choiceList.resize(0);
		valueList.resize(0);
	}
	
	/**
	   if value is null choice is used as value
	   @param	choice
	   @param	value
	**/
	public function add(choice:String, value:Dynamic = null):Void
	{
		if (value == null) value = choice;
		choiceList.push(choice);
		valueList.push(value);
		if (this.defaultValue == null) this.defaultValue = value;
	}
	
	public function removeChoice(choice:String):Void
	{
		var index:Int = choiceList.indexOf(choice);
		if (index != -1)
		{
			choiceList.splice(index, 1);
			valueList.splice(index, 1);
		}
	}
	
	public function removeValue(value:Dynamic):Void
	{
		var index:Int = valueList.indexOf(value);
		if (index != -1)
		{
			choiceList.splice(index, 1);
			valueList.splice(index, 1);
		}
	}
	
	override public function clone():ExposedValue 
	{
		var select:ExposedSelect = new ExposedSelect(this.propertyName, this.name, choiceList != null ? choiceList.copy():null, valueList != null ? valueList.copy():null, listPercentWidth);
		super.clone_internal(select);
		return select;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		var index:Int = choiceList.indexOf(json.choice);
		if (index != -1) this.value = valueList[index];
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		var index:Int = valueList.indexOf(this.value);
		if (index != -1) json.choice = choiceList[index];
		return super.toJSON(json);
	}
	
}