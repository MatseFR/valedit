package valedit.object.openfl.display;

import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.geom.Matrix;

/**
 * ...
 * @author Matse
 */
class BaseShape extends Shape 
{
	public var fill(get, set):Bool;
	public var fillAlpha(get, set):Float;
	public var fillBitmapData(get, set):BitmapData;
	public var fillColor(get, set):Int;
	public var fillMatrix(get, set):Matrix;
	/* Used if fillBitmapData != null, default is true */
	public var fillRepeat(get, set):Bool;
	/* Used if fillBitmapData != null, default is true */
	public var fillSmoothing(get, set):Bool;
	public var outline(get, set):Bool;
	public var outlineAlpha(get, set):Float;
	public var outlineBitmapData(get, set):BitmapData;
	public var outlineColor(get, set):Int;
	public var outlineMatrix(get, set):Matrix;
	/* Used if outlineBitmapData != null, default is true */
	public var outlineRepeat(get, set):Bool;
	/* Used if outlineBitmapData != null, default is true */
	public var outlineSmoothing(get, set):Bool;
	public var outlineThickness(get, set):Float;
	public var pivotX(get, set):Float;
	public var pivotY(get, set):Float;
	
	private var _fill:Bool;
	private function get_fill():Bool { return this._fill; }
	private function set_fill(value:Bool):Bool
	{
		if (this._fill == value) return value;
		this._fill = value;
		refreshGraphics();
		return this._fill;
	}
	
	private var _fillAlpha:Float = 1.0;
	private function get_fillAlpha():Float { return this._fillAlpha; }
	private function set_fillAlpha(value:Float):Float
	{
		if (this._fillAlpha == value) return value;
		this._fillAlpha = value;
		refreshGraphics();
		return this._fillAlpha;
	}
	
	private var _fillBitmapData:BitmapData;
	private function get_fillBitmapData():BitmapData { return this._fillBitmapData; }
	private function set_fillBitmapData(value:BitmapData):BitmapData
	{
		if (this._fillBitmapData == value) return value;
		this._fillBitmapData = value;
		refreshGraphics();
		return this._fillBitmapData;
	}
	
	private var _fillColor:Int;
	private function get_fillColor():Int { return this._fillColor; }
	private function set_fillColor(value:Int):Int
	{
		if (this._fillColor == value) return value;
		this._fillColor = value;
		refreshGraphics();
		return this._fillColor;
	}
	
	private var _fillMatrix:Matrix = new Matrix();
	private function get_fillMatrix():Matrix { return this._fillMatrix; }
	private function set_fillMatrix(value:Matrix):Matrix
	{
		this._fillMatrix = value;
		refreshGraphics();
		return this._fillMatrix;
	}
	
	private var _fillRepeat:Bool = true;
	private function get_fillRepeat():Bool { return this._fillRepeat; }
	private function set_fillRepeat(value:Bool):Bool
	{
		if (this._fillRepeat == value) return value;
		this._fillRepeat = value;
		refreshGraphics();
		return this._fillRepeat;
	}
	
	private var _fillSmoothing:Bool = true;
	private function get_fillSmoothing():Bool { return this._fillSmoothing; }
	private function set_fillSmoothing(value:Bool):Bool
	{
		if (this._fillSmoothing == value) return value;
		this._fillSmoothing = value;
		if (this._fillBitmapData != null) refreshGraphics();
		return this._fillSmoothing;
	}
	
	private var _outline:Bool;
	private function get_outline():Bool { return this._outline; }
	private function set_outline(value:Bool):Bool
	{
		if (this._outline == value) return value;
		this._outline = value;
		refreshGraphics();
		return this._outline;
	}
	
	private var _outlineAlpha:Float = 1.0;
	private function get_outlineAlpha():Float { return this._outlineAlpha; }
	private function set_outlineAlpha(value:Float):Float
	{
		if (this._outlineAlpha == value) return value;
		this._outlineAlpha = value;
		refreshGraphics();
		return this._outlineAlpha;
	}
	
