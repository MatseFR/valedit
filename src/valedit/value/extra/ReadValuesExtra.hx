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
	private var _dispatchEventIfChange:Bool;
	private var _valueNames:Array<String> = new Array<String>();
	
	public function new(dispatchEventIfChange:Bool = false, ?valueNames:Array<String>)
	{
		super();
		this._dispatchEventIfChange = dispatchEventIfChange;
		if (valueNames != null) addValues(valueNames);
	}
	
	public function addValue(propertyName:String):Void
	{
		_valueNames[_valueNames.length] = propertyName;
	}
	
	public function addValues(propertyNames:Array<String>):Void
	{
		for (propertyName in propertyNames)
		{
			_valueNames[_valueNames.length] = propertyName;
		}
	}
	
	override public function clone():ValueExtra 
	{
		var read:ReadValuesExtra = new ReadValuesExtra(this._dispatchEventIfChange, this._valueNames);
		this.clone_internal(read);
		return read;
	}
	
	override public function applyToObject(object:Dynamic):Void 
	{
		var collection:ExposedCollection = null;
		if (Std.isOfType(object, ValEditObject))
		{
			collection = cast(object, ValEditObject).collection;
		}
		else
		{
			var valObject:ValEditObject = ValEdit.getValEditObjectFromObject(object);
			if (valObject == null)
			{
				return;
			}
			collection = valObject.collection;
		}
		
		var value:ExposedValue;
		for (propertyName in this._valueNames)
		{
			value = collection.getValue(propertyName);
			value.readValue(this._dispatchEventIfChange);
		}
	}
	
	override public function execute():Void 
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