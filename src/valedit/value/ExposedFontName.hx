package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedFontName extends ExposedValue 
{
	public var includeSystemFonts:Bool;
	
	public function new(propertyName:String, name:String=null, includeSystemFonts:Bool = true) 
	{
		super(propertyName, name);
		this.includeSystemFonts = includeSystemFonts;
		this.defaultValue = null;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var font:ExposedFontName = new ExposedFontName(this.propertyName, this.name, this.includeSystemFonts);
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