package valedit.value.unused;

import valedit.value.base.ExposedValue;
import valedit.value.base.ExposedValueWithCollection;

/**
 * ...
 * @author Matse
 */
class ExposedFrameTween extends ExposedValueWithCollection 
{
	static private var _POOL:Array<ExposedFrameTween> = new Array<ExposedFrameTween>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String = null):ExposedFrameTween
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name);
		return new ExposedFrameTween(propertyName, name);
	}
	
	override function get_value():Dynamic 
	{
		if (this._object != null)
		{
			if (this._storedValue == null)
			{
				this._storedValue = Reflect.getProperty(this._object, this.propertyName);
			}
			return this._storedValue;
		}
		else
		{
			return super.get_value();
		}
	}

	public function new(propertyName:String, name:String = null) 
	{
		super(propertyName, name);
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String):ExposedFrameTween
	{
		setNames(propertyName, name);
		return this;
	}
	
	override public function applyToObject(object:Dynamic, applyIfDefaultValue:Bool = false):Void 
	{
		var realObject:Dynamic = Reflect.getProperty(object, this.propertyName);
		
		for (value in this._childValues)
		{
			value.applyToObject(realObject, applyIfDefaultValue);
		}
	}
	
	override public function readValue(dispatchEventIfChange:Bool = true):Void 
	{
		for (value in this._childValues)
		{
			value.readValu(dispatchEventIfChange);
		}
	}
	
	override public function clone(copyValue:Bool = false):ExposedValue 
	{
		var tween:ExposedFrameTween = fromPool(this.propertyName, this.name);
		super.clone_internal(tween, copyValue);
		return tween;
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		if (json.childValues != null)
		{
			var data:Array<Dynamic> = json.childValues;
			var value:ExposedValue;
			for (node in data)
			{
				value = ExposedValue.valueFromJSON(node);
				addChildValue(value);
			}
		}
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		if (this._childValues.length != 0)
		{
			var data:Array<Dynamic> = new Array<Dynamic>();
			var valueJson:Dynamic;
			for (value in this._childValues)
			{
				valueJson = value.toJSON();
				if (valueJson != null) data.push(valueJson);
			}
			json.childValues = data;
		}
		return super.toJSON(json);
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		var childJson:Dynamic = {};
		for (value in this._childValues)
		{
			value.toJSONSimple(childJson);
		}
		Reflect.setField(json, this.propertyName, childJson);
	}
	
}