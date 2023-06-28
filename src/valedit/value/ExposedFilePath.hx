package valedit.value;
import openfl.net.FileFilter;
#if desktop
import valedit.ExposedValue;

/**
 * Desktop targets only (Neko, CPP, Air...)
 * @author Matse
 */
class ExposedFilePath extends ExposedValue 
{
	public var dialogTitle:String;
	public var fileMustExist:Bool;
	public var fileFilters:Array<FileFilter>;

	public function new(propertyName:String, name:String=null, fileMustExist:Bool = true, ?fileFilters:Array<FileFilter>, ?dialogTitle:String) 
	{
		super(propertyName, name);
		this.fileMustExist = fileMustExist;
		if (fileFilters == null) fileFilters = new Array<FileFilter>();
		this.fileFilters = fileFilters;
		this.dialogTitle = dialogTitle;
		this.defaultValue = null;
	}
	
	public function addFilter(description:String, extension:String, ?macType:String):Void
	{
		var filter:FileFilter = new FileFilter(description, extension, macType);
		this.fileFilters.push(filter);
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var file:ExposedFilePath = new ExposedFilePath(this.propertyName, this.name, this.fileMustExist, this.dialogTitle);
		for (filter in this.fileFilters)
		{
			file.addFilter(filter.description, filter.extension, filter.macType);
		}
		clone_internal(file, copyValue);
		return file;
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