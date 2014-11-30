package com.szrapnel.games.quicksave.items
{
	import com.szrapnel.games.services.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Platform extends Sprite
	{
		private var container:Sprite;
		private var _image:Image;
		
		public function Platform()
		{
			super();
			
			container = new Sprite();
			addChild(container);
			
			_image = new Image(Assets.getTexture("CowFall_platform"));
			image.y = -50;
			image.width = 180;
			container.addChild(image);
		}
		
		public function get image():Image 
		{
			return _image;
		}
		
	}
}