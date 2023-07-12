package valedit.value;

import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedFontName extends ExposedValue 
{
	static private var _POOL:Array<ExposedFontName> = new Array<ExposedFontName>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null, includeSystemFonts:Bool = true):ExposedFontName
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, includeSystemFonts);
		return new ExposedFontName(propertyName, name, includeSystemFonts);
	}
	
	public var includeSystemFonts:Bool;
	
	public function new(propertyName:String, name:String=null, includeSystemFonts:Bool = true) 
	{
		super(propertyName, name);
		this.includeSystemFonts = includeSystemFonts;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, includeSystemFonts:Bool = true):ExposedFontName
	{
		setNames(propertyName, name);
		this.includeSystemFonts = includeSystemFonts;
		return this;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var font:ExposedFontName = fromPool(this.propertyName, this.name, this.includeSystemFonts);
		super.clone_internal(font, copyValue);
		return font;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		this.value = json.value;
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		json.value = this.value;
		return super.toJSON(json);
	}
	
}