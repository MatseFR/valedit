package valedit.value;

import valedit.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedNote extends ExposedValue 
{
	public var text:String;
	public var textPercentWidth:Float;
	
	/**
	   
	   @param	name
	   @param	text
	   @param	textPercentWidth
	**/
	public function new(name:String="", text:String="", textPercentWidth:Float = 100) 
	{
		super(name);
		
		this.text = text;
		this.textPercentWidth = textPercentWidth;
	}
	
	override public function clone():ExposedValue 
	{
		var text:ExposedNote = new ExposedNote(this.name, this.text, this.textPercentWidth);
		return text;
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		return super.toJSON(json);
	}
	
}