package valedit.object.openfl.display;

import openfl.display.BitmapData;

/**
 * ...
 * @author Matse
 */
class GearShape extends BaseShape 
{
	public var angle(get, set):Float;
	public var hole(get, set):Bool;
	public var holeRadius(get, set):Float;
	public var innerRadius(get, set):Float;
	/* minimum 3 */
	public var numHoleSides(get, set):Int;
	/* minimum 3 */
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
	
	private var _hole:Bool = false;
	private function get_hole():Bool { return this._hole; }
	private function set_hole(value:Bool):Bool
	{
		if (this._hole == value) return value;
		this._hole = value;
		refreshGraphics();
		return this._hole;
	}
	
	private var _holeRadius:Float = 0.0;
	private function get_holeRadius():Float { return this._holeRadius; }
	private function set_holeRadius(value:Float):Float
	{
		if (this._holeRadius == value) return value;
		this._holeRadius = value;
		refreshGraphics();
		return this._holeRadius;
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
	
	private var _numHoleSides:Int = 10;
	private function get_numHoleSides():Int { return this._numHoleSides; }
	private function set_numHoleSides(value:Int):Int
	{
		if (this._numHoleSides == value) return value;
		this._numHoleSides = value;
		refreshGraphics();
		return this._numHoleSides;
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
	
	public function new(numSides:Int = 10, innerRadius:Float = 40.0, outerRadius:Float = 50.0, fill:Bool = true, fillColor:Int = 0xffffff, fillBitmapData:BitmapData = null,
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
		
		var step:Float = (Math.PI * 2) / this._numSides;
		var qtrStep:Float = step / 4.0;
		var startAngle:Float = (this._angle / 180.0) * Math.PI;
		
		var dx:Float;
		var dy:Float;
		
		var size:Float = Math.max(Math.abs(this._outerRadius), Math.abs(this._innerRadius));
		if (this._hole)
		{
			size = Math.max(size, Math.abs(this._holeRadius));
		}
		
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
			dx = srcX + Math.cos(startAngle + (step * i) - (qtrStep * 3)) * this._innerRadius;
			dy = srcY - Math.sin(startAngle + (step * i) - (qtrStep * 3)) * this._innerRadius;
			this.graphics.lineTo(dx, dy);
			
			dx = srcX + Math.cos(startAngle + (step * i) - (qtrStep * 2)) * this._innerRadius;
			dy = srcY - Math.sin(startAngle + (step * i) - (qtrStep * 2)) * this._innerRadius;
			this.graphics.lineTo(dx, dy);
			
			dx = srcX + Math.cos(startAngle + (step * i) - qtrStep) * this._outerRadius;
			dy = srcY - Math.sin(startAngle + (step * i) - qtrStep) * this._outerRadius;
			this.graphics.lineTo(dx, dy);
			
			dx = srcX + Math.cos(startAngle + (step * i)) * this._outerRadius;
			dy = srcY - Math.sin(startAngle + (step * i)) * this._outerRadius;
			this.graphics.lineTo(dx, dy);
		}
		
		if (this._hole)
		{
			step = (Math.PI * 2) / this._numHoleSides;
			this.graphics.moveTo(srcX + (Math.cos(startAngle) * this._holeRadius), srcY - (Math.sin(startAngle) * this._holeRadius));
			for (i in 1...this._numHoleSides + 1)
			{
				dx = srcX + Math.cos(startAngle + (step * i)) * this._holeRadius;
				dy = srcY - Math.sin(startAngle + (step * i)) * this._holeRadius;
				this.graphics.lineTo(dx, dy);
			}
		}
		
		if (this._fill)
		{
			this.graphics.endFill();
		}
	}
	
}