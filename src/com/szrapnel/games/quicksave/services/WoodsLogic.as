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
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class WoodsLogic extends FirePitLogic
	{
		public function WoodsLogic(gameStage:IGameStage, symulation:ISimulation)
		{
			super(gameStage, symulation);
			
			scoreToWin = 4;
		}
		
		protected override function onEFrame(e:EnterFrameEvent):void
		{
			var obstacleTop:Sprite = gameStage.getObject("ObstacleTop");
			var obstacleTopBodyPos:Vec2 = symulation.getBody("ObstacleTop").position;
			obstacleTop.x = obstacleTopBodyPos.x;
			obstacleTop.y = obstacleTopBodyPos.y;
			
			var obstacleBot:Sprite = gameStage.getObject("ObstacleBot");
			var obstacleBotBodyPos:Vec2 = symulation.getBody("ObstacleBot").position;
			obstacleBot.x = obstacleBotBodyPos.x;
			obstacleBot.y = obstacleBotBodyPos.y;
			
			super.onEFrame(e);
		}
		
		private function onCowPlatformCollision_handler(e:SimulationEvent):void
		{
			var platform:Body = symulation.getBody("Platform");
			var platformObject:* = gameStage.getObject("Platform");
			var platformInner:Body = symulation.getBody("PlatformInner");
			platformObject.image.texture = Assets.getTexture("CowFall_platform_buttonON");
			if (platform.userData.type == PlatformType.BUTTON && platform.userData.hideDirection == PlatformHideDirection.RIGHT)
			{
				symulation.eventDispatcher.removeEventListener(SimulationEvent.COW_PLATFORM_COLLISION, onCowPlatformCollision_handler);
				TweenLite.to(platformInner.position, 0.3, {x: 560});
				TweenLite.to(platform.position, 0.3, {x: 560, onComplete: buttonPlatformHidden});
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
			hand.x = -80;
			hand.y = 688;
			platform.position.x = -80;
			platform.position.y = 700;
			platformInner.position.x = -80;
			platformInner.position.y = 700;
			platformObject.image.x = 170;
			platformObject.image.y = -50;
			platformObject.image.texture = Assets.getTexture("CowFall_platform");
			platformObject.image.width = -180;
			platformObject.image.height = 73;
			platform.velocity = Vec2.weak(900);
			platformInner.velocity = Vec2.weak(900);
			platform.userData.type = PlatformType.GRAB;
			platform.userData.hideDirection = PlatformHideDirection.LEFT;
		}
		
		protected override function dropNewCow():void
		{
			super.dropNewCow();
			
			symulation.eventDispatcher.removeEventListener(SimulationEvent.COW_PLATFORM_COLLISION, onCowPlatformCollision_handler);
			symulation.eventDispatcher.addEventListener(SimulationEvent.COW_PLATFORM_COLLISION, onCowPlatformCollision_handler);
			
			Cow(gameStage.getObject("Cow")).image.texture = Assets.getTexture("CowFall_Bull");
			isBull = true;
			
			var platformObject:* = gameStage.getObject("Platform");
			var hand:* = gameStage.getObject("Hand");
			var platform:Body = symulation.getBody("Platform");
			var platformInner:Body = symulation.getBody("PlatformInner");
			platform.velocity = Vec2.weak();
			platformInner.velocity = Vec2.weak();
			
			if (score == 0 || (platform.userData.type == PlatformType.GRAB && platform.userData.hideDirection == PlatformHideDirection.LEFT))
			{
				hand.x = 614;
				hand.y = 488;
				platform.position.x = 100;
				platform.position.y = 480;
				if (platform.shapes.length > 1)
				{
					platform.shapes.remove(platform.shapes.at(0));
					platform.shapes.remove(platform.shapes.at(0));
				}
				platformInner.position.x = 100;
				platformInner.position.y = 480;
				platformObject.image.texture = Assets.getTexture("CowFall_platform_button");
				platformObject.image.x = 16;
				platformObject.image.y = -15;
				platformObject.image.width = 145;
				platformObject.image.height = 40;
				platform.userData.hideDirection = PlatformHideDirection.RIGHT;
				platform.userData.type = PlatformType.BUTTON;
			}
		}
		
	}
}