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
	
	/**
	   
	   @param	name
	   @param	choiceList
	   @param	valueList
	**/
	public function new(name:String, choiceList:Array<String> = null, valueList:Array<Dynamic> = null) 
	{
		super(name);
		if (choiceList == null) choiceList = new Array<String>();
		if (valueList == null) valueList = new Array<Dynamic>();
		this.choiceList = choiceList;
		this.valueList = valueList;
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
		var select:ExposedSelect = new ExposedSelect(this.name, choiceList != null ? choiceList.copy():null, valueList != null ? valueList.copy():null);
		super.clone_internal(select);
		return select;
	}
	
}