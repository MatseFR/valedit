package valedit.object.openfl.display;

import openfl.display.BitmapData;

/**
 * ...
 * @author Matse
 */
class StarShape extends BaseShape 
{
	public var angle(get, set):Float;
	public var innerRadius(get, set):Float;
	/* minimum 3 */
	public var numPoints(get, set):Int;
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
	
	private var _numPoints:Int;
	private function get_numPoints():Int { return this._numPoints; }
	private function set_numPoints(value:Int):Int
	{
		if (this._numPoints == value) return value;
		this._numPoints = value;
		refreshGraphics();
		return this._numPoints;
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
	
	private var _dxList:Array<Float> = new Array<Float>();
	private var _dyList:Array<Float> = new Array<Float>();
	
	public function new(numPoints:Int = 5, innerRadius:Float = 25.0, outerRadius:Float = 50.0, fill:Bool = true, fillColor:Int = 0xffffff, fillBitmapData:BitmapData = null,
						outline:Bool=true, outlineThickness:Float=1.0, outlineColor:Int=0x000000, outlineBitmapData:BitmapData=null) 
	{
		super(fill, fillColor, fillBitmapData, outline, outlineThickness, outlineColor, outlineBitmapData);
		
		this._numPoints = numPoints;
		this._innerRadius = innerRadius;
		this._outerRadius = outerRadius;
		
		refreshGraphics();
	}
	
	override function refreshGraphics():Void 
	{
		super.refreshGraphics();
		
		var step:Float = (Math.PI * 2.0) / this._numPoints;
		var halfStep:Float = step / 2.0;
		var startAngle:Float = (this._angle / 180.0) * Math.PI;
		
		var dx:Float;
		var dy:Float;
		var xmin:Float = 999999.0;
		var ymin:Float = 999999.0;
		
		var size:Float = Math.max(Math.abs(this._outerRadius), Math.abs(this._innerRadius));
		
		var srcX:Float = size - this._pivotX;
		var srcY:Float = size - this._pivotY;
		
		for (i in 0...this._numPoints + 1)
		{
			dx = Math.cos(startAngle + (step * i) - halfStep) * this._innerRadius;
			this._dxList[this._dxList.length] = dx;
			
			dy = -Math.sin(startAngle + (step * i) - halfStep) * this._innerRadius;
			this._dyList[this._dyList.length] = dy;
			
			dx = Math.cos(startAngle + (step * i)) * this._outerRadius;
			this._dxList[this._dxList.length] = dx;
			if (dx < xmin) xmin = dx;
			
			dy = -Math.sin(startAngle + (step * i)) * this._outerRadius;
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
		
		this.graphics.moveTo(srcX + (Math.cos(startAngle) * this._outerRadius), srcY - (Math.sin(startAngle) * this._outerRadius));
		var count:Int = this._dxList.length;
		for (i in 0...count)
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