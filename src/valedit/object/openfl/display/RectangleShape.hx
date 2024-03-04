package valedit.object.openfl.display;
import openfl.display.BitmapData;

/**
 * ...
 * @author Matse
 */
class RectangleShape extends BaseShape 
{
	public var rectangleHeight(get, set):Float;
	public var rectangleWidth(get, set):Float;
	
	private var _rectangleHeight:Float;
	private function get_rectangleHeight():Float { return this._rectangleHeight; }
	private function set_rectangleHeight(value:Float):Float
	{
		if (this._rectangleHeight == value) return value;
		this._rectangleHeight = value;
		refreshGraphics();
		return this._rectangleHeight;
	}
	
	private var _rectangleWidth:Float;
	private function get_rectangleWidth():Float { return this._rectangleWidth; }
	private function set_rectangleWidth(value:Float):Float
	{
		if (this._rectangleWidth == value) return value;
		this._rectangleWidth = value;
		refreshGraphics();
		return this._rectangleWidth;
	}

	public function new(rectWidth:Float = 50.0, rectHeight:Float = 50.0, fill:Bool = true, fillColor:Int = 0xffffff, fillBitmapData:BitmapData = null,
						outline:Bool = true, outlineThickness:Float = 1.0, outlineColor:Int = 0x000000, outlineBitmapData:BitmapData = null) 
	{
		super(fill, fillColor, fillBitmapData, outline, outlineThickness, outlineColor, outlineBitmapData);
		
		this._rectangleWidth = rectWidth;
		this._rectangleHeight = rectHeight;
		
		refreshGraphics();
	}
	
	override function refreshGraphics():Void 
	{
		super.refreshGraphics();
		
		if (this._outline)
		{
			this.graphics.drawRect( -this._pivotX + this._outlineThickness / 2, -this._pivotY + this._outlineThickness / 2, this._rectangleWidth, this._rectangleHeight);
		}
		else
		{
			this.graphics.drawRect( -this._pivotX, -this._pivotY, this._rectangleWidth, this._rectangleHeight);
		}
		
		if (this._fill)
		{
			this.graphics.endFill();
		}
	}
	
}