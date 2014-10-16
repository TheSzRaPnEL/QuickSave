package com.szrapnel.games.quicksave.items
{
	import com.szrapnel.games.quicksave.services.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Platform extends Sprite
	{
		private var container:Sprite;
		
		public function Platform()
		{
			super();
			
			container = new Sprite();
			addChild(container);
			
			var image:Image = new Image(Assets.getTexture("CowFall_platform"));
			image.y = -50;
			container.addChild(image);
		}
		
	}
}