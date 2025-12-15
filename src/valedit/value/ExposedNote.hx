package valedit.value;

import valedit.value.base.ExposedNotValue;
import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
class ExposedNote extends ExposedNotValue 
{
	static private var _POOL:Array<ExposedNote> = new Array<ExposedNote>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(name:String="", text:String="", textPercentWidth:Float = 100):ExposedNote
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(name, text, textPercentWidth);
		return new ExposedNote(name, text, textPercentWidth);
	}
	
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
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(name:String, text:String, textPercentWidth:Float)
	{
		setNames(name, null);
		this.text = text;
		this.textPercentWidth = textPercentWidth;
		return this;
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var note:ExposedNote = fromPool(this.name, this.text, this.textPercentWidth);
		return note;
	}
	
}