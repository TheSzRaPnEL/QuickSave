package com.szrapnel.games.quicksave.items
{
	import com.szrapnel.games.services.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Cow extends Sprite
	{
		private var container:Sprite;
		
		public function Cow()
		{
			super();
			
			container = new Sprite();
			addChild(container);
			
			var image:Image = new Image(Assets.getTexture("CowFall_Cow"));
			image.x = -image.width / 2;
			image.y = -image.height / 2;
			container.addChild(image);
		}
		
	}
}