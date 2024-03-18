package valedit.value.extra;
import valedit.ExposedCollection;
import valedit.ValEditObject;
import valedit.value.base.ExposedValue;
import valedit.value.extra.ValueExtra;

/**
 * ...
 * @author Matse
 */
class ReassignLastChangedValueExtra extends ValueExtra 
{
	static private var _POOL:Array<ReassignLastChangedValueExtra> = new Array<ReassignLastChangedValueExtra>();
	
	static public function fromPool(?propertyNames:Array<String>):ReassignLastChangedValueExtra
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyNames);
		return new ReassignLastChangedValueExtra(propertyNames);
	}
	
	private var _valueNames:Array<String> = new Array<String>();
	
	private var _values:Array<ExposedValue> = new Array<ExposedValue>();
	
	public function new(?propertyNames:Array<String>) 
	{
		super();
		if (propertyNames != null) addValues(propertyNames);
	}
	
	override public function clear():Void 
	{
		this._valueNames.resize(0);
		super.clear();
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(?propertyNames:Array<String>):ReassignLastChangedValueExtra
	{
		if (propertyNames != null) addValues(propertyNames);
		return this;
	}
	
	public function addValue(propertyName:String):Void
	{
		this._valueNames[this._valueNames.length] = propertyName;
	}
	
	public function addValues(propertyNames:Array<String>):Void
	{
		for (propertyName in propertyNames)
		{
			this._valueNames[this._valueNames.length] = propertyName;
		}
	}
	
	public function clone():ValueExtra 
	{
		var reassign:ReassignLastChangedValueExtra = ReassignLastChangedValueExtra.fromPool(this._valueNames);
		clone_internal(reassign);
		return reassign;
	}
	
	public function applyToObject(object:Dynamic):Void 
	{
		var collection:ExposedCollection;
		if (Std.isOfType(object, ValEditObject))
		{
			collection = cast(object, ValEditObject).currentCollection;
		}
		else
		{
			var valObject:ValEditObject = ValEdit.getValEditObjectFromObject(object);
			if (valObject == null)
			{
				return;
			}
			collection = valObject.currentCollection;
		}
		
		var value:ExposedValue;
		var maxTime:Float = ValEdit.TIME_STAMP_ORIGIN;
		for (propertyName in this._valueNames)
		{
			value = collection.getValue(propertyName);
			this._values[this._values.length] = value;
			if (value.lastChanged > maxTime)
			{
				maxTime = value.lastChanged;
			}
		}
		
		for (val in this._values)
		{
			if (val.lastChanged == maxTime)
			{
				val.reassignValue();
			}
		}
		this._values.resize(0);
	}
	
	public function execute():Void 
	{
		var value:ExposedValue;
		var maxTime:Float = ValEdit.TIME_STAMP_ORIGIN;
		for (propertyName in this._valueNames)
		{
			value = collection.getValue(propertyName);
			this._values[this._values.length] = value;
			if (value.lastChanged > maxTime)
			{
				maxTime = value.lastChanged;
			}
		}
		
		for (val in this._values)
		{
			if (val.lastChanged == maxTime)
			{
				val.reassignValue();
			}
		}
		this._values.resize(0);
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		this._valueNames = json.valueNames;
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		
		json.valueNames = this._valueNames.copy();
		
		return super.toJSON(json);
	}
	
}