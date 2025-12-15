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
class ExposedSelectCombo extends ExposedSelectBase 
{
	static private var _POOL:Array<ExposedSelectCombo> = new Array<ExposedSelectCombo>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null, choiceList:Array<String> = null, valueList:Array<Dynamic> = null #if valeditor , iconList:Array<BitmapData> = null#end):ExposedSelectCombo
	{
		if (_POOL.length != 0) return cast _POOL.pop().setTo(propertyName, name, choiceList, valueList #if valeditor , iconList#end);
		return new ExposedSelectCombo(propertyName, name, choiceList, valueList #if valeditor , iconList#end);
	}
	
	#if valeditor
	/* Allows the user to type a custom value into the text input. Default is false.*/
	public var allowCustomUserValue:Bool = false;
	#end
	
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
	
	#if valeditor
	override public function clear():Void 
	{
		this.allowCustomUserValue = false;
		
		super.clear();
	}
	#end
	
	public function pool():Void
	{
		#if debug
		if (this.isInPool)
		{
			throw new Error("ExposedSelectCombo.pool ::: already in pool");
		}
		#end
		clear();
		_POOL[_POOL.length] = this;
		this.isInPool = true;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var select:ExposedSelectCombo = fromPool(this.propertyName, this.name, this.choiceList != null ? this.choiceList.copy():null, this.valueList != null ? this.valueList.copy():null #if valeditor , this.iconList != null ? this.iconList.copy():null#end);
		super.clone_internal(select, copyValue);
		return select;
	}
	
	#if valeditor
	override function clone_internal(value:ExposedValue, copyValue:Bool = false):Void 
	{
		var combo:ExposedSelectCombo = cast value;
		combo.allowCustomUserValue = this.allowCustomUserValue;
		
		super.clone_internal(value, copyValue);
	}
	#end
	
	//override public function fromJSON(json:Dynamic):Void 
	//{
		//super.fromJSON(json);
		////var index:Int = choiceList.indexOf(json.choice);
		////if (index != -1) this.value = valueList[index];
		//this.value = json.value;
	//}
	
	//override public function toJSON(json:Dynamic = null):Dynamic 
	//{
		//if (json == null) json = {};
		////var index:Int = valueList.indexOf(this.value);
		////if (index != -1) json.choice = choiceList[index];
		//json.value = this.value;
		//return super.toJSON(json);
	//}
	
}