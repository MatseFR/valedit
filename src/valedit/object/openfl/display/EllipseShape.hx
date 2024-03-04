package valedit.object.openfl.display;

import openfl.display.BitmapData;

/**
 * ...
 * @author Matse
 */
class EllipseShape extends BaseShape 
{
	public var radiusX(get, set):Float;
	public var radiusY(get, set):Float;
	
	private var _radiusX:Float;
	private function get_radiusX():Float { return this._radiusX; }
	private function set_radiusX(value:Float):Float
	{
		if (this._radiusX == value) return value;
		this._radiusX = value;
		refreshGraphics();
		return this._radiusX;
	}
	
	private var _radiusY:Float;
	private function get_radiusY():Float { return this._radiusY; }
	private function set_radiusY(value:Float):Float
	{
		if (this._radiusY == value) return value;
		this._radiusY =  value;
		refreshGraphics();
		return this._radiusY;
	}
	
	public function new(radiusX:Float = 50.0, radiusY:Float = 50.0, fill:Bool = true, fillColor:Int = 0xffffff, fillBitmapData:BitmapData = null,
						outline:Bool=true, outlineThickness:Float=1.0, outlineColor:Int=0x000000, outlineBitmapData:BitmapData=null) 
	{
		super(fill, fillColor, fillBitmapData, outline, outlineThickness, outlineColor, outlineBitmapData);
		
		this._radiusX = radiusX;
		this._radiusY = radiusY;
		
		refreshGraphics();
	}
	
	override function refreshGraphics():Void 
	{
		super.refreshGraphics();
		
		if (this._outline)
		{
			this.graphics.drawEllipse( -this._pivotX + this._outlineThickness / 2.0, -this._pivotY + this._outlineThickness / 2.0, this._radiusX * 2.0, this._radiusY * 2.0);
		}
		else
		{
			this.graphics.drawEllipse( -this._pivotX, -this._pivotY, this._radiusX * 2.0, this._radiusY * 2.0);
		}
		
		if (this._fill)
		{
			this.graphics.endFill();
		}
	}
	
}