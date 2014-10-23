package com.szrapnel.games.quicksave.items
{
	import com.szrapnel.games.services.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Background extends Sprite
	{
		private var container:Sprite;
		private var _image:Image;
		
		public function Background()
		{
			super();
			
			container = new Sprite();
			addChild(container);
			
			_image = new Image(Assets.getTexture("CowFall_bckg1"));
			container.addChild(image);
		}
		
		public function get image():Image 
		{
			return _image;
		}
		
	}
}