package valedit.value.base;

/**
 * ...
 * @author Matse
 */
abstract class ExposedSelectBase extends ExposedValue 
{
	public var choiceList(default, null):Array<String>;
	public var valueList(default, null):Array<Dynamic>;
	public var listPercentWidth:Float;
	/* if true, moving up or down using keyboard will select the item. Default is false. */
	public var selectOnKeyboardNavigation:Bool = false;

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
		this.selectOnKeyboardNavigation = false;
	}
	
	private function setTo(propertyName:String, name:String, choiceList:Array<String>, valueList:Array<Dynamic>, listPercentWidth:Float):ExposedSelectBase
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
	
}