package valedit.object.openfl.display;

import openfl.display.BitmapData;

/**
 * ...
 * @author Matse
 */
class ArrowShape extends BaseShape 
{
	public var arrowHeight(get, set):Float;
	public var arrowLength(get, set):Float;
	public var tail(get, set):Bool;
	public var tailHeight(get, set):Float;
	public var tailLength(get, set):Float;
	
	private var _arrowHeight:Float;
	private function get_arrowHeight():Float { return this._arrowHeight; }
	private function set_arrowHeight(value:Float):Float
	{
		if (this._arrowHeight == value) return value;
		this._arrowHeight = value;
		refreshGraphics();
		return this._arrowHeight;
	}
	
	private var _arrowLength:Float;
	private function get_arrowLength():Float { return this._arrowLength; }
	private function set_arrowLength(value:Float):Float
	{
		if (this._arrowLength == value) return value;
		this._arrowLength = value;
		refreshGraphics();
		return this._arrowLength;
	}
	
	private var _tail:Bool;
	private function get_tail():Bool { return this._tail; }
	private function set_tail(value:Bool):Bool
	{
		if (this._tail == value) return value;
		this._tail = value;
		refreshGraphics();
		return this._tail;
	}
	
	private var _tailHeight:Float;
	private function get_tailHeight():Float { return this._tailHeight; }
	private function set_tailHeight(value:Float):Float
	{
		if (this._tailHeight == value) return value;
		this._tailHeight = value;
		refreshGraphics();
		return this._tailHeight;
	}
	
	private var _tailLength:Float;
	private function get_tailLength():Float { return this._tailLength; }
	private function set_tailLength(value:Float):Float
	{
		if (this._tailLength == value) return value;
		this._tailLength = value;
		refreshGraphics();
		return this._tailLength;
	}

	public function new(arrowLength:Float = 50.0, arrowHeight:Float = 50.0, tail:Bool = true, tailLength:Float = 30.0, tailHeight:Float = 20.0, fill:Bool = true, fillColor:Int = 0xffffff, fillBitmapData:BitmapData = null,
						outline:Bool=true, outlineThickness:Float=1.0, outlineColor:Int=0x000000, outlineBitmapData:BitmapData=null) 
	{
		super(fill, fillColor, fillBitmapData, outline, outlineThickness, outlineColor, outlineBitmapData);
		
		this._arrowLength = arrowLength;
		this._arrowHeight = arrowHeight;
		this._tail = tail;
		this._tailLength = tailLength;
		this._tailHeight = tailHeight;
		
		refreshGraphics();
	}
	
	override function refreshGraphics():Void 
	{
		super.refreshGraphics();
		
		var baseX:Float = -this._pivotX;
		var baseY:Float = -this._pivotY;
		
		if (this._outline)
		{
			baseX += this._outlineThickness / 2;
			baseY += this._outlineThickness / 2;
		}
		
		if (this._tail)
		{
			var tx:Float = baseX;
			var ty:Float = baseY + (this._arrowHeight - this._tailHeight) / 2;
			this.graphics.moveTo(tx, ty);
			tx += this._tailLength;
			this.graphics.lineTo(tx, ty);
			ty = baseY;
			this.graphics.lineTo(tx, ty);
			tx += this._arrowLength;
			ty += this._arrowHeight / 2;
			this.graphics.lineTo(tx, ty);
			tx -= this._arrowLength;
			ty = baseY + this._arrowHeight;
			this.graphics.lineTo(tx, ty);
			ty -= (this._arrowHeight - this._tailHeight) / 2;
			this.graphics.lineTo(tx, ty);
			tx -= this._tailLength;
			this.graphics.lineTo(tx, ty);
			ty -= this._tailHeight;
			this.graphics.lineTo(tx, ty);
		}
		else
		{
			this.graphics.moveTo(baseX, baseY);
			this.graphics.lineTo(baseX + this._arrowLength, baseY + this._arrowHeight / 2);
			this.graphics.lineTo(baseX, baseY + this._arrowHeight);
			this.graphics.lineTo(baseX, baseY);
		}
		
		if (this._fill)
		{
			this.graphics.endFill();
		}
	}
	
}