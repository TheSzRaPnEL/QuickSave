package com.szrapnel.games.quicksave.items
{
	import com.szrapnel.games.services.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Dock extends Sprite
	{
		private var container:Sprite;
		
		public function Dock()
		{
			super();
			
			container = new Sprite();
			container.scaleX = -1;
			addChild(container);
			
			var image:Image = new Image(Assets.getTexture("CowFall_doc"));
			container.addChild(image);
		}
		
	}
}