package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedFunction extends ExposedValue 
{
	public var parameterNames:Array<String>;
	
	private var _parameters:Array<Dynamic> = new Array<Dynamic>();
	private var _parameterValues:Array<ExposedValue> = new Array<ExposedValue>();
	
	/**
	   
	   @param	propertyName
	   @param	name
	**/
	public function new(propertyName:String, name:String=null, parameterNames:Array<String> = null) 
	{
		super(propertyName, name);
		if (parameterNames == null) parameterNames = new Array<String>();
		this.parameterNames = parameterNames;
	}
	
	/**
	   
	**/
	public function execute():Void
	{
		if (_parameterValues.length == 0 && parameterNames.length != 0)
		{
			var val:ExposedValue;
			for (valName in parameterNames)
			{
				val = _collection.getValue(valName);
				if (val != null) _parameterValues.push(val);
			}
		}
		
		for (paramValue in _parameterValues)
		{
			_parameters.push(paramValue.value);
		}
		
		Reflect.callMethod(_object, this.value, _parameters);
		_parameters.resize(0);
		
		if (this.updateCollectionUIOnChange) this._collection.uiCollection.update(this._uiControl);
	}
	
	override public function clone():ExposedValue 
	{
		var func:ExposedFunction = new ExposedFunction(this.propertyName, this.name, parameterNames.copy());
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
			for (paramName in data)
			{
				parameterNames.push(paramName);
			}
		}
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		json.params = [];
		for (paramName in parameterNames)
		{
			json.params.push(paramName);
		}
		return super.toJSON(json);
	}
	
}