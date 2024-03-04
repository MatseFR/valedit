package valedit.object.openfl.display;

import openfl.display.BitmapData;

/**
 * ...
 * @author Matse
 */
class PolygonShape extends BaseShape 
{
	public var angle(get, set):Float;
	public var numSides(get, set):Int;
	public var radius(get, set):Float;
	
	private var _angle:Float = 0.0;
	private function get_angle():Float { return this._angle; }
	private function set_angle(value:Float):Float
	{
		if (this._angle == value) return value;
		this._angle = value;
		refreshGraphics();
		return this._angle;
	}
	
	private var _numSides:Int;
	private function get_numSides():Int { return this._numSides; }
	private function set_numSides(value:Int):Int
	{
		if (this._numSides == value) return value;
		this._numSides = value;
		refreshGraphics();
		return this._numSides;
	}
	
	private var _radius:Float;
	private function get_radius():Float { return this._radius; }
	private function set_radius(value:Float):Float
	{
		if (this._radius == value) return value;
		this._radius = value;
		refreshGraphics();
		return this._radius;
	}
	
	private var _dxList:Array<Float> = new Array<Float>();
	private var _dyList:Array<Float> = new Array<Float>();
	
	public function new(numSides:Int = 5, radius:Float = 50.0, fill:Bool = true, fillColor:Int = 0xffffff, fillBitmapData:BitmapData = null,
						outline:Bool=true, outlineThickness:Float=1.0, outlineColor:Int=0x000000, outlineBitmapData:BitmapData=null) 
	{
		super(fill, fillColor, fillBitmapData, outline, outlineThickness, outlineColor, outlineBitmapData);
		
		this._numSides = numSides;
		this._radius = radius;
		
		refreshGraphics();
	}
	
	override function refreshGraphics():Void 
	{
		super.refreshGraphics();
		
		var step:Float = (Math.PI * 2.0) / this._numSides;
		var startAngle:Float = (this._angle / 180.0) * Math.PI;
		
		var srcX:Float;
		var srcY:Float;
		
		var dx:Float;
		var dy:Float;
		var xmin:Float = 999999.0;
		var ymin:Float = 999999.0;
		
		for (i in 1...this._numSides + 1)
		{
			dx = Math.cos(startAngle + (step * i)) * this._radius;
			this._dxList[this._dxList.length] = dx;
			if (dx < xmin) xmin = dx;
			dy = -Math.sin(startAngle + (step * i)) * this._radius;
			this._dyList[this._dyList.length] = dy;
			if (dy < ymin) ymin = dy;
		}
		
		srcX = -xmin - this._pivotX;
		srcY = -ymin - this._pivotY;
		if (this._outline)
		{
			srcX += this._outlineThickness / 2.0;
			srcY += this._outlineThickness / 2.0;
		}
		
		this.graphics.moveTo(srcX + (Math.cos(startAngle) * this._radius), srcY - (Math.sin(startAngle) * this._radius));
		for (i in 0...this._numSides)
		{
			this.graphics.lineTo(srcX + this._dxList[i], srcY + this._dyList[i]);
		}
		
		this._dxList.resize(0);
		this._dyList.resize(0);
		
		if (this._fill)
		{
			this.graphics.endFill();
		}
	}
	
}