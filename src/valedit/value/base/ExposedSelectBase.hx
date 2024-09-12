package valedit.value.base;
import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
abstract class ExposedSelectBase extends ExposedValue 
{
	public var choiceList(default, null):Array<String>;
	public var valueList(default, null):Array<Dynamic>;
	#if valeditor
	public var listPercentWidth:Float = 100;
	/* if true, moving up or down using keyboard will select the item. Default is false. */
	public var selectOnKeyboardNavigation:Bool = false;
	#end

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
		this.valueList = null;
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
		return this;
	}
	
	#if valeditor
	override function clone_internal(value:ExposedValue, copyValue:Bool = false):Void 
	{
		var select:ExposedSelectBase = cast value;
		select.listPercentWidth = this.listPercentWidth;
		select.selectOnKeyboardNavigation = this.selectOnKeyboardNavigation;
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
	
}