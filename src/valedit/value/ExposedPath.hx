package valedit.value;
#if desktop
import valedit.ExposedValue;

/**
 * Desktop targets only (Neko, CPP, Air...)
 * @author Matse
 */
class ExposedPath extends ExposedValue 
{
	public var dialogTitle:String;
	
	public function new(propertyName:String, name:String=null, ?dialogTitle:String) 
	{
		super(propertyName, name);
		this.dialogTitle = dialogTitle;
		this.defaultValue = null;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var path:ExposedPath = new ExposedPath(this.propertyName, this.name, this.dialogTitle);
		clone_internal(path, copyValue);
		return path;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		if (json.value != null)
		{
			this.value = json.value;
		}
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		json.value = this.value;
		return super.toJSON(json);
	}
	
}
#end