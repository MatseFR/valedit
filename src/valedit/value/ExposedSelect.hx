package valedit.value;

import openfl.errors.Error;
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
	
	static public function fromPool(propertyName:String, name:String = null, choiceList:Array<String> = null, valueList:Array<Dynamic> = null):ExposedSelect
	{
		if (_POOL.length != 0) return cast _POOL.pop().setTo(propertyName, name, choiceList, valueList);
		return new ExposedSelect(propertyName, name, choiceList, valueList);
	}
	
	/**
	   
	   @param	propertyName
	   @param	name
	   @param	choiceList
	   @param	valueList
	   @param	listPercentWidth
	**/
	public function new(propertyName:String, name:String = null, choiceList:Array<String> = null, valueList:Array<Dynamic> = null) 
	{
		super(propertyName, name, choiceList, valueList);
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
	
	public function clone(copyValue:Bool = false):ExposedValue 
	{
		var select:ExposedSelect = fromPool(this.propertyName, this.name, this.choiceList != null ? this.choiceList.copy():null, this.valueList != null ? this.valueList.copy():null);
		super.clone_internal(select, copyValue);
		return select;
	}
	
}