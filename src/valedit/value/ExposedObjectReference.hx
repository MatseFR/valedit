package valedit.value;

import openfl.errors.Error;
import valedit.value.base.ExposedValue;
#if valeditor
import valeditor.ValEditorObject;
#else
import valedit.ValEditObject;
#end
import valedit.value.reference.ReferenceRange;

/**
 * ...
 * @author Matse
 */
class ExposedObjectReference extends ExposedValue 
{
	static private var _POOL:Array<ExposedObjectReference> = new Array<ExposedObjectReference>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool(propertyName:String, name:String=null, classList:Array<String> = null, allowSelfReference:Bool = false):ExposedObjectReference
	{
		if (_POOL.length != 0) return _POOL.pop().setTo(propertyName, name, classList, allowSelfReference);
		return new ExposedObjectReference(propertyName, name, classList, allowSelfReference);
	}
	
	/** see ReferenceRange for possible values */
	public var allowedReferenceRanges:Array<String> = new Array<String>();
	/** if false, current object won't be available for selection. Default is false */
	public var allowSelfReference:Bool;
	public var classList(default, null):Array<String>;
	
	private var _referenceRange:String;// = ReferenceRange.CONTAINER;
	
	#if valeditor
	private var _valEditObjectReference:ValEditorObject;
	#else
	private var _valEditObjectReference:ValEditObject;
	#end
	
	// LOADING
	private var _objectID:String;
	//private var _objectClassName:String;
	//\LOADING
	
	override function set_value(value:Dynamic):Dynamic 
	{
		#if valeditor
		if (Std.isOfType(value, ValEditorObject))
		{
			this._valEditObjectReference = cast value;
			trace("ExposedObjectReference " + this.propertyName + " value set to ValEditorObject " + this._valEditObjectReference.objectID);
			return super.set_value(this._valEditObjectReference.object);
		}
		#else
		if (Std.isOfType(value, ValEditObject))
		{
			this._valEditObjectReference = cast value;
			return super.set_value(this._valEditObjectReference.object);
		}
		#end
		trace("ExposedObjectReference " + this.propertyName + " value set to NOT ValEditorObject");
		this._valEditObjectReference = null;
		return super.set_value(value);
	}

	public function new(propertyName:String, name:String=null, classList:Array<String> = null, allowSelfReference:Bool = false) 
	{
		super(propertyName, name);
		if (classList == null) classList = new Array<String>();
		this.classList = classList;
		this.allowSelfReference = allowSelfReference;
		this.isNullable = true;
	}
	
	override public function clear():Void 
	{
		trace("ExposedObjectReference " + this.propertyName + " clear");
		
		super.clear();
		
		this.allowedReferenceRanges.resize(0);
		this.allowSelfReference = false;
		this.classList = null;
		this._valEditObjectReference = null;
		this.isNullable = true;
		this._objectID = null;
		//this._objectClassName = null;
		this._referenceRange = null;
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
	}
	
	private function setTo(propertyName:String, name:String, classList:Array<String>, allowSelfReference:Bool):ExposedObjectReference
	{
		setNames(propertyName, name);
		if (classList == null) classList = new Array<String>();
		this.classList = classList;
		this.allowSelfReference = allowSelfReference;
		return this;
	}
	
	public function allowClass(clss:Class<Dynamic>):Void
	{
		var className:String = Type.getClassName(clss);
		allowClassName(className);
	}
	
	public function allowClassName(className:String):Void
	{
		this.classList.push(className);
	}
	
	/** see ReferenceRange for possible values */
	public function allowRange(range:String):Void
	{
		this.allowedReferenceRanges[this.allowedReferenceRanges.length] = range;
	}
	
	public function clone(copyValue:Bool = false):ExposedValue 
	{
		var reference:ExposedObjectReference = fromPool(this.propertyName, this.name, this.classList.copy(), this.allowSelfReference);
		reference.allowedReferenceRanges = this.allowedReferenceRanges.copy();
		reference._referenceRange = this._referenceRange;
		super.clone_internal(reference, copyValue);
		return reference;
	}
	
	override public function cloneValue(toValue:ExposedValue):Void 
	{
		if (this._valEditObjectReference != null)
		{
			toValue.value = this._valEditObjectReference;
		}
		else if (this._storedValue != null)
		{
			toValue.value = this._storedValue;
		}
		else
		{
			toValue.value = this.value;
		}
		if (toValue.uiControl != null)
		{
			toValue.uiControl.updateExposedValue();
		}
	}
	
	override public function loadComplete():Void 
	{
		if (this._objectID != null)
		{
			//this.value = ValEdit.getObjectWithClassName(this._objectID, this._objectClassName);
			switch (this._referenceRange)
			{
				case ReferenceRange.CONTAINER :
					this.value = this._valEditorObject.container.getObject(this._objectID);
				
				case ReferenceRange.CONTAINER_LIBRARY :
					this.value = this._valEditorObject.container.getObjectFromLibrary(this._objectID);
			}
		}
	}
	
	override public function fromJSON(json:Dynamic):Void 
	{
		super.fromJSON(json);
		if (json.value != null)
		{
			this.value = ValEdit.getObjectWithClassName(json.value, json.clss);
		}
	}
	
	override public function toJSON(json:Dynamic = null):Dynamic 
	{
		if (json == null) json = {};
		if (this.value != null)
		{
			if (this._valEditObjectReference != null)
			{
				json.value = this._valEditObjectReference.objectID;
				//json.clss = this._valEditObjectReference.className;
			}
			else
			{
				//var className:String = ValEdit.getObjectClassName(this.value);
				//json.value = ValEdit.getObjectNameWithClassName(this.value, className);
				//json.clss = className;
				
				throw new Error("missing ValEditObject");
			}
		}
		return super.toJSON(json);
	}
	
	override public function fromJSONSave(json:Dynamic):Void 
	{
		this._objectID = json.value;
		this._referenceRange = json.range;
		#if valeditor
		if (json.lastChanged != null)
		{
			this.lastChanged = json.lastChanged;
		}
		if (json.lastModified != null)
		{
			this.lastModified = json.lastModified;
		}
		#end
	}
	
	override public function toJSONSave(json:Dynamic, includeNotVisible:Bool = false, refValue:ExposedValue = null):Void 
	{
		if (this.value != null)
		{
			var data:Dynamic = {value:this._valEditObjectReference.objectID, range:this._referenceRange};
			#if valeditor
			data.lastChanged = this.lastChanged;
			data.lastModified = this.lastModified;
			#end
			Reflect.setField(json, this.propertyName, data);
		}
	}
	
	override public function toJSONSimple(json:Dynamic):Void 
	{
		if (this.value != null)
		{
			if (this._valEditObjectReference != null)
			{
				Reflect.setField(json, this.propertyName, this._valEditObjectReference.id);
			}
			else
			{
				//Reflect.setField(json, this.propertyName, ValEdit.getObjectID(this.value));
				
				throw new Error("missing ValEditObject");
			}
		}
	}
	
}