	private var _outlineBitmapData:BitmapData;
	private function get_outlineBitmapData():BitmapData { return this._outlineBitmapData; }
	private function set_outlineBitmapData(value:BitmapData):BitmapData
	{
		if (this._outlineBitmapData == value) return value;
		this._outlineBitmapData = value;
		refreshGraphics();
		return this._outlineBitmapData;
	}
	
	private var _outlineColor:Int;
	private function get_outlineColor():Int { return this._outlineColor; }
	private function set_outlineColor(value:Int):Int
	{
		if (this._outlineColor == value) return value;
		this._outlineColor = value;
		refreshGraphics();
		return this._outlineColor;
	}
	
	private var _outlineMatrix:Matrix = new Matrix();
	private function get_outlineMatrix():Matrix { return this._outlineMatrix; }
	private function set_outlineMatrix(value:Matrix):Matrix
	{
		this._outlineMatrix = value;
		refreshGraphics();
		return this._outlineMatrix;
	}
	
	private var _outlineRepeat:Bool = true;
	private function get_outlineRepeat():Bool { return this._outlineRepeat; }
	private function set_outlineRepeat(value:Bool):Bool
	{
		if (this._outlineRepeat == value) return value;
		this._outlineRepeat = value;
		refreshGraphics();
		return this._outlineRepeat;
	}
	
	private var _outlineSmoothing:Bool = true;
	private function get_outlineSmoothing():Bool { return this._outlineSmoothing; }
	private function set_outlineSmoothing(value:Bool):Bool
	{
		if (this._outlineSmoothing == value) return value;
		this._outlineSmoothing = value;
		refreshGraphics();
		return this._outlineSmoothing;
	}
	
	private var _outlineThickness:Float;
	private function get_outlineThickness():Float { return this._outlineThickness; }
	private function set_outlineThickness(value:Float):Float
	{
		if (this._outlineThickness == value) return value;
		this._outlineThickness = value;
		refreshGraphics();
		return this._outlineThickness;
	}
	
	private var _pivotX:Float = 0;
	private function get_pivotX():Float { return this._pivotX; }
	private function set_pivotX(value:Float):Float
	{
		if (this._pivotX == value) return value;
		this._pivotX = value;
		refreshGraphics();
		return this._pivotX;
	}
	
	private var _pivotY:Float = 0;
	private function get_pivotY():Float { return this._pivotY; }
	private function set_pivotY(value:Float):Float
	{
		if (this._pivotY == value) return value;
		this._pivotY = value;
		refreshGraphics();
		return this._pivotY;
	}
	
	public function new(fill:Bool = true, fillColor:Int = 0xffffff, fillBitmapData:BitmapData = null,
						outline:Bool = true, outlineThickness:Float = 1.0, outlineColor:Int = 0x000000, outlineBitmapData:BitmapData = null) 
	{
		super();
		
		this._fill = fill;
		this._fillColor = fillColor;
		this._fillBitmapData = fillBitmapData;
		this._outline = outline;
		this._outlineThickness = outlineThickness;
		this._outlineColor = outlineColor;
		this._outlineBitmapData = outlineBitmapData;
	}
	
	private function refreshGraphics():Void
	{
		this.graphics.clear();
		
		if (this._fill)
		{
			if (this._fillBitmapData != null)
			{
				this.graphics.beginBitmapFill(this._fillBitmapData, this._fillMatrix, this._fillRepeat, this._fillSmoothing);
			}
			else
			{
				this.graphics.beginFill(this._fillColor, this._fillAlpha);
			}
		}
		
		if (this._outline)
		{
			this.graphics.lineStyle(this._outlineThickness, this._outlineColor, this._outlineAlpha);
			
			if (this._outlineBitmapData != null)
			{
				this.graphics.lineBitmapStyle(this._outlineBitmapData, this._outlineMatrix, this._outlineRepeat, this._outlineSmoothing);
			}
		}
	}
	
}