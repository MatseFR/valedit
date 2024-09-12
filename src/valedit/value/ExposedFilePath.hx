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
	
	static public function fromPool(propertyName:String, name:String = null):ExposedFilePath
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name);
		return new ExposedFilePath(propertyName, name);
	}
	
	#if valeditor
	public var dialogTitle:String;
	public var fileMustExist:Bool = true;
	public var fileFilters:Array<FileFilter>;
	public var liveTyping:Bool = true;
	#end

	public function new(propertyName:String, name:String=null) 
	{
		super(propertyName, name);
	}
	
	override public function clear():Void 
	{
		super.clear();
		#if valeditor
		this.dialogTitle = null;
		this.fileMustExist = true;
		this.fileFilters.resize(0);
		this.liveTyping = true;
		#end
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String):ExposedFilePath
	{
		setNames(propertyName, name);
		return this;
	}
	
	public function addFilter(description:String, extension:String, ?macType:String):Void
	{
		var filter:FileFilter = new FileFilter(description, extension, macType);
		this.fileFilters.push(filter);
	}
	
	public function clone(copyValue:Bool = false):ExposedValue 
	{
		var file:ExposedFilePath = fromPool(this.propertyName, this.name);
		#if valeditor
		file.dialogTitle = this.dialogTitle;
		file.fileMustExist = this.fileMustExist;
		file.liveTyping = this.liveTyping;
		for (filter in this.fileFilters)
		{
			file.addFilter(filter.description, filter.extension, filter.macType);
		}
		#end
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