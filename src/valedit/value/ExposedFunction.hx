package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedFunction extends ExposedValue 
{
	public var parameters:Array<Dynamic>;
	
	private var _parameterValues:Array<Dynamic> = new Array<Dynamic>();
	
	/**
	   
	   @param	propertyName
	   @param	name
	**/
	public function new(propertyName:String, name:String=null, parameters:Array<Dynamic> = null) 
	{
		super(propertyName, name);
		
		if (parameters == null) parameters = new Array<Dynamic>();
		this.parameters = parameters;
	}
	
	override public function applyToObject(object:Dynamic):Void 
	{
		// nothing
	}
	
	override public function readValue():Void 
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
	
	public function getExposedValueParameters(?values:Array<ExposedValue>):Array<ExposedValue>
	{
		if (values == null) values = new Array<ExposedValue>();
		
		for (param in this.parameters)
		{
			if (Std.isOfType(param, ExposedValue))
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
					val = _collection.getValue(str.substr(ValEdit.EXPOSED_VALUE_MARKER.length));
					this._parameterValues.push(val.value);
				}
				else
				{
					this._parameterValues.push(param);
				}
			}
			else if (Std.isOfType(param, ExposedValue))
			{
				val = cast param;
				if (val.isRealValue)
				{
					this._parameterValues.push(val.value);
				}
			}
			else
			{
				this._parameterValues.push(param);
			}
		}
		
		Reflect.callMethod(this._object, this.value, this._parameterValues);
		this._parameterValues.resize(0);
		
		if (this.updateCollectionUIOnChange) this._collection.uiCollection.update(this._uiControl);
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var func:ExposedFunction = new ExposedFunction(this.propertyName, this.name, this.parameters.copy());
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