package valedit.value;

import haxe.Timer;
import valedit.value.base.ExposedFunctionBase;
import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedFunctionExternal extends ExposedFunctionBase 
{
	static private var _POOL:Array<ExposedFunctionExternal> = new Array<ExposedFunctionExternal>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null, callObject:Dynamic = null, parameters:Array<Dynamic> = null):ExposedFunctionExternal
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, callObject, parameters);
		return new ExposedFunctionExternal(propertyName, name, callObject, parameters);
	}
	
	public var callObject(get, set):Dynamic;
	public var parameters:Array<Dynamic> = new Array<Dynamic>();
	
	private var _callObject:Dynamic;
	private function get_callObject():Dynamic { return this._callObject; }
	private function set_callObject(value:Dynamic):Dynamic
	{
		if (this._callObject == value) return value;
		if (value == null)
		{
			this.value = null;
		}
		else
		{
			this.value = Reflect.getProperty(value, this.propertyName);
		}
		return this._callObject = value;
	}
	
	override function set_isEditable(value:Bool):Bool 
	{
		if (this._isEditable == value) return value;
		for (param in this._parameterValuesEditable)
		{
			param.isEditable = value;
		}
		return super.set_isEditable(value);
	}
	
	override function set_isReadOnly(value:Bool):Bool 
	{
		if (this._isReadOnly == value) return value;
		for (param in this._parameterValuesEditable)
		{
			param.isReadOnly = value;
		}
		return super.set_isReadOnly(value);
	}
	
	override function set_object(value:Dynamic):Dynamic 
	{
		if (this._object == value) return value;
		super.set_object(value);
		buildParameterValues();
		return this._object;
	}
	
	override function get_value():Dynamic 
	{
		return this._storedValue;
	}
	override function set_value(value:Dynamic):Dynamic 
	{
		#if valeditor
		if (this._storedValue != value)
		{
			this._storedValue = value;
			this.lastChanged = Timer.stamp();
		}
		#else
		this._storedValue = value;
		#end
		return this._storedValue;
	}
	
	private var _parameterValues:Array<ExposedValue> = new Array<ExposedValue>();
	private var _parameterValuesEditable:Array<ExposedValue> = new Array<ExposedValue>();
	private var _parameterValuesToPool:Array<ExposedValue> = new Array<ExposedValue>();
	
	private var _values:Array<Dynamic> = new Array<Dynamic>();
	
	public function new(propertyName:String, name:String = null, callObject:Dynamic = null, parameters:Array<Dynamic> = null)
	{
		super(propertyName, name);
		
		this.callObject = callObject;
		if (parameters != null)
		{
			for (param in parameters)
			{
				addParameter(param);
			}
		}
		this.checkForChange = false;
	}
	
	override public function clear():Void 
	{
		this.callObject = null;
		super.clear();
		this.checkForChange = false;
		this.parameters.resize(0);
		for (value in this._parameterValues)
		{
			value.pool();
		}
		this._parameterValues.resize(0);
		this._parameterValuesEditable.resize(0);
		this._parameterValuesToPool.resize(0);
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, callObject:Dynamic = null, parameters:Array<Dynamic>):ExposedFunctionExternal
	{
		setNames(propertyName, name);
		if (parameters != null)
		{
			for (param in parameters)
			{
				addParameter(param);
			}
		}
		return this;
	}
	
	override public function applyToObject(object:Dynamic, applyIfDefaultValue:Bool = false):Void 
	{
		// nothing
	}
	
	override public function isDifferentFrom(value:ExposedValue):Bool 
	{
		var func:ExposedFunctionExternal = cast value;
		var paramCount:Int = this._parameterValues.length;
		
		for (i in 0...paramCount)
		{
			if (this._parameterValues[i].isDifferentFrom(func._parameterValues[i])) return true;
		}
		
		return false;
	}
	
	override public function readValue(dispatchEventIfChange:Bool = true):Void 
	{
		for (param in this._parameterValues)
		{
			param.readValue(false);
		}
	}
	
	override public function readValueFromObject(object:Dynamic, dispatchEventIfChange:Bool = false):Void 
	{
		// nothing
	}
	
	override public function reassignValue():Void 
	{
		// nothing
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
		this.parameters.push(param);
	}
	
	public function buildParameterValues():Void
	{
		clearParameterValues();
		
		var str:String;
		var val:ExposedValue;
		for (param in this.parameters)
		{
			if (Std.isOfType(param, Bool))
			{
				val = ExposedBool.fromPool(null);
				val.isEditable = false;
				val.isReadOnly = true;
				val.value = param;
				this._parameterValues[this._parameterValues.length] = val;
				this._parameterValuesToPool[this._parameterValuesToPool.length] = val;
			}
			else if (Std.isOfType(param, Float))
			{
				val = ExposedFloat.fromPool(null);
				val.isEditable = false;
				val.isReadOnly = true;
				val.value = param;
				this._parameterValues[this._parameterValues.length] = val;
				this._parameterValuesToPool[this._parameterValuesToPool.length] = val;
			}
			else if (Std.isOfType(param, Int))
			{
				val = ExposedInt.fromPool(null);
				val.isEditable = false;
				val.isReadOnly = true;
				val.value = param;
				this._parameterValues[this._parameterValues.length] = val;
				this._parameterValuesToPool[this._parameterValuesToPool.length] = val;
			}
			else if (Std.isOfType(param, String))
			{
				str = param;
				if (str.indexOf(ValEdit.EXPOSED_VALUE_MARKER) == 0)
				{
					// TODO : replace this with reference values
					val = this._collection.getValue(str.substr(ValEdit.EXPOSED_VALUE_MARKER.length));
					val = val.clone(true);
					val.isEditable = false;
					val.isReadOnly = true;
					val.object = this._object;
					#if valeditor
					val.valEditorObject = this._valEditorObject;
					#end
					this._parameterValues[this._parameterValues.length] = val;
					this._parameterValuesToPool[this._parameterValuesToPool.length] = val;
				}
				else
				{
					val = ExposedString.fromPool(null);
					val.isEditable = false;
					val.isReadOnly = true;
					val.value = param;
					this._parameterValues[this._parameterValues.length] = val;
					this._parameterValuesToPool[this._parameterValuesToPool.length] = val;
				}
			}
			else if (Std.isOfType(param, ExposedValue))
			{
				val = cast param;
				val.isEditable = this._isEditable;
				val.isReadOnly = this._isReadOnly;
				val.object = this._object;
				#if valeditor
				val.valEditorObject = this._valEditorObject;
				#end
				this._parameterValues[this._parameterValues.length] = val;
				this._parameterValuesEditable[this._parameterValuesEditable.length] = val;
			}
		}
	}
	
	private function clearParameterValues():Void
	{
		this._parameterValues.resize(0);
		this._parameterValuesEditable.resize(0);
		for (value in this._parameterValuesToPool)
		{
			value.pool();
		}
		this._parameterValuesToPool.resize(0);
	}
	
	public function getExposedValueParameters(?values:Array<ExposedValue>):Array<ExposedValue>
	{
		if (values == null) values = new Array<ExposedValue>();
		
		var count:Int = this._parameterValues.length;
		for (i in 0...count)
		{
			values[i] = this._parameterValues[i];
		}
		
		return values;
	}
	
	public function execute():Void
	{
		for (val in this._parameterValues)
		{
			if (val.isRealValue)
			{
				this._values[this._values.length] = val.value;
			}
		}
		
		Reflect.callMethod(this.callObject, this.value, this._values);
		#if valeditor
		if (this._valEditorObject != null)
		{
			this._valEditorObject.functionCalled(this.propertyName, this._values);
		}
		#end
		this._values.resize(0);
		
		if (this.parentValue != null) this.parentValue.childValueChanged(this);
		if (this.updateCollectionOnChange && !this.updateCollectionLocked) this._collection.readValues();
	}
	
	public function executeWithParameters(parameters:Array<Dynamic>):Void
	{
		Reflect.callMethod(this.callObject, this.value, parameters);
		
		if (this.parentValue != null) this.parentValue.childValueChanged(this);
		if (this.updateCollectionOnChange && !this.updateCollectionLocked) this._collection.readValues();
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue
	{
		var func:ExposedFunctionExternal = fromPool(this.propertyName, this.name, this.callObject, this.parameters);
		super.clone_internal(func, copyValue);
		return func;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		//super.fromJSON(json);
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		//return super.toJSON(json);
		return null;
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		//super.toJSONSimple(json);
	}
	
}