package valedit.value;
#if desktop
import valedit.value.base.ExposedValue;

/**
 * Desktop targets only (Neko, CPP, Air...)
 * @author Matse
 */
class ExposedPath extends ExposedValue 
{
	static private var _POOL:Array<ExposedPath> = new Array<ExposedPath>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null, ?dialogTitle:String):ExposedPath
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, dialogTitle);
		return new ExposedPath(propertyName, name, dialogTitle);
	}
	
	public var dialogTitle:String;
	
	public function new(propertyName:String, name:String=null, ?dialogTitle:String) 
	{
		super(propertyName, name);
		this.dialogTitle = dialogTitle;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, dialogTitle:String):ExposedPath
	{
		setNames(propertyName, name);
		this.dialogTitle = dialogTitle;
		return this;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var path:ExposedPath = fromPool(this.propertyName, this.name, this.dialogTitle);
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