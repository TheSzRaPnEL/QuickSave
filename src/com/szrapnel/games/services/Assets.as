package com.szrapnel.games.services
{
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Assets
	{
		private static var _assetManager:AssetManager;
		
		public function Assets()
		{
		
		}
		
		public static function get assetManager():AssetManager
		{
			return _assetManager;
		}
		
		public static function set assetManager(value:AssetManager):void
		{
			_assetManager = value;
		}
		
		public static function getTexture(textureName:String):Texture
		{
			return _assetManager.getTexture(textureName);
		}
		
		public static function getTextures(prefix:String = ""):Vector.<Texture>
		{
			return _assetManager.getTextures(prefix);
		}
		
	}
}