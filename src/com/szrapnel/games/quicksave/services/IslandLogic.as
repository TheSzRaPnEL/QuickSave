package com.szrapnel.games.quicksave.services
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.quicksave.enum.PlatformHideDirection;
	import com.szrapnel.games.quicksave.enum.PlatformType;
	import com.szrapnel.games.quicksave.events.SimulationEvent;
	import com.szrapnel.games.quicksave.items.Cow;
	import com.szrapnel.games.services.Assets;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Polygon;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class IslandLogic extends FirePitLogic
	{
		public function IslandLogic(gameStage:IGameStage, symulation:ISimulation)
		{
			super(gameStage, symulation);
			
			scoreToWin = 4;
		}
		
		private function onCowPlatformCollision_handler(e:SimulationEvent):void
		{
			var platform:Body = symulation.getBody("Platform");
			var platformObject:* = gameStage.getObject("Platform");
			var platformInner:Body = symulation.getBody("PlatformInner");
			platformObject.image.texture = Assets.getTexture("CowFall_platform_buttonON");
			if (platform.userData.type == PlatformType.BUTTON && platform.userData.hideDirection == PlatformHideDirection.LEFT)
			{
				symulation.eventDispatcher.removeEventListener(SimulationEvent.COW_PLATFORM_COLLISION, onCowPlatformCollision_handler);
				TweenLite.to(platformInner.position, 0.3, {x: -160});
				TweenLite.to(platform.position, 0.3, {x: -160, onComplete: buttonPlatformHidden});
			}
		}
		
		private function buttonPlatformHidden():void
		{
			var platformObject:* = gameStage.getObject("Platform");
			var hand:* = gameStage.getObject("Hand");
			var platform:Body = symulation.getBody("Platform");
			var platformInner:Body = symulation.getBody("PlatformInner");
			if (platform.userData.type == PlatformType.BUTTON)
			{
				platform.shapes.add(new Polygon(Polygon.rect(10, -40, 15, 40)));
				platform.shapes.add(new Polygon(Polygon.rect(145, -40, 15, 40)));
				platform.shapes.at(1).fluidEnabled = false;
				platform.shapes.at(1).sensorEnabled = false;
				platform.shapes.at(2).fluidEnabled = false;
				platform.shapes.at(2).sensorEnabled = false;
			}
			hand.x = 620;
			hand.y = 588;
			platform.position.x = 460;
			platform.position.y = 600;
			platformInner.position.x = 460;
			platformInner.position.y = 600;
			platformObject.image.x = 0;
			platformObject.image.y = -50;
			platformObject.image.texture = Assets.getTexture("CowFall_platform");
			platformObject.image.width = 180;
			platformObject.image.height = 73;
			platform.velocity = Vec2.weak(-900);
			platformInner.velocity = Vec2.weak(-900);
			platform.userData.type = PlatformType.GRAB;
			platform.userData.hideDirection = PlatformHideDirection.RIGHT;
		}
		
		protected override function dropNewCow():void
		{
			super.dropNewCow();
			
			symulation.eventDispatcher.removeEventListener(SimulationEvent.COW_PLATFORM_COLLISION, onCowPlatformCollision_handler);
			symulation.eventDispatcher.addEventListener(SimulationEvent.COW_PLATFORM_COLLISION, onCowPlatformCollision_handler);
			
			if (score == 1 || score == 3)
			{
				Cow(gameStage.getObject("Cow")).image.texture = Assets.getTexture("CowFall_Bull");
				isBull = true;
			}
			else
			{
				Cow(gameStage.getObject("Cow")).image.texture = Assets.getTexture("CowFall_Cow");
				isBull = false;
			}
			
			var platformObject:* = gameStage.getObject("Platform");
			var hand:* = gameStage.getObject("Hand");
			var platform:Body = symulation.getBody("Platform");
			var platformInner:Body = symulation.getBody("PlatformInner");
			platform.velocity = Vec2.weak();
			platformInner.velocity = Vec2.weak();
			
			if (score == 0 || (platform.userData.type == PlatformType.GRAB && platform.userData.hideDirection == PlatformHideDirection.RIGHT))
			{
				hand.x = -60;
				hand.y = 488;
				platform.position.x = 300;
				platform.position.y = 480;
				if (platform.shapes.length > 1)
				{
					platform.shapes.remove(platform.shapes.at(0));
					platform.shapes.remove(platform.shapes.at(0));
				}
				platformInner.position.x = 300;
				platformInner.position.y = 480;
				platformObject.image.texture = Assets.getTexture("CowFall_platform_button");
				platformObject.image.x = 156;
				platformObject.image.y = -15;
				platformObject.image.width = -145;
				platformObject.image.height = 40;
				platform.userData.hideDirection = PlatformHideDirection.LEFT;
				platform.userData.type = PlatformType.BUTTON;
			}
		}
		
	}
}