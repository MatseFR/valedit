package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedFunction extends ExposedValue 
{
	//public var parameterNames:Array<String>;
	
	private var _parameters:Array<Dynamic>;// = new Array<Dynamic>();
	private var _parameterValues:Array<Dynamic> = new Array<Dynamic>();
	
	/**
	   
	   @param	propertyName
	   @param	name
	**/
	public function new(propertyName:String, name:String=null, parameters:Array<Dynamic> = null) 
	{
		super(propertyName, name);
		//if (parameterNames == null) parameterNames = new Array<String>();
		//this.parameterNames = parameterNames;
		if (parameters == null) parameters = new Array<Dynamic>();
		this._parameters = parameters;
	}
	
	public function addParameter(param:Dynamic):Void
	{
		this._parameters.push(param);
	}
	
	/**
	   
	**/
	public function execute():Void
	{
		//if (_parameterValues.length == 0 && parameterNames.length != 0)
		//{
			//var val:ExposedValue;
			//for (valName in parameterNames)
			//{
				//val = _collection.getValue(valName);
				//if (val != null) _parameterValues.push(val);
			//}
		//}
		//
		//for (paramValue in _parameterValues)
		//{
			//_parameters.push(paramValue.value);
		//}
		//
		//Reflect.callMethod(_object, this.value, _parameters);
		//_parameters.resize(0);
		var str:String;
		var val:ExposedValue;
		for (param in this._parameters)
		{
			if (Std.isOfType(param, String))
			{
				str = param;
				if (str.indexOf(ValEdit.EXPOSED_VALUE_MARKER) == 0)
				{
					val = _collection.getValue(str.substr(ValEdit.EXPOSED_VALUE_MARKER.length));
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
		
		Reflect.callMethod(_object, this.value, this._parameterValues);
		this._parameterValues.resize(0);
		
		if (this.updateCollectionUIOnChange) this._collection.uiCollection.update(this._uiControl);
	}
	
	override public function clone():ExposedValue 
	{
		//var func:ExposedFunction = new ExposedFunction(this.propertyName, this.name, parameterNames.copy());
		var func:ExposedFunction = new ExposedFunction(this.propertyName, this.name, this._parameters.copy());
		super.clone_internal(func);
		return func;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		var data:Array<Dynamic>;
		data = json.params;
		if (data != null)
		{
			for (param in data)
			{
				//parameterNames.push(paramName);
				this._parameters.push(param);
			}
		}
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		json.params = [];
		for (param in this._parameters)
		{
			json.params.push(param);
		}
		return super.toJSON(json);
	}
	
}