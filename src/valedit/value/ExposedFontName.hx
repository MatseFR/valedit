package valedit.value;

import valedit.value.base.ExposedValue;
import valedit.value.data.FontSelection;

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
	
	static public function fromPool(propertyName:String, name:String = null, fontSelection:String = FontSelection.ALL):ExposedFontName
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, fontSelection);
		return new ExposedFontName(propertyName, name, fontSelection);
	}
	
	public var fontSelection:String;
	
	public function new(propertyName:String, name:String=null, fontSelection:String = FontSelection.ALL) 
	{
		super(propertyName, name);
		
		this.fontSelection = fontSelection;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, fontSelection:String = FontSelection.ALL):ExposedFontName
	{
		setNames(propertyName, name);
		this.fontSelection = fontSelection;
		return this;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var font:ExposedFontName = fromPool(this.propertyName, this.name, this.fontSelection);
		super.clone_internal(font, copyValue);
		return font;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		this.fontSelection = json.fontSelection;
		this.value = json.value;
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		json.fontSelection = this.fontSelection;
		json.value = this.value;
		return super.toJSON(json);
	}
	
}