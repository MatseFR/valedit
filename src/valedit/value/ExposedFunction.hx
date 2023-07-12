package valedit.value;

import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedFunction extends ExposedValue 
{
	static private var _POOL:Array<ExposedFunction> = new Array<ExposedFunction>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null, parameters:Array<Dynamic> = null):ExposedFunction
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, parameters);
		return new ExposedFunction(propertyName, name, parameters);
	}
	
	public var parameters:Array<Dynamic> = new Array<Dynamic>();
	
	override function set_isEditable(value:Bool):Bool 
	{
		if (this._isEditable == value) return value;
		for (param in this._parameterValuesAll)
		{
			param.isEditable = value;
		}
		return super.set_isEditable(value);
	}
	
	override function set_isReadOnly(value:Bool):Bool 
	{
		if (this._isReadOnly == value) return value;
		for (param in this._parameterValues)
		{
			param.isReadOnly = value;
		}
		return super.set_isReadOnly(value);
	}
	
	private var _parameterValuesAll:Array<ExposedValue> = new Array<ExposedValue>();
	private var _parameterValues:Array<ExposedValue> = new Array<ExposedValue>();
	private var _stringParamToValue:Map<String, ExposedValue> = new Map<String, ExposedValue>();
	
	private var _values:Array<Dynamic> = new Array<Dynamic>();
	
	/**
	   
	   @param	propertyName
	   @param	name
	**/
	public function new(propertyName:String, name:String=null, parameters:Array<Dynamic> = null) 
	{
		super(propertyName, name);
		
		if (parameters == null) parameters = new Array<Dynamic>();
		for (param in parameters)
		{
			addParameter(param);
		}
	}
	
	override public function clear():Void 
	{
		super.clear();
		this.parameters.resize(0);
		this._parameterValuesAll.resize(0);
		this._parameterValues.resize(0);
		this._stringParamToValue.clear();
		this._values.resize(0);
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, parameters:Array<Dynamic> = null):ExposedFunction
	{
		setNames(propertyName, name);
		if (parameters == null) parameters = new Array<Dynamic>();
		for (param in parameters)
		{
			addParameter(param);
		}
		return this;
	}
	
	override public function applyToObject(object:Dynamic):Void 
	{
		// nothing
	}
	
	override public function readValue(dispatchEventIfChange:Bool = true):Void 
	{
		for (param in this._parameterValuesAll)
		{
			param.readValue(false);
		}
	}
	
	/**
	   - if param is a String and it starts with ValEdit.EXPOSED_VALUE_MARKER the function 
	   will look for an exposed value with that name and use its value for the function call
	   - if param is an ExposedValue instance, a ValueUI control will be shown and its value
	   will be used for the function call
	   @param	param
	**/
	public function addParameter(param:Dynamic):Void
	{
		var val:ExposedValue;
		this.parameters.push(param);
		if (Std.isOfType(param, String))
		{
			var str:String = param;
			if (str.indexOf(ValEdit.EXPOSED_VALUE_MARKER) == 0)
			{
				val = this._collection.getValue(str.substr(ValEdit.EXPOSED_VALUE_MARKER.length));
				val = val.clone(true);
				val.isEditable = this._isEditable;
				val.forceReadOnly(true);
				val.isReadOnlyLocked = true;
				val.object = this._object;
				this._parameterValuesAll.push(val);
				this._stringParamToValue.set(str, val);
			}
		}
		else if (Std.isOfType(param, ExposedValue))
		{
			val = cast param;
			val.isEditable = this._isEditable;
			val.isReadOnly = this._isReadOnly;
			this._parameterValues.push(cast param);
			this._parameterValuesAll.push(cast param);
		}
	}
	
	public function getExposedValueParameters(?values:Array<ExposedValue>):Array<ExposedValue>
	{
		if (values == null) values = new Array<ExposedValue>();
		
		var str:String;
		var val:ExposedValue;
		
		for (param in this.parameters)
		{
			if (Std.isOfType(param, String))
			{
				str = param;
				if (str.indexOf(ValEdit.EXPOSED_VALUE_MARKER) == 0)
				{
					val = this._stringParamToValue.get(str);
					values.push(val);
				}
			}
			else if (Std.isOfType(param, ExposedValue))
			{
				values.push(cast param);
			}
		}
		
		return values;
	}
	
	/**
	   
	**/
	public function execute():Void
	{
		var str:String;
		var val:ExposedValue;
		for (param in this.parameters)
		{
			if (Std.isOfType(param, String))
			{
				str = param;
				if (str.indexOf(ValEdit.EXPOSED_VALUE_MARKER) == 0)
				{
					//val = this._collection.getValue(str.substr(ValEdit.EXPOSED_VALUE_MARKER.length));
					val = this._stringParamToValue.get(str);
					this._values.push(val.value);
				}
				else
				{
					this._values.push(param);
				}
			}
			else if (Std.isOfType(param, ExposedValue))
			{
				val = cast param;
				if (val.isRealValue)
				{
					this._values.push(val.value);
				}
			}
			else
			{
				this._values.push(param);
			}
		}
		
		Reflect.callMethod(this._object, this.value, this._values);
		this._values.resize(0);
		
		if (this.updateCollectionUIOnChange) this._collection.readValues();
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var func:ExposedFunction = fromPool(this.propertyName, this.name, this.parameters.copy());
		super.clone_internal(func, copyValue);
		return func;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		//super.fromJSON(json);
		//var data:Array<Dynamic>;
		//data = json.params;
		//if (data != null)
		//{
			//for (param in data)
			//{
				//this.parameters.push(param);
			//}
		//}
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		//if (json == null) json = {};
		//json.params = [];
		//for (param in this.parameters)
		//{
			//json.params.push(param);
		//}
		//return super.toJSON(json);
		return null;
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		// nothing
	}
	
}