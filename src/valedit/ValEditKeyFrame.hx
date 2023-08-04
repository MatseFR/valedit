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
	
	public var activateFunction:ValEditObject->Void;
	public var deactivateFunction:ValEditObject->Void;
	public var isActive(default, null):Bool;
	public var objects:Array<ValEditObject> = new Array<ValEditObject>();
	
	override function get_isEmpty():Bool { return this.objects.length == 0; }
	
	public function new() 
	{
		super();
		this.isKeyFrame = true;
	}
	
	override public function clear():Void
	{
		this.activateFunction = null;
		this.deactivateFunction = null;
		for (object in this.objects)
		{
			ValEdit.destroyObject(object);
		}
		this.objects.resize(0);
	}
	
	override public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	public function add(object:ValEditObject):Void
	{
		this.objects[this.objects.length] = object;
		if (this.isActive)
		{
			activateFunction(object);
		}
	}
	
	public function remove(object:ValEditObject):Void
	{
		this.objects.remove(object);
		if (this.isActive)
		{
			deactivateFunction(object);
		}
	}
	
	override public function enter():Void
	{
		for (object in this.objects)
		{
			activateFunction(object);
		}
		this.isActive = true;
	}
	
	override public function exit():Void
	{
		for (object in this.objects)
		{
			deactivateFunction(object);
		}
		this.isActive = false;
	}
	
}