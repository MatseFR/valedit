package valedit.object.openfl.display;

import openfl.display.BitmapData;

/**
 * ...
 * @author Matse
 */
class DonutShape extends BaseShape 
{
	public var radius:Float;
	public var holeRadius:Float;
	
	private var _radius:Float;
	private function get_radius():Float { return this._radius; }
	private function set_radius(value:Float):Float
	{
		if (this._radius == value) return value;
		this._radius = value;
		refreshGraphics();
		return this._radius;
	}
	
	private var _holeRadius:Float;
	private function get_holeRadius():Float { return this._holeRadius; }
	private function set_holeRadius(value:Float):Float
	{
		if (this._holeRadius == value) return value;
		this._holeRadius = value;
		refreshGraphics();
		return this._holeRadius;
	}
	
	public function new(radius:Float = 50.0, holeRadius:Float = 50.0, fill:Bool = true, fillColor:Int = 0xffffff, fillBitmapData:BitmapData = null,
						outline:Bool=true, outlineThickness:Float=1.0, outlineColor:Int=0x000000, outlineBitmapData:BitmapData=null) 
	{
		super(fill, fillColor, fillBitmapData, outline, outlineThickness, outlineColor, outlineBitmapData);
		
		this._radius = radius;
		this._holeRadius = holeRadius;
		
		refreshGraphics();
	}
	
	override function refreshGraphics():Void 
	{
		super.refreshGraphics();
		
		var size:Float = Math.max(this._radius, this._holeRadius);
		var centerX:Float;
		var centerY:Float;
		
		if (this._outline)
		{
			centerX = size - this._pivotX + this._outlineThickness / 2;
			centerY = size - this._pivotY + this._outlineThickness / 2;
			this.graphics.drawCircle(centerX, centerY, this._radius);
			this.graphics.drawCircle(centerX, centerY, this._holeRadius);
		}
		else
		{
			centerX = size - this._pivotX;
			centerY = size - this._pivotY;
			this.graphics.drawCircle(centerX, centerY, this._radius);
			this.graphics.drawCircle(centerX, centerY, this._holeRadius);
		}
		
		if (this._fill)
		{
			this.graphics.endFill();
		}
	}
	
}