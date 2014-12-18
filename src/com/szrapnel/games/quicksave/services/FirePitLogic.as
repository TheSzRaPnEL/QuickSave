package com.szrapnel.games.quicksave.services
{
	import com.greensock.easing.Bounce;
	import com.greensock.TweenLite;
	import com.szrapnel.games.events.DisplayListEvent;
	import com.szrapnel.games.quicksave.enum.PlatformHideDirection;
	import com.szrapnel.games.quicksave.events.LevelEvent;
	import com.szrapnel.games.quicksave.events.SimulationEvent;
	import com.szrapnel.games.quicksave.items.Banner;
	import com.szrapnel.games.quicksave.items.CowDeath;
	import com.szrapnel.games.quicksave.items.TelescopicSpring;
	import com.szrapnel.games.services.Assets;
	import com.szrapnel.games.services.SoundController;
	import flash.system.Capabilities;
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class FirePitLogic extends Sprite implements IGameLogic
	{
		protected var gameStage:IGameStage;
		protected var symulation:ISimulation;
		protected var score:int;
		protected var scoreToWin:int;
		protected var isBull:Boolean;
		protected var bullCounter:int;
		
		private var now:int;
		private var playBtn:Sprite;
		private var clickTime:int;
		private var lastMaxVelocity:Number;
		private var timerId:uint;
		private var deadCowIcon:Sprite;
		private var startTime:int;
		
		public function FirePitLogic(gameStage:IGameStage, symulation:ISimulation)
		{
			this.gameStage = gameStage;
			this.symulation = symulation;
			
			clickTime = 0;
			lastMaxVelocity = -500;
			
			playBtn = gameStage.getObject("PlayBtn");
			
			isBull = false;
			scoreToWin = 10;
			
			symulation.eventDispatcher.removeEventListener(SimulationEvent.COW_GRABBED, onCowGrabbed_handler);
			symulation.eventDispatcher.addEventListener(SimulationEvent.COW_GRABBED, onCowGrabbed_handler);
		}
		
		protected function onCowGrabbed_handler(e:SimulationEvent):void
		{
			if (isBull)
			{
				bullCounter++;
				if (bullCounter < 3)
				{
					symulation.getBody("RightWall").position.x = 0;
					symulation.getBody("LeftWall").position.x = 0;
					symulation.grabbed = false;
					var ball:Body = symulation.getBody("Ball");
					ball.position.y = symulation.getBody("Platform").position.y - 45;
					ball.velocity = Vec2.weak(0, -500 * Math.random() - 150);
					ball.angularVel = -20 * Math.random() + 10;
					ball.type = BodyType.DYNAMIC;
					
					if (!(symulation.space.listeners.has(symulation.interactionListener)))
					{
						symulation.space.listeners.add(symulation.interactionListener);
					}
				}
				else
				{
					bullCounter = 0;
					isBull = false;
				}
			}
		}
		
		private function onPlayBtnTouch(e:TouchEvent):void
		{
			if (e.getTouch(stage))
			{
				var touch:Touch = e.getTouch(stage);
				if (touch.phase == TouchPhase.BEGAN)
				{
					SoundController.playSound(Assets.assetManager.getSound("click"));
					
					playBtn.removeEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
					playBtn.alpha = 0;
					playBtn.touchable = false;
					
					dropNewCow();
				}
			}
		}
		
		public function init():void
		{
			resetGame();
			
			startTime = getTimer();
			score = 0;
			Banner(gameStage.getObject("Banner")).savedTxtf.text = "" + score + "/" + scoreToWin;
			
			symulation.reset();
			
			playBtn.removeEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
			playBtn.addEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
			playBtn.alpha = 1;
			playBtn.touchable = true;
		}
		
		protected function onTouch(e:TouchEvent):void
		{
			if (e.getTouch(stage))
			{
				var touch:Touch = e.getTouch(stage);
				if (touch.phase == TouchPhase.BEGAN)
				{
					stopResetVelocityTimer();
					
					var now:int = getTimer();
					if (clickTime == 0)
					{
						clickTime = now;
					}
					
					var platform:Body = symulation.getBody("Platform");
					var platformVelocity:Vec2 = platform.velocity;
					var platformInnerVelocity:Vec2 = symulation.getBody("PlatformInner").velocity;
					
					if (now - clickTime < 250)
					{
						if (platform.userData.hideDirection == PlatformHideDirection.LEFT && lastMaxVelocity < 1200)
						{
							lastMaxVelocity += 300;
						}
						if (platform.userData.hideDirection == PlatformHideDirection.RIGHT && lastMaxVelocity > -1200)
						{
							lastMaxVelocity -= 300;
						}
						
						platformVelocity.x = lastMaxVelocity;
						platformInnerVelocity.x = lastMaxVelocity;
					}
					else
					{
						if (platform.userData.hideDirection == PlatformHideDirection.LEFT)
						{
							lastMaxVelocity = 500;
						}
						if (platform.userData.hideDirection == PlatformHideDirection.RIGHT)
						{
							lastMaxVelocity = -500;
						}
						platformVelocity.x = lastMaxVelocity;
						platformInnerVelocity.x = lastMaxVelocity;
					}
					
					clickTime = now;
				}
				else if (touch.phase == TouchPhase.ENDED)
				{
					startResetVelocityTimer();
				}
			}
		}
		
		private function startResetVelocityTimer():void
		{
			stopResetVelocityTimer();
			TweenLite.delayedCall(250, resetVelocityTimer);
		}
		
		private function stopResetVelocityTimer():void
		{
			TweenLite.killDelayedCallsTo(resetVelocityTimer);
		}
		
		private function resetVelocityTimer():void
		{
			var platformVelocity:Vec2 = symulation.getBody("Platform").velocity;
			var platformInnerVelocity:Vec2 = symulation.getBody("PlatformInner").velocity;
			
			if (symulation.getBody("Platform").userData.hideDirection == PlatformHideDirection.LEFT && platformVelocity.x > 500)
			{
				lastMaxVelocity = 500;
				platformVelocity.x = 0;
				platformInnerVelocity.x = 0;
			}
			
			if (symulation.getBody("Platform").userData.hideDirection == PlatformHideDirection.RIGHT && platformVelocity.x < -500)
			{
				lastMaxVelocity = -500;
				platformVelocity.x = 0;
				platformInnerVelocity.x = 0;
			}
		}
		
		protected function onEFrame(e:EnterFrameEvent):void
		{
			var platform:Sprite = gameStage.getObject("Platform");
			platform.x = symulation.getBody("Platform").position.x;
			platform.y = symulation.getBody("Platform").position.y;
			
			var cow:Sprite = gameStage.getObject("Cow");
			var ball:Body = symulation.getBody("Ball");
			cow.x = ball.position.x;
			cow.y = ball.position.y;
			cow.rotation = ball.rotation;
			
			var hand:* = gameStage.getObject("Hand");
			var platformBodyHideDirection:String = symulation.getBody("Platform").userData.hideDirection;
			if (platformBodyHideDirection == PlatformHideDirection.RIGHT)
			{
				hand.setWidth(460 - platform.x);
			}
			else
			{
				hand.setWidth(-80 - platform.x);
			}
			
			if (cow.y < 0)
			{
				gameStage.getObject("Indicator").visible = true;
				gameStage.getObject("Indicator").x = cow.x;
			}
			else
			{
				gameStage.getObject("Indicator").visible = false;
			}
			
			if (cow.y > 900)
			{
				endGame();
			}
			else if (cow.x > 560 || cow.x < -20)
			{
				addPoint();
			}
			else
			{
				now = getTimer();
				var delta:int = now - startTime;
				if (delta <= 0)
				{
					delta = 1;
				}
				symulation.update(delta / 1000);
				startTime = now;
			}
		}
		
		protected function addPoint():void
		{
			dispatchEvent(new LevelEvent(LevelEvent.COW_SAVED));
			
			score++;
			Banner(gameStage.getObject("Banner")).savedTxtf.text = "" + score + "/" + scoreToWin;
			
			if (score >= scoreToWin)
			{
				dispatchEvent(new LevelEvent(LevelEvent.WON));
			}
			else
			{
				SoundController.playSound(Assets.assetManager.getSound("collect"));
				
				dropNewCow();
			}
		}
		
		protected function dropNewCow():void
		{
			stop();
			
			resetGame();
			
			start();
		}
		
		protected function resetGame():void
		{
			stopResetVelocityTimer();
			
			isBull = false;
			bullCounter = 0;
			
			symulation.reset();
		}
		
		public function stop():void
		{
			symulation.eventDispatcher.removeEventListener(SimulationEvent.COW_GRABBED, onCowGrabbed_handler);
			
			gameStage.getObject("Death").removeEventListener(Event.COMPLETE, onDeathComplete_handler);
			TweenLite.killTweensOf(gameStage.getObject("DeadCowIcon"));
			gameStage.getObject("DeadCowIcon").visible = false;
			removeEventListener(EnterFrameEvent.ENTER_FRAME, onEFrame);
			stage.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function start():void
		{
			symulation.eventDispatcher.removeEventListener(SimulationEvent.COW_GRABBED, onCowGrabbed_handler);
			symulation.eventDispatcher.addEventListener(SimulationEvent.COW_GRABBED, onCowGrabbed_handler);
			
			gameStage.getObject("Cow").visible = true;
			startTime = getTimer();
			
			removeEventListener(EnterFrameEvent.ENTER_FRAME, onEFrame);
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEFrame);
			
			stage.removeEventListener(TouchEvent.TOUCH, onTouch);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function endGame():void
		{
			stop();
			
			SoundController.playSound(Assets.assetManager.getSound("cowDeath"));
			
			var cow:Sprite = gameStage.getObject("Cow");
			var death:Sprite = gameStage.getObject("Death");
			death.x = cow.x;
			death.y = cow.y;
			death.rotation = cow.rotation;
			death.visible = true;
			death.removeEventListener(Event.COMPLETE, onDeathComplete_handler);
			death.addEventListener(Event.COMPLETE, onDeathComplete_handler);
			CowDeath(death).play();
			
			cow.visible = false;
			
			if (Math.random() > 0.1)
			{
				Starling.current.root.dispatchEvent(new DisplayListEvent(DisplayListEvent.SHOW_INTERSTITIAL));
			}
		}
		
		private function onDeathComplete_handler(e:Event):void
		{
			gameStage.getObject("Death").visible = false;
			gameStage.getObject("Death").removeEventListener(Event.COMPLETE, onDeathComplete_handler);
			
			SoundController.playSound(Assets.assetManager.getSound("fail"));
			
			deadCowIcon = gameStage.getObject("DeadCowIcon");
			deadCowIcon.visible = true;
			TweenLite.to(deadCowIcon, 0, {x: 270, y: 480, scaleX: 3, scaleY: 3, alpha: 0});
			TweenLite.to(deadCowIcon, 0.5, {scaleX: 1, scaleY: 1, alpha: 1, ease: Bounce.easeOut, onComplete: onDeadIconAnimationComplete_handler});
		}
		
		private function onDeadIconAnimationComplete_handler():void
		{
			init();
			
			playBtn.removeEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
			playBtn.alpha = 0;
			playBtn.touchable = false;
			
			DisplayObject(gameStage).removeEventListener(TouchEvent.TOUCH, onDeadCowIconTouch);
			DisplayObject(gameStage).addEventListener(TouchEvent.TOUCH, onDeadCowIconTouch);
		}
		
		private function onDeadCowIconTouch(e:TouchEvent):void
		{
			if (e.getTouch(stage))
			{
				var touch:Touch = e.getTouch(stage);
				if (touch.phase == TouchPhase.BEGAN)
				{
					TweenLite.killTweensOf(deadCowIcon, true);
					
					DisplayObject(gameStage).removeEventListener(TouchEvent.TOUCH, onDeadCowIconTouch);
					deadCowIcon.alpha = 0;
					deadCowIcon.touchable = false;
					
					dropNewCow();
				}
			}
		}
		
	}
}