package valedit;
import juggler.animation.IAnimatable;

/**
 * ...
 * @author Matse
 */
class ValEditTimeLine implements IAnimatable
{
	static private var _POOL:Array<ValEditTimeLine> = new Array<ValEditTimeLine>();
	
	static public function fromPool():ValEditTimeLine
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new ValEditTimeLine();
	}
	
	public var addFunction:ValEditObject->Void;
	public var children(get, never):Array<ValEditTimeLine>;
	public var frameCurrent(get, never):ValEditFrame;
	public var frameIndex(get, set):Int;
	public var frameRate(get, set):Float;
	public var frames(get, never):Array<ValEditFrame>;
	public var loop(get, set):Bool;
	public var removeFunction:ValEditObject->Void;
	
	private var _children:Array<ValEditTimeLine> = new Array<ValEditTimeLine>();
	private function get_children():Array<ValEditTimeLine> { return this._children; }
	
	private var _frameCurrent:ValEditFrame;
	private function get_frameCurrent():ValEditFrame { return this._frameCurrent; }
	
	private var _frameIndex:Int = -1;
	private function get_frameIndex():Int { return this._frameIndex; }
	private function set_frameIndex(value:Int):Int
	{
		if (this._frameIndex == value) return value;
		
		var frame:ValEditFrame = this._frames[value];
		if (frame != this._frameCurrent)
		{
			if (this._frameCurrent != null)
			{
				if (this._frameCurrent.isKeyFrame) this._frameCurrent.exit();
				this._frameCurrent = frame;
				this._frameCurrent.enter();
			}
		}
		
		for (child in this._children)
		{
			child.frameIndex = value;
		}
		
		return this._frameIndex = value;
	}
	
	private var _frameRate:Float;
	private function get_frameRate():Float { return this._frameRate; }
	private function set_frameRate(value:Float):Float
	{
		for (child in this._children)
		{
			child.frameRate = value;
		}
		return this._frameRate = value;
	}
	
	private var _frames:Array<ValEditFrame> = new Array<ValEditFrame>();
	private function get_frames():Array<ValEditFrame> { return this._frames; }
	
	private var _loop:Bool;
	private function get_loop():Bool { return this._loop; }
	private function set_loop(value:Bool):Bool
	{
		for (child in this._children)
		{
			child.loop = value;
		}
		return this._loop = value;
	}
	
	public function new() 
	{
		
	}
	
	public function clear():Void
	{
		for (child in this._children)
		{
			child.pool();
		}
		this._children.resize(0);
		for (frame in this._frames)
		{
			frame.pool();
		}
		this._frames.resize(0);
		this.addFunction = null;
		this.removeFunction = null;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	public function advanceTime(time:Float):Void
	{
		
	}
	
	public function addFrame():Void
	{
		
	}
	
	public function insertFrame(index:Int):Void
	{
		
	}
	
	public function removeFrameAt(index:Int, pool:Bool):Void
	{
		
	}
	
	public function addChild(timeLine:ValEditTimeLine):ValEditTimeLine
	{
		this._children[this._children.length] = timeLine;
		return timeLine;
	}
	
	public function addChildAt(timeLine:ValEditTimeLine, index:Int):ValEditTimeLine
	{
		this._children.insert(index, timeLine);
		return timeLine;
	}
	
	public function removeChild(timeLine:ValEditTimeLine):ValEditTimeLine
	{
		this._children.remove(timeLine);
		return timeLine;
	}
	
	public function removeChildAt(index:Int):ValEditTimeLine
	{
		return this._children.splice(index, 1)[0];
	}
	
	
	
}