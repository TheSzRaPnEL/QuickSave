package com.szrapnel.games.quicksave.items
{
	import com.szrapnel.games.services.Assets;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Saw extends Sprite
	{
		private var container:Sprite;
		private var animation:MovieClip;
		
		public function Saw()
		{
			super();
			
			container = new Sprite();
			addChild(container);
			
			animation = new MovieClip(Assets.getTextures("CowFall_bckg6_anim_0"), 25);
			container.addChild(animation);
		}
		
		public function play():void
		{
			animation.play();
			Starling.juggler.add(animation);
		}
		
	}
}