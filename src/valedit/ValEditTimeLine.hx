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
	
	public var activateFunction:ValEditObject->Void;
	public var children(get, never):Array<ValEditTimeLine>;
	public var deactivateFunction:ValEditObject->Void;
	public var frameCurrent(get, never):ValEditKeyFrame;
	public var frameIndex(get, set):Int;
	public var frameRate(get, set):Float;
	public var frames(get, never):Array<ValEditKeyFrame>;
	public var loop(get, set):Bool;
	public var parent(get, set):ValEditTimeLine;
	
	private var _children:Array<ValEditTimeLine> = new Array<ValEditTimeLine>();
	private function get_children():Array<ValEditTimeLine> { return this._children; }
	
	private var _frameCurrent:ValEditKeyFrame;
	private function get_frameCurrent():ValEditKeyFrame { return this._frameCurrent; }
	
	private var _frameIndex:Int = -1;
	private function get_frameIndex():Int { return this._frameIndex; }
	private function set_frameIndex(value:Int):Int
	{
		if (this._frameIndex == value) return value;
		
		//var frame:ValEditKeyFrame = this._frames[value];
		//if (frame != this._frameCurrent)
		//{
			//if (this._frameCurrent != null)// && this._frameCurrent.isKeyFrame)
			//{
				//this._frameCurrent.exit();
			//}
			//this._frameCurrent = frame;
			//if (this._frameCurrent != null)// && this._frameCurrent.isKeyFrame)
			//{
				//this._frameCurrent.enter();
			//}
		//}
		setFrameCurrent(this._frames[value]);
		
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
	
	private var _frames:Array<ValEditKeyFrame> = new Array<ValEditKeyFrame>();
	private function get_frames():Array<ValEditKeyFrame> { return this._frames; }
	
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
	
	private var _parent:ValEditTimeLine;
	private function get_parent():ValEditTimeLine { return this._parent; }
	private function set_parent(value:ValEditTimeLine):ValEditTimeLine
	{
		return this._parent = value;
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
		this._frameCurrent = null;
		this.activateFunction = null;
		this.deactivateFunction = null;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	public function advanceTime(time:Float):Void
	{
		
	}
	
	public function add(object:ValEditObject):Void
	{
		this._frameCurrent.add(object);
	}
	
	public function remove(object:ValEditObject):Void
	{
		this._frameCurrent.remove(object);
	}
	
	public function registerKeyFrame(keyFrame:ValEditKeyFrame):Void
	{
		keyFrame.activateFunction = this.activateFunction;
		keyFrame.deactivateFunction = this.deactivateFunction;
	}
	
	private function setFrameCurrent(frame:ValEditKeyFrame):Void
	{
		if (frame != this._frameCurrent)
		{
			if (this._frameCurrent != null)
			{
				this._frameCurrent.exit();
			}
			this._frameCurrent = frame;
			if (this._frameCurrent != null)
			{
				this._frameCurrent.enter();
			}
		}
	}
	
	public function addChild(timeLine:ValEditTimeLine):ValEditTimeLine
	{
		this._children[this._children.length] = timeLine;
		timeLine.parent = this;
		return timeLine;
	}
	
	public function addChildAt(timeLine:ValEditTimeLine, index:Int):ValEditTimeLine
	{
		this._children.insert(index, timeLine);
		timeLine.parent = this;
		return timeLine;
	}
	
	public function removeChild(timeLine:ValEditTimeLine):ValEditTimeLine
	{
		this._children.remove(timeLine);
		timeLine.parent = null;
		return timeLine;
	}
	
	public function removeChildAt(index:Int):ValEditTimeLine
	{
		this._children[index].parent = null;
		return this._children.splice(index, 1)[0];
	}
	
	
	
}