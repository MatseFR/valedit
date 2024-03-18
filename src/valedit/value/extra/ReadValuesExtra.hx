package valedit.value.extra;
import valedit.ExposedCollection;
import valedit.ValEditObject;
import valedit.value.base.ExposedValue;
import valedit.value.extra.ValueExtra;

/**
 * ...
 * @author Matse
 */
class ReadValuesExtra extends ValueExtra 
{
	static private var _POOL:Array<ReadValuesExtra> = new Array<ReadValuesExtra>();
	
	static public function fromPool(dispatchEventIfChange:Bool = false, ?valueNames:Array<String>):ReadValuesExtra
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(dispatchEventIfChange, valueNames);
		return new ReadValuesExtra(dispatchEventIfChange, valueNames);
	}
	
	private var _dispatchEventIfChange:Bool;
	private var _valueNames:Array<String> = new Array<String>();
	
	public function new(dispatchEventIfChange:Bool = false, ?valueNames:Array<String>)
	{
		super();
		this._dispatchEventIfChange = dispatchEventIfChange;
		if (valueNames != null) addValues(valueNames);
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
	
	private function setTo(dispatchEventIfChange:Bool, ?valueNames:Array<String>):ReadValuesExtra
	{
		this._dispatchEventIfChange = dispatchEventIfChange;
		if (valueNames != null) addValues(valueNames);
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
		var read:ReadValuesExtra = ReadValuesExtra.fromPool(this._dispatchEventIfChange, this._valueNames);
		clone_internal(read);
		return read;
	}
	
	public function applyToObject(object:Dynamic):Void 
	{
		var collection:ExposedCollection = null;
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
		for (propertyName in this._valueNames)
		{
			value = collection.getValue(propertyName);
			value.readValue(this._dispatchEventIfChange);
		}
	}
	
	public function execute():Void 
	{
		var value:ExposedValue;
		for (propertyName in this._valueNames)
		{
			value = this._collection.getValue(propertyName);
			value.readValue(this._dispatchEventIfChange);
		}
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		this._dispatchEventIfChange = json.dispatchEventIfChange;
		this._valueNames = json.valueNames;
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		
		json.dispatchEventIfChange = this._dispatchEventIfChange;
		json.valueNames = this._valueNames.copy();
		
		return super.toJSON(json);
	}
	
}