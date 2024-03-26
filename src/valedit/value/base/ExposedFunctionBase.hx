package valedit.value.base;

/**
 * ...
 * @author Matse
 */
abstract class ExposedFunctionBase extends ExposedValue 
{
	public var propagateTemplateFunctionCallToInstances:Bool = true;
	
	public function new(propertyName:String, name:String=null) 
	{
		super(propertyName, name);
		
	}
	
	abstract public function getExposedValueParameters(?values:Array<ExposedValue>):Array<ExposedValue>;
	
	abstract public function execute():Void;
	
	abstract public function executeWithParameters(parameters:Array<Dynamic>):Void;
	
}