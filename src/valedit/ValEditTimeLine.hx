package valedit;
import juggler.animation.IAnimatable;
import juggler.animation.Juggler;
import openfl.events.EventDispatcher;
import valedit.events.PlayEvent;
import valedit.utils.ReverseIterator;

/**
 * ...
 * @author Matse
 */
class ValEditTimeLine extends EventDispatcher implements IAnimatable
{
	static private var _POOL:Array<ValEditTimeLine> = new Array<ValEditTimeLine>();
	
	static public function fromPool():ValEditTimeLine
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new ValEditTimeLine();
	}
	
	public var activateFunction(get, set):ValEditObject->Void;
	public var children(get, never):Array<ValEditTimeLine>;
	public var deactivateFunction(get, set):ValEditObject->Void;
	public var frameCurrent(get, never):ValEditKeyFrame;
	public var frameIndex(get, set):Int;
	public var frameRate(get, set):Float;
	public var frames(get, never):Array<ValEditKeyFrame>;
	public var frameTime(get, never):Float;
	public var isPlaying(get, never):Bool;
	public var isReverse(get, never):Bool;
	public var juggler(get, set):Juggler;
	public var keyFrames(get, never):Array<ValEditKeyFrame>;
	public var lastFrameIndex(get, never):Int;
	public var loop(get, set):Bool;
	public var numFrames(get, set):Int;
	/** 0 = infinite */
	public var numLoops(get, set):Int;
	public var parent(get, set):ValEditTimeLine;
	public var reverse(get, set):Bool;
	
	private var _activateFunction:ValEditObject->Void;
	private function get_activateFunction():ValEditObject->Void { return this._activateFunction; }
	private function set_activateFunction(value:ValEditObject->Void):ValEditObject->Void
	{
		for (keyFrame in this._keyFrames)
		{
			keyFrame.activateFunction = value;
		}
		return this._activateFunction = value;
	}
	
	private var _children:Array<ValEditTimeLine> = new Array<ValEditTimeLine>();
	private function get_children():Array<ValEditTimeLine> { return this._children; }
	
	private var _deactivateFunction:ValEditObject->Void;
	private function get_deactivateFunction():ValEditObject->Void { return this._deactivateFunction; }
	private function set_deactivateFunction(value:ValEditObject->Void):ValEditObject->Void
	{
		for (keyFrame in this._keyFrames)
		{
			keyFrame.deactivateFunction = value;
		}
		return this._deactivateFunction = value;
	}
	
	private var _frameCurrent:ValEditKeyFrame;
	private function get_frameCurrent():ValEditKeyFrame { return this._frameCurrent; }
	
	private var _frameIndex:Int = -1;
	private function get_frameIndex():Int { return this._frameIndex; }
	private function set_frameIndex(value:Int):Int
	{
		if (this._frameIndex == value) return value;
		if (value >= this._numFrames)
		{
			value = this._numFrames -1;
		}
		
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
	
	private var _isPlaying:Bool;
	private function get_isPlaying():Bool { return this._isPlaying; }
	
	private var _isReverse:Bool;
	private function get_isReverse():Bool { return this._isReverse; }
	
	private var _juggler:Juggler;
	private function get_juggler():Juggler { return this._juggler; }
	private function set_juggler(value:Juggler):Juggler
	{
		return this._juggler = value;
	}
	
	private var _keyFrames:Array<ValEditKeyFrame> = new Array<ValEditKeyFrame>();
	private function get_keyFrames():Array<ValEditKeyFrame> { return this._keyFrames; }
	
	private var _lastFrameIndex:Int;
	private function get_lastFrameIndex():Int { return this._lastFrameIndex; }
	
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
	
	private var _numFrames:Int = 0;
	private function get_numFrames():Int { return this._numFrames; }
	private function set_numFrames(value:Int):Int
	{
		if (this._numFrames == value) return value;
		
		if (value < this._numFrames)
		{
			for (i in value...this._numFrames)
			{
				if (this._frames[i] != null)
				{
					if (this._frames[i].indexStart == i)
					{
						unregisterKeyFrame(this._frames[i]);
						this._frames[i].pool();
					}
					else
					{
						this._frames[i].indexEnd--;
					}
				}
			}
			this._frames.resize(value);
		}
		else
		{
			for (i in this._numFrames...value)
			{
				this._frames[i] = null;
			}
		}
		
		// set numFrames on children too
		for (child in this._children)
		{
			child.numFrames = value;
		}
		
		return this._numFrames = value;
	}
	
	private var _numLoops:Int = 0;
	private function get_numLoops():Int { return this._numLoops; }
	private function set_numLoops(value:Int):Int
	{
		for (child in this._children)
		{
			child.numLoops = value;
		}
		return this._numLoops = value;
	}
	
	private var _parent:ValEditTimeLine;
	private function get_parent():ValEditTimeLine { return this._parent; }
	private function set_parent(value:ValEditTimeLine):ValEditTimeLine
	{
		return this._parent = value;
	}
	
	private var _reverse:Bool;
	private function get_reverse():Bool { return this._reverse; }
	private function set_reverse(value:Bool):Bool
	{
		for (child in this._children)
		{
			child.reverse = value;
		}
		return this._reverse = value;
	}
	
	private var _playTime:Float;
	private var _loopCount:Int;
	
	public function new() 
	{
		super();
		this.frameRate = 60;
	}
	
	public function clear():Void
	{
		if (this._isPlaying)
		{
			stop();
		}
		// WARNING : children are NOT pooled since the typical case is children time lines are owned by layers
		this._children.resize(0);
		for (frame in this._keyFrames)
		{
			frame.pool();
		}
		this._frameCurrent = null;
		this._frameIndex = -1;
		this._frames.resize(0);
		this._keyFrames.resize(0);
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
	
	public function play():Void
	{
		if (this._isPlaying) return;
		
		this._playTime = 0.0;
		this._loopCount = 0;
		this._isReverse = false;
		this._isPlaying = true;
		this._juggler.add(this);
		PlayEvent.dispatch(this, PlayEvent.PLAY);
	}
	
	public function stop():Void
	{
		if (!this._isPlaying) return;
		
		this._isPlaying = false;
		this._juggler.remove(this);
		PlayEvent.dispatch(this, PlayEvent.STOP);
	}
	
	public function advanceTime(time:Float):Void
	{
		if (!this._isPlaying) return;
		
		this._playTime += time;
		if (this._playTime >= this._frameTime)
		{
			playProgress();
			this._playTime -= this._frameTime;
		}
	}
	
	private function playProgress():Void
	{
		if (this._isReverse)
		{
			if (this._frameIndex != 0)
			{
				this.frameIndex--;
			}
			else
			{
				if (this._loop && (this._numLoops == 0 || (this._loopCount < this._numLoops)))
				{
					this._loopCount++;
					this._isReverse = false;
					if (this._lastFrameIndex != 0)
					{
						this.frameIndex++;
					}
				}
				else
				{
					stop();
				}
			}
		}
		else
		{
			if (this._frameIndex != this._lastFrameIndex)
			{
				this.frameIndex++;
			}
			else
			{
				if (this._loop && (this._numLoops == 0 || (this._loopCount < this._numLoops)))
				{
					this._loopCount++;
					if (this._reverse)
					{
						this._isReverse = true;
						if (this._frameIndex != 0)
						{
							this.frameIndex--;
						}
					}
					else
					{
						this.frameIndex = 0;
					}
				}
				else
				{
					stop();
				}
			}
		}
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
		this._keyFrames[this._keyFrames.length] = keyFrame;
	}
	
	public function unregisterKeyFrame(keyFrame:ValEditKeyFrame):Void
	{
		this._keyFrames.remove(keyFrame);
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
		addChildAt(timeLine, this._children.length);
		return timeLine;
	}
	
	public function addChildAt(timeLine:ValEditTimeLine, index:Int):ValEditTimeLine
	{
		this._children.insert(index, timeLine);
		timeLine.parent = this;
		timeLine.frameIndex = this._frameIndex;
		timeLine.frameRate = this._frameRate;
		timeLine.loop = this._loop;
		timeLine.numFrames = this.numFrames;
		timeLine.numLoops = this._numLoops;
		timeLine.reverse = this._reverse;
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
	
	public function updateLastFrameIndex():Void
	{
		this._lastFrameIndex = 0;
		if (this._frames.length != 0)
		{
			for (i in new ReverseIterator(this._frames.length - 1, 0))
			{
				if (this._frames[i] != null)
				{
					this._lastFrameIndex = i;
					break;
				}
			}
		}
		
		for (timeLine in this._children)
		{
			//timeLine.updateLastFrameIndex(true);
			if (timeLine._lastFrameIndex > this._lastFrameIndex)
			{
				this._lastFrameIndex = timeLine._lastFrameIndex;
			}
		}
		
		if (this._parent != null)
		{
			this._parent.updateLastFrameIndex();
		}
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