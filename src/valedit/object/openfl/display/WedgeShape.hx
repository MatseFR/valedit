package valedit.object.openfl.display;

import openfl.display.BitmapData;

/**
 * ...
 * @author Matse
 */
class WedgeShape extends BaseShape 
{
	public var arc(get, set):Float;
	public var radiusX(get, set):Float;
	public var radiusY(get, set):Float;
	public var startAngle(get, set):Float;
	
	private var _arc:Float;
	private function get_arc():Float { return this._arc; }
	private function set_arc(value:Float):Float
	{
		if (this._arc == value) return value;
		this._arc = value;
		refreshGraphics();
		return this._arc;
	}
	
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
		this._radiusY = value;
		refreshGraphics();
		return this._radiusY;
	}
	
	private var _startAngle:Float;
	private function get_startAngle():Float { return this._startAngle; }
	private function set_startAngle(value:Float):Float
	{
		if (this._startAngle == value) return value;
		this._startAngle = value;
		refreshGraphics();
		return this._startAngle;
	}
	
	public function new(arc:Float = 90.0, radiusX:Float = 50.0, radiusY:Float = 50.0, startAngle:Float = 0.0, fill:Bool = true, fillColor:Int = 0xffffff, fillBitmapData:BitmapData = null,
						outline:Bool=true, outlineThickness:Float=1.0, outlineColor:Int=0x000000, outlineBitmapData:BitmapData=null) 
	{
		super(fill, fillColor, fillBitmapData, outline, outlineThickness, outlineColor, outlineBitmapData);
		
		this._arc = arc;
		this._radiusX = radiusX;
		this._radiusY = radiusY;
		this._startAngle = startAngle;
		
		refreshGraphics();
	}
	
	override function refreshGraphics():Void 
	{
		super.refreshGraphics();
		
		var segs:Int = Math.ceil(Math.abs(this._arc) / 45);
		var segAngle:Float = this._arc / segs;
		var theta:Float = -(segAngle / 180) * Math.PI;
		var angle:Float = -(this._startAngle / 180) * Math.PI;
		//var ax:Float = this._pivotX - Math.cos(angle) * this._radiusX;
		//var ay:Float = this._pivotY - Math.sin(angle) * this._radiusY;
		
		var angleMid:Float;
		var bx:Float;
		var by:Float;
		var cx:Float;
		var cy:Float;
		
		this.graphics.moveTo(this._pivotX, this._pivotY);
		
		if (segs > 0)
		{
			var ax:Float = this._pivotX + Math.cos(angle) * this._radiusX;
			var ay:Float = this._pivotY + Math.sin(angle) * this._radiusY;
			this.graphics.lineTo(ax, ay);
			
			for (i in 0...segs)
			{
				angle += theta;
				angleMid = angle - (theta / 2);
				bx = this._pivotX + Math.cos(angle) * this._radiusX;
				by = this._pivotY + Math.sin(angle) * this._radiusY;
				cx = this._pivotX + Math.cos(angleMid) * (this._radiusX / Math.cos(theta / 2));
				cy = this._pivotY + Math.sin(angleMid) * (this._radiusY / Math.cos(theta / 2));
				
				this.graphics.curveTo(cx, cy, bx, by);
			}
		}
		
		if (this._fill)
		{
			this.graphics.endFill();
		}
	}
	
}