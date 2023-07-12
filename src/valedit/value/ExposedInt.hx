package valedit.value;

import valeditor.ui.feathers.variant.TextInputVariant;
import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedInt extends ExposedValue 
{
	static private var _POOL:Array<ExposedInt> = new Array<ExposedInt>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null, numericMode:NumericMode = NumericMode.PositiveOrNegative, inputVariant:String = TextInputVariant.FULL_WIDTH):ExposedInt
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, numericMode, inputVariant);
		return new ExposedInt(propertyName, name, numericMode, inputVariant);
	}
	
	public var numericMode:NumericMode;
	public var inputVariant:String;
	
	/**
	   
	   @param	propertyName
	   @param	name
	   @param	numericMode
	   @param	inputPercentWidth
	**/
	public function new(propertyName:String, name:String = null, numericMode:NumericMode = NumericMode.PositiveOrNegative, inputVariant:String = TextInputVariant.FULL_WIDTH) 
	{
		super(propertyName, name);
		this.numericMode = numericMode;
		this.inputVariant = inputVariant;
		this.defaultValue = 0;
	}
	
	override public function clear():Void 
	{
		super.clear();
		this.defaultValue = 0;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, numericMode:NumericMode, inputVariant:String):ExposedInt
	{
		setNames(propertyName, name);
		this.numericMode = numericMode;
		this.inputVariant = inputVariant;
		return this;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var int:ExposedInt = fromPool(this.propertyName, this.name, this.numericMode, this.inputVariant);
		super.clone_internal(int, copyValue);
		return int;
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