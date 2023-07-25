package valedit;

/**
 * ...
 * @author Matse
 */
class ValEditKeyFrame extends ValEditFrame
{
	static private var _POOL:Array<ValEditKeyFrame> = new Array<ValEditKeyFrame>();
	
	static public function fromPool():ValEditKeyFrame
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new ValEditKeyFrame();
	}
	
	public var addFunction:ValEditObject->Void;
	public var instances:Array<ValEditInstance> = new Array<ValEditInstance>();
	public var removeFunction:ValEditObject->Void;
	
	override function get_isEmpty():Bool { return this.instances.length == 0; }
	
	public function new() 
	{
		super();
		this.isKeyFrame = true;
	}
	
	override public function clear():Void
	{
		this.addFunction = null;
		this.removeFunction = null;
		for (instance in this.instances)
		{
			instance.pool();
		}
	}
	
	override public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	override public function enter():Void
	{
		for (instance in instances)
		{
			instance.activate();
			addFunction(instance.object);
		}
	}
	
	override public function exit():Void
	{
		for (instance in instances)
		{
			instance.deactivate();
			removeFunction(instance.object);
		}
	}
	
}