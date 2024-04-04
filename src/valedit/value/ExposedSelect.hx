package valedit.value;

import valedit.value.base.ExposedSelectBase;
import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedSelect extends ExposedSelectBase 
{
	static private var _POOL:Array<ExposedSelect> = new Array<ExposedSelect>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null, choiceList:Array<String> = null, valueList:Array<Dynamic> = null, listPercentWidth:Float = 100):ExposedSelect
	{
		if (_POOL.length != 0) return cast _POOL.pop().setTo(propertyName, name, choiceList, valueList, listPercentWidth);
		return new ExposedSelect(propertyName, name, choiceList, valueList, listPercentWidth);
	}
	
	/**
	   
	   @param	propertyName
	   @param	name
	   @param	choiceList
	   @param	valueList
	   @param	listPercentWidth
	**/
	public function new(propertyName:String, name:String = null, choiceList:Array<String> = null, valueList:Array<Dynamic> = null, listPercentWidth:Float = 100) 
	{
		super(propertyName, name, choiceList, valueList, listPercentWidth);
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var select:ExposedSelect = fromPool(this.propertyName, this.name, this.choiceList != null ? this.choiceList.copy():null, this.valueList != null ? this.valueList.copy():null, this.listPercentWidth);
		select.selectOnKeyboardNavigation = this.selectOnKeyboardNavigation;
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