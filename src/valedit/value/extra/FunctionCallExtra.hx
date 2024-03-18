package valedit.value.extra;
import haxe.Constraints.Function;
import valedit.value.base.ExposedValue;
import valedit.value.extra.ValueExtra;

/**
 * ...
 * @author Matse
 */
class FunctionCallExtra extends ValueExtra 
{
	static private var _POOL:Array<FunctionCallExtra> = new Array<FunctionCallExtra>();
	
	static public function fromPool(functionName:String, ?parameters:Array<Dynamic>):FunctionCallExtra
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(functionName, parameters);
		return new FunctionCallExtra(functionName, parameters);
	}
	
	override function set_object(value:Dynamic):Dynamic 
	{
		if (value == null)
		{
			this._function = null;
		}
		else
		{
			this._function = Reflect.getProperty(value, this._functionName);
		}
		return super.set_object(value);
	}
	
	private var _function:Function;
	private var _functionName:String;
	private var _parameters:Array<Dynamic>;
	private var _parameterValues:Array<Dynamic> = new Array<Dynamic>();
	
	public function new(functionName:String, ?parameters:Array<Dynamic>)
	{
		super();
		
		this._functionName = functionName;
		if (parameters == null) parameters = new Array<Dynamic>();
		this._parameters = parameters;
	}
	
	override public function clear():Void
	{
		this._function = null;
		this._parameters = null;
		super.clear();
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(functionName:String, ?parameters:Array<Dynamic>):FunctionCallExtra
	{
		this._functionName = functionName;
		if (parameters == null) parameters = new Array<Dynamic>();
		this._parameters = parameters;
		return this;
	}
	
	public function addParameter(param:Dynamic):Void
	{
		this._parameters.push(param);
	}
	
	public function clone():ValueExtra 
	{
		var func:FunctionCallExtra = FunctionCallExtra.fromPool(this._functionName, this._parameters.copy());
		this.clone_internal(func);
		return func;
	}
	
	public function applyToObject(object:Dynamic):Void 
	{
		var str:String;
		var val:ExposedValue;
		for (param in this._parameters)
		{
			if (Std.isOfType(param, String))
			{
				str = param;
				if (str.indexOf(ValEdit.EXPOSED_VALUE_MARKER) == 0)
				{
					val = this._collection.getValue(str.substr(ValEdit.EXPOSED_VALUE_MARKER.length));
					this._parameterValues.push(val.value);
				}
				else
				{
					this._parameterValues.push(param);
				}
			}
			else
			{
				this._parameterValues.push(param);
			}
		}
		
		Reflect.callMethod(object, Reflect.getProperty(object, this._functionName), this._parameterValues);
		this._parameterValues.resize(0);
	}
	
	public function execute():Void 
	{
		var str:String;
		var val:ExposedValue;
		for (param in this._parameters)
		{
			if (Std.isOfType(param, String))
			{
				str = param;
				if (str.indexOf(ValEdit.EXPOSED_VALUE_MARKER) == 0)
				{
					val = this._collection.getValue(str.substr(ValEdit.EXPOSED_VALUE_MARKER.length));
					this._parameterValues.push(val.value);
				}
				else
				{
					this._parameterValues.push(param);
				}
			}
			else
			{
				this._parameterValues.push(param);
			}
		}
		
		Reflect.callMethod(this._object, this._function, this._parameterValues);
		this._parameterValues.resize(0);
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		this._functionName = json.funcName;
		this._parameters = json.params;
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		
		json.funcName = this._functionName;
		json.params = this._parameters.copy();
		
		return super.toJSON(json);
	}
	
}