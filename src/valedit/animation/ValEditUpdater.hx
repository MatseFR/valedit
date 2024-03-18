package valedit.animation;

import haxe.Timer;
import juggler.animation.IAnimatable;

/**
 * ...
 * @author Matse
 */
class ValEditUpdater implements IAnimatable 
{

	public function new() 
	{
		
	}
	
	public function advanceTime(time:Float):Void 
	{
		ValEdit.TIME_STAMP_CURRENT = Timer.stamp();
	}
	
}