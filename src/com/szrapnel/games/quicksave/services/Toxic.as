package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.items.Background;
	import com.szrapnel.games.quicksave.items.Obstacle;
	import com.szrapnel.games.quicksave.items.Wastes;
	import com.szrapnel.games.services.Assets;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Toxic extends FirePit
	{
		public function Toxic()
		{
			super();
		}
		
		public override function generate():void
		{
			super.generate();
			
			Background(getObject("Background")).image.texture = Assets.getTexture("CowFall_bckg4");
			
			var animation:Sprite = getObject("Animation");
			var animIndex:int = getChildIndex(animation);
			removeObject(animation);
			
			var wastes:Sprite = new Wastes();
			wastes.x = 0;
			wastes.y = getObject("Background").height - wastes.height;
			addChildAt(wastes, animIndex);
			Wastes(wastes).play();
			wastes.name = "Animation";
			addObject(wastes);
			
			var obstacleLeft:Sprite = new Obstacle();
			obstacleLeft.x = 170;
			obstacleLeft.y = 370;
			addChildAt(obstacleLeft, numChildren - 3);
			obstacleLeft.name = "ObstacleLeft";
			addObject(obstacleLeft);
			
			var obstacleRight:Sprite = new Obstacle();
			obstacleRight.x = 370;
			obstacleRight.y = 370;
			addChildAt(obstacleRight, numChildren - 3);
			obstacleRight.name = "ObstacleRight";
			addObject(obstacleRight);
		}
		
	}
}