package valedit.value;
#if desktop
import openfl.net.FileFilter;
import valedit.value.base.ExposedValue;

/**
 * Desktop targets only (Neko, CPP, Air...)
 * @author Matse
 */
class ExposedFilePath extends ExposedValue 
{
	static private var _POOL:Array<ExposedFilePath> = new Array<ExposedFilePath>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null, fileMustExist:Bool = true, ?fileFilters:Array<FileFilter>, ?dialogTitle:String):ExposedFilePath
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, fileMustExist, fileFilters, dialogTitle);
		return new ExposedFilePath(propertyName, name, fileMustExist, fileFilters, dialogTitle);
	}
	
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
	}
	
	override public function clear():Void 
	{
		super.clear();
		this.fileFilters = null;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, fileMustExist:Bool, fileFilters:Array<FileFilter>, dialogTitle:String):ExposedFilePath
	{
		setNames(propertyName, name);
		this.fileMustExist = fileMustExist;
		if (fileFilters == null) fileFilters = new Array<FileFilter>();
		this.fileFilters = fileFilters;
		this.dialogTitle = dialogTitle;
		return this;
	}
	
	public function addFilter(description:String, extension:String, ?macType:String):Void
	{
		var filter:FileFilter = new FileFilter(description, extension, macType);
		this.fileFilters.push(filter);
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var file:ExposedFilePath = fromPool(this.propertyName, this.name, this.fileMustExist, this.dialogTitle);
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