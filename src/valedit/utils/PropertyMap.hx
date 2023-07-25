package valedit.utils;

/**
 * ...
 * @author Matse
 */
class PropertyMap 
{
	private var _objectToRegular:Map<String, String> = new Map<String, String>();
	private var _regularToObject:Map<String, String> = new Map<String, String>();
	
	public function new() 
	{
		
	}
	
	public function add(regularPropertyName:String, objectPropertyName:String):Void
	{
		this._objectToRegular.set(objectPropertyName, regularPropertyName);
		this._regularToObject.set(regularPropertyName, objectPropertyName);
	}
	
	public function getObjectPropertyName(regularPropertyName:String):String
	{
		return this._regularToObject.get(regularPropertyName);
	}
	
	public function getRegularPropertyName(objectPropertyName:String):String
	{
		return this._objectToRegular.get(objectPropertyName);
	}
	
	public function hasPropertyRegular(propertyName:String):Bool
	{
		return this._regularToObject.exists(propertyName);
	}
	
	public function hasPropertyObject(propertyName:String):Bool
	{
		return this._objectToRegular.exists(propertyName);
	}
	
}