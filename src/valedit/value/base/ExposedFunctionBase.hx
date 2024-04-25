package valedit.value.base;
import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
abstract class ExposedFunctionBase extends ExposedValue 
{
	#if valeditor
	public var isParametersUIOpen:Bool = false;
	#end
	public var propagateTemplateFunctionCallToInstances:Bool = true;
	
	public function new(propertyName:String, name:String=null) 
	{
		super(propertyName, name);
	}
	
	override public function clear():Void 
	{
		#if valeditor
		this.isParametersUIOpen = false;
		#end
		this.propagateTemplateFunctionCallToInstances = true;
		super.clear();
	}
	
	override function clone_internal(value:ExposedValue, copyValue:Bool = false):Void 
	{
		cast(value, ExposedFunctionBase).propagateTemplateFunctionCallToInstances = this.propagateTemplateFunctionCallToInstances;
		super.clone_internal(value, copyValue);
	}
	
	abstract public function getExposedValueParameters(?values:Array<ExposedValue>):Array<ExposedValue>;
	
	abstract public function execute():Void;
	
	abstract public function executeWithParameters(parameters:Array<Dynamic>):Void;
	
}