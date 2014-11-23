package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.items.Background;
	import com.szrapnel.games.quicksave.items.Crocodiles;
	import com.szrapnel.games.quicksave.items.Obstacle;
	import com.szrapnel.games.services.Assets;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Swamp extends FirePit
	{
		
		public function Swamp()
		{
			super();
		}
		
		public override function generate():void
		{
			super.generate();
			
			Background(getObject("Background")).image.texture = Assets.getTexture("CowFall_bckg2");
			
			var animation:Sprite = getObject("Animation");
			var animIndex:int = getChildIndex(animation);
			removeObject(animation);
			
			var crocodiles:Sprite = new Crocodiles();
			crocodiles.x = 0;
			crocodiles.y = getObject("Background").height - crocodiles.height;
			addChildAt(crocodiles, animIndex);
			Crocodiles(crocodiles).play();
			crocodiles.name = "Animation";
			addObject(crocodiles);
			
			var obstacle:Sprite = new Obstacle();
			obstacle.x = 270;
			obstacle.y = 250;
			addChildAt(obstacle, numChildren - 3);
			obstacle.name = "Obstacle";
			addObject(obstacle);
		}
		
	}
}