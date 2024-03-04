package valedit.object.openfl.display;

import openfl.display.BitmapData;

/**
 * ...
 * @author Matse
 */
class CircleShape extends BaseShape 
{
	public var radius(get, set):Float;
	
	private var _radius:Float;
	private function get_radius():Float { return this._radius; }
	private function set_radius(value:Float):Float
	{
		if (this._radius == value) return value;
		this._radius = value;
		refreshGraphics();
		return this._radius;
	}
	
	public function new(radius:Float = 50.0, fill:Bool = true, fillColor:Int = 0xffffff, fillBitmapData:BitmapData = null,
						outline:Bool = true, outlineThickness:Float = 1.0, outlineColor:Int = 0x000000, outlineBitmapData:BitmapData = null) 
	{
		super(fill, fillColor, fillBitmapData, outline, outlineThickness, outlineColor, outlineBitmapData);
		
		this._radius = radius;
		
		refreshGraphics();
	}
	
	override function refreshGraphics():Void
	{
		super.refreshGraphics();
		
		if (this._outline)
		{
			this.graphics.drawCircle(this._radius - this._pivotX + this._outlineThickness / 2, this._radius - this._pivotY + this._outlineThickness / 2, this._radius);
		}
		else
		{
			this.graphics.drawCircle(this._radius - this._pivotX, this._radius - this._pivotY, this._radius);
		}
		
		if (this._fill)
		{
			this.graphics.endFill();
		}
		
	}
	
}