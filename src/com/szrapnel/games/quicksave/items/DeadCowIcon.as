package com.szrapnel.games.quicksave.items
{
	import com.szrapnel.games.services.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class DeadCowIcon extends Sprite
	{
		private var container:Sprite;
		private var image:Image;
		
		public function DeadCowIcon()
		{
			super();
			
			container = new Sprite();
			addChild(container);
			
			image = new Image(Assets.getTexture("CowFall_failed"));
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			container.addChild(image);
		}
	
	}
}