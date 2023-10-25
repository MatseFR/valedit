package valedit.asset;
import haxe.zip.Entry;

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

	public function new() 
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