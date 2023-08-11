package valedit;
import juggler.animation.IAnimatable;
import valedit.utils.ReverseIterator;

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
	public var frameTime(get, never):Float;
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
		
		this._frameIndex = value;
		
		setFrameCurrent(this._frames[value]);
		
		for (child in this._children)
		{
			child.frameIndex = this._frameIndex;
		}
		
		return this._frameIndex;
	}
	
	private var _frameRate:Float;
	private function get_frameRate():Float { return this._frameRate; }
	private function set_frameRate(value:Float):Float
	{
		if (this._frameRate == value) return value;
		this._frameTime = 1.0 / value;
		for (child in this._children)
		{
			child.frameRate = value;
		}
		return this._frameRate = value;
	}
	
	private var _frameTime:Float;
	private function get_frameTime():Float { return this._frameTime; }
	
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
	
	private var _numFrames:Int = 0;
	
	public function new() 
	{
		this.frameRate = 60;
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
	
	public function copyFrom(timeLine:ValEditTimeLine):Void
	{
		
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
		keyFrame.timeLine = this;
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
		if (this._frameCurrent != null) this._frameCurrent.indexCurrent = this._frameIndex;
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
	
	public function getNextKeyFrame(frame:ValEditKeyFrame):ValEditKeyFrame
	{
		for (i in frame.indexEnd + 1...this._numFrames)
		{
			if (this._frames[i] != null && this._frames[i] != frame) return cast this._frames[i];
		}
		return null;
	}
	
	public function getNextKeyFrameFromIndex(index:Int):ValEditKeyFrame
	{
		for (i in index...this._numFrames)
		{
			if (this._frames[i] != null) return cast this._frames[i];
		}
		return null;
	}
	
	public function getPreviousKeyFrame(frame:ValEditKeyFrame):ValEditKeyFrame
	{
		for (i in new ReverseIterator(frame.indexStart -1, 0))
		{
			if (this._frames[i] != null && this._frames[i] != frame) return cast this._frames[i];
		}
		return null;
	}
	
	public function getPreviousKeyFrameFromIndex(index:Int):ValEditKeyFrame
	{
		for (i in new ReverseIterator(index, 0))
		{
			if (this._frames[i] != null) return cast this._frames[i];
		}
		return null;
	}
	
}