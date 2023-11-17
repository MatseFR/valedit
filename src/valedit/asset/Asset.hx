package valedit.asset;
import haxe.zip.Entry;
import valedit.value.base.ExposedValue;
import valeditor.ValEditorObject;
import valeditor.ValEditorTemplate;

/**
 * ...
 * @author Matse
 */
abstract class Asset 
{
	public var name:String;
	public var path:String;
	public var source:String;
	public var isLoaded:Bool;
	public var useCount(get, never):Int;
	
	private function get_useCount():Int { return this._registeredValues.length; }
	
	private var _registeredAssets:Array<Asset> = new Array<Asset>();
	private var _registeredConstructorValues:Array<ExposedValue> = new Array<ExposedValue>();
	private var _registeredValues:Array<ExposedValue> = new Array<ExposedValue>();
	
	public function new() 
	{
		
	}
	
	public function clear():Void
	{
		for (asset in this._registeredAssets)
		{
			asset.assetRemoved(this);
		}
		this._registeredAssets.resize(0);
		
		for (value in this._registeredConstructorValues)
		{
			value.value = null;
		}
		this._registeredConstructorValues.resize(0);
		
		for (value in this._registeredValues)
		{
			value.value = null;
		}
		this._registeredValues.resize(0);
		
		this.name = null;
		this.path = null;
		this.source = null;
		this.isLoaded = false;
	}
	
	abstract function pool():Void;
	
	public function registerAsset(asset:Asset):Void
	{
		// DEBUG
		if (this._registeredAssets.indexOf(asset) != -1)
		{
			trace("asset already registered");
		}
		//\DEBUG
		
		this._registeredAssets[this._registeredAssets.length] = asset;
	}
	
	public function registerConstructorValue(value:ExposedValue):Void
	{
		// DEBUG
		if (this._registeredConstructorValues.indexOf(value) != -1)
		{
			trace("constructor value already registered");
		}
		//\DEBUG
		
		this._registeredConstructorValues[this._registeredConstructorValues.length] = value;
	}
	
	public function registerValue(value:ExposedValue):Void
	{
		// DEBUG
		if (this._registeredValues.indexOf(value) != -1)
		{
			trace("value already registered");
		}
		//\DEBUG
		
		this._registeredValues[this._registeredValues.length] = value;
	}
	
	public function unregisterAsset(asset:Asset):Void
	{
		// DEBUG
		if (this._registeredAssets.indexOf(asset) == -1)
		{
			trace("asset not registered or already unregistered");
		}
		//\DEBUG
		
		this._registeredAssets.remove(asset);
	}
	
	public function unregisterConstructorValue(value:ExposedValue):Void
	{
		// DEBUG
		if (this._registeredConstructorValues.indexOf(value) == -1)
		{
			trace("constructor value not registered or already unregistered");
		}
		//\DEBUG
		
		this._registeredConstructorValues.remove(value);
	}
	
	public function unregisterValue(value:ExposedValue):Void
	{
		// DEBUG
		if (this._registeredValues.indexOf(value) == -1)
		{
			trace("value not registered or already unregistered");
		}
		//\DEBUG
		
		this._registeredValues.remove(value);
	}
	
	public function update():Void
	{
		var valObject:ValEditorObject;
		var wasUpdateLocked:Bool;
		var template:ValEditorTemplate;
		var wasTemplateUpdateLocked:Bool = false;
		for (value in this._registeredValues)
		{
			wasUpdateLocked = value.updateCollectionLocked;
			if (!wasUpdateLocked) value.updateCollectionLocked = true;
			valObject = value.valEditorObject;
			if (valObject != null)
			{
				if (valObject.template != null)
				{
					template = cast valObject.template;
					wasTemplateUpdateLocked = template.lockInstanceUpdates;
					if (!wasTemplateUpdateLocked) template.lockInstanceUpdates = true;
				}
				else
				{
					template = null;
				}
				if (valObject.currentKeyFrame != null && valObject.currentKeyFrame.tween)
				{
					valObject.currentKeyFrame.resetTweens();
				}
			}
			else
			{
				template = null;
			}
			value.value = this;
			if (template != null)
			{
				template.lockInstanceUpdates = wasTemplateUpdateLocked;
			}
			if (valObject != null && valObject.currentKeyFrame != null && valObject.currentKeyFrame.tween)
			{
				valObject.currentKeyFrame.updateTweens();
			}
			value.updateCollectionLocked = wasUpdateLocked;
		}
		
		for (value in this._registeredConstructorValues)
		{
			value.value = this;
		}
		
		for (asset in this._registeredAssets)
		{
			asset.assetUpdate(this);
		}
	}
	
	public function assetRemoved(asset:Asset):Void
	{
		
	}
	
	public function assetUpdate(asset:Asset):Void
	{
		
	}
	
	public function toJSONSave(json:Dynamic = null):Dynamic
	{
		if (json == null) json = {};
		
		json.name = this.name;
		json.path = this.path;
		
		return json;
	}
	
	abstract public function toZIPEntry():Entry;
	
}