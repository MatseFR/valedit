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
	
	static public function fromPool(propertyName:String, name:String = null):ExposedPath
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name);
		return new ExposedPath(propertyName, name);
	}
	
	#if valeditor
	public var dialogTitle:String;
	public var liveTyping:Bool = true;
	#end
	
	public function new(propertyName:String, name:String = null) 
	{
		super(propertyName, name);
	}
	
	override public function clear():Void 
	{
		super.clear();
		#if valeditor
		this.dialogTitle = null;
		this.liveTyping = true;
		#end
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String):ExposedPath
	{
		setNames(propertyName, name);
		return this;
	}
	
	public function clone(copyValue:Bool = false):ExposedValue 
	{
		var path:ExposedPath = fromPool(this.propertyName, this.name);
		#if valeditor
		path.liveTyping = this.liveTyping;
		path.dialogTitle = this.dialogTitle;
		#end
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