package valedit.object.openfl.display;

import openfl.display.BitmapData;

/**
 * ...
 * @author Matse
 */
class BurstShape extends BaseShape 
{
	public var angle(get, set):Float;
	public var innerRadius(get, set):Float;
	public var numSides(get, set):Int;
	public var outerRadius(get, set):Float;
	
	private var _angle:Float = 0.0;
	private function get_angle():Float { return this._angle; }
	private function set_angle(value:Float):Float
	{
		if (this._angle == value) return value;
		this._angle = value;
		refreshGraphics();
		return this._angle;
	}
	
	private var _innerRadius:Float;
	private function get_innerRadius():Float { return this._innerRadius; }
	private function set_innerRadius(value:Float):Float
	{
		if (this._innerRadius == value) return value;
		this._innerRadius = value;
		refreshGraphics();
		return this._innerRadius;
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
	
	private var _outerRadius:Float;
	private function get_outerRadius():Float { return this._outerRadius; }
	private function set_outerRadius(value:Float):Float
	{
		if (this._outerRadius == value) return value;
		this._outerRadius = value;
		refreshGraphics();
		return this._outerRadius;
	}
	
	private var _cxList:Array<Float> = new Array<Float>();
	private var _cyList:Array<Float> = new Array<Float>();
	//private var _dxList:Array<Float> = new Array<Float>
	
	public function new(numSides:Int = 12, innerRadius:Float = 40.0, outerRadius:Float = 50.0, fill:Bool = true, fillColor:Int = 0xffffff, fillBitmapData:BitmapData = null,
						outline:Bool=true, outlineThickness:Float=1.0, outlineColor:Int=0x000000, outlineBitmapData:BitmapData=null) 
	{
		super(fill, fillColor, fillBitmapData, outline, outlineThickness, outlineColor, outlineBitmapData);
		
		this._numSides = numSides;
		this._innerRadius = innerRadius;
		this._outerRadius = outerRadius;
		
		refreshGraphics();
	}
	
	override function refreshGraphics():Void 
	{
		super.refreshGraphics();
		
		var step:Float = (Math.PI * 2.0) / this._numSides;
		var halfStep:Float = step / 2.0;
		var qtrStep:Float = step / 4.0;
		var startAngle:Float = (this._angle / 180.0) * Math.PI;
		
		var cx:Float;
		var cy:Float;
		var dx:Float;
		var dy:Float;
		
		var size:Float = Math.max(Math.abs(this._outerRadius), Math.abs(this._innerRadius));
		
		var srcX:Float = size - this._pivotX;
		var srcY:Float = size - this._pivotY;
		
		if (this._outline)
		{
			srcX += this._outlineThickness / 2.0;
			srcY += this._outlineThickness / 2.0;
		}
		
		this.graphics.moveTo(srcX + (Math.cos(startAngle) * this._outerRadius), srcY - (Math.sin(startAngle) * this._outerRadius));
		
		for (i in 1...this._numSides + 1)
		{
			cx = srcX + Math.cos(startAngle + (step * i) - (qtrStep * 3.0)) * (this._innerRadius / Math.cos(qtrStep));
			cy = srcY - Math.sin(startAngle + (step * i) - (qtrStep * 3.0)) * (this._innerRadius / Math.cos(qtrStep));
			dx = srcX + Math.cos(startAngle + (step * i) - halfStep) * this._innerRadius;
			dy = srcY - Math.sin(startAngle + (step * i) - halfStep) * this._innerRadius;
			this.graphics.curveTo(cx, cy, dx, dy);
			
			cx = srcX + Math.cos(startAngle + (step * i) - qtrStep) * (this._innerRadius / Math.cos(qtrStep));
			cy = srcY - Math.sin(startAngle + (step * i) - qtrStep) * (this._innerRadius / Math.cos(qtrStep));
			dx = srcX + Math.cos(startAngle + (step * i)) * this._outerRadius;
			dy = srcY - Math.sin(startAngle + (step * i)) * this._outerRadius;
			this.graphics.curveTo(cx, cy, dx, dy);
		}
		
		if (this._fill)
		{
			this.graphics.endFill();
		}
	}
	
}