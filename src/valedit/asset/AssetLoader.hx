package valedit.asset;
import haxe.Constraints.Function;
import openfl.utils.Future;
import utils.ArgumentsCount;

/**
 * ...
 * @author Matse
 */
class AssetLoader<T> 
{
	private var _idList:Array<String>;
	private var _loadFunction:Function;
	private var _completeCallback:Void->Void;
	private var _loadCompleteCallback:String->Void;
	private var _loadErrorCallback:String->Void;
	
	private var _loadCount:Int;
	private var _loadIndex:Int;
	
	/**
	 * 
	 * @param	idList
	 * @param	loadFunction
	 * @param	completeCallback
	 * @param	loadCompleteCallback
	 * @param	loadErrorCallback
	 */
	public function new(idList:Array<String>, loadFunction:Function, completeCallback:Void->Void, ?loadCompleteCallback:String->Void, ?loadErrorCallback:String->Void) 
	{
		this._idList = idList;
		this._loadFunction = loadFunction;
		this._completeCallback = completeCallback;
		this._loadCompleteCallback = loadCompleteCallback;
		this._loadErrorCallback = loadErrorCallback;
	}
	
	public function start():Void
	{
		this._loadCount = this._idList.length;
		this._loadIndex = -1;
		loadNext();
	}
	
	private function loadNext():Void
	{
		this._loadIndex ++;
		if (this._loadIndex < this._loadCount)
		{
			var future:Future<T>;
			if (ArgumentsCount.count_args(this._loadFunction) == 2)
			{
				#if neko
				future = Reflect.callMethod(this._loadFunction, this._loadFunction, [this._idList[this._loadIndex], true]);
				#else
				future = this._loadFunction(this._idList[this._loadIndex], true);
				#end
			}
			else
			{
				#if neko
				future = Reflect.callMethod(this._loadFunction, this._loadFunction, [this._idList[this._loadIndex]]);
				#else
				future = this._loadFunction(this._idList[this._loadIndex]);
				#end
			}
			future.onComplete(loadComplete).onError(loadError);
		}
		else
		{
			this._completeCallback();
		}
	}
	
	private function loadComplete(asset:T):Void
	{
		if (this._loadCompleteCallback != null)
		{
			this._loadCompleteCallback(this._idList[this._loadIndex]);
		}
		
		loadNext();
	}
	
	private function loadError(error:Dynamic):Void
	{
		if (this._loadErrorCallback != null)
		{
			this._loadErrorCallback(this._idList[this._loadIndex]);
		}
		
		loadNext();
	}
	
}