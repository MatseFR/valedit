package valedit.value;

import openfl.errors.Error;
import valedit.value.base.ExposedSelectBase;
import valedit.value.base.ExposedValue;
#if valeditor
import openfl.display.BitmapData;
#end

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
	
	static public function fromPool(propertyName:String, name:String = null, choiceList:Array<String> = null, valueList:Array<Dynamic> = null #if valeditor , iconList:Array<BitmapData> = null#end):ExposedSelect
	{
		if (_POOL.length != 0) return cast _POOL.pop().setTo(propertyName, name, choiceList, valueList #if valeditor , iconList#end);
		return new ExposedSelect(propertyName, name, choiceList, valueList #if valeditor , iconList#end);
	}
	
	/**
	   
	   @param	propertyName
	   @param	name
	   @param	choiceList
	   @param	valueList
	   @param	listPercentWidth
	**/
	public function new(propertyName:String, name:String = null, choiceList:Array<String> = null, valueList:Array<Dynamic> = null #if valeditor , iconList:Array<BitmapData> = null#end) 
	{
		super(propertyName, name, choiceList, valueList #if valeditor , iconList#end);
	}
	
	public function pool():Void
	{
		#if debug
		if (this.isInPool)
		{
			throw new Error("ExposedSelect.pool ::: already in pool");
		}
		#end
		clear();
		_POOL[_POOL.length] = this;
		this.isInPool = true;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var select:ExposedSelect = fromPool(this.propertyName, this.name, this.choiceList != null ? this.choiceList.copy():null, this.valueList != null ? this.valueList.copy():null #if valeditor , this.iconList != null ? this.iconList.copy():null#end);
		super.clone_internal(select, copyValue);
		return select;
	}
	
}