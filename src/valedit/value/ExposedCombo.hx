package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedCombo extends ExposedValue 
{
	public var choiceList(default, null):Array<String>;
	public var valueList(default, null):Array<Dynamic>;

	public function new(propertyName:String, name:String=null, choiceList:Array<String> = null, valueList:Array<Dynamic> = null) 
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
		
		this.choiceList.resize(0);
		this.valueList.resize(0);
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
		var combo:ExposedCombo = new ExposedCombo(this.propertyName, this.name,
			this.choiceList != null ? this.choiceList.copy() : null, this.valueList != null ? this.valueList.copy() : null);
		super.clone_internal(combo, copyValue);
		return combo;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		this.value = json.value;
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		json.value = this.value;
		return super.toJSON(json);
	}
	
}