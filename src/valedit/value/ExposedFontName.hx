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
	
	static public function fromPool(propertyName:String, name:String = null#if valeditor, fontSelection:String = FontSelection.ALL#end):ExposedFontName
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name#if valeditor, fontSelection#end);
		return new ExposedFontName(propertyName, name#if valeditor, fontSelection#end);
	}
	
	#if valeditor
	public var fontSelection:String;
	/* if true, moving up or down using keyboard will select the item. Default is false. */
	public var selectOnKeyboardNavigation:Bool = false;
	#end
	
	public function new(propertyName:String, name:String=null#if valeditor, fontSelection:String = FontSelection.ALL#end) 
	{
		super(propertyName, name);
		#if valeditor
		this.fontSelection = fontSelection;
		#end
	}
	
	override public function clear():Void 
	{
		super.clear();
		#if valeditor
		this.selectOnKeyboardNavigation = false;
		#end
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String#if valeditor, fontSelection:String = FontSelection.ALL#end):ExposedFontName
	{
		setNames(propertyName, name);
		#if valeditor
		this.fontSelection = fontSelection;
		#end
		return this;
	}
	
	public function clone(copyValue:Bool = false):ExposedValue 
	{
		var font:ExposedFontName = fromPool(this.propertyName, this.name#if valeditor, this.fontSelection#end);
		#if valeditor
		font.selectOnKeyboardNavigation = this.selectOnKeyboardNavigation;
		#end
		super.clone_internal(font, copyValue);
		return font;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		//this.fontSelection = json.fontSelection;
		this.value = json.value;
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		//json.fontSelection = this.fontSelection;
		json.value = this.value;
		return super.toJSON(json);
	}
	
}