package com.szrapnel.games.quicksave.services {
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import nape.geom.Vec2;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class GameLogic extends Sprite
	{
		private var gameStage:GameStage;
		private var symulation:Symulation;
		private var startTime:Number;
		private var score:int;
		private var level:int;
		private var now:Number;
		private var now2:Number;
		private var clickTime:Number;
		private var clickTime2:Number;
		private var lastMaxVelocity:Number;
		private var lastMaxVelocity2:Number;
		private var timerId:uint;
		private var timerId2:uint;
		
		public function GameLogic(gameStage:GameStage,symulation:Symulation) 
		{
			this.gameStage = gameStage;
			this.symulation = symulation;
			clickTime = 0;
			lastMaxVelocity = -500;
			
			gameStage.playBtn.removeEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
			gameStage.playBtn.addEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
		}
		
		private function onPlayBtnTouch(e:TouchEvent):void 
		{
			if (e.getTouch(stage))
			{
				var touch:Touch = e.getTouch(stage);
				if (touch.phase == TouchPhase.BEGAN)
				{
					gameStage.playBtn.removeEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
					gameStage.playBtn.alpha = 0;
					gameStage.playBtn.touchable = false;
					
					init();
				}
			}
		}
		
		public function init():void
		{
			startTime = new Date().time;
			score = 0;
			level = 1;
			gameStage.banner.savedTxtf.text = "" + score+"/" + (level * 10);
			
			removeEventListener(Event.ENTER_FRAME, onEFrame);
			addEventListener(Event.ENTER_FRAME, onEFrame);
			
			stage.removeEventListener(TouchEvent.TOUCH, onTouch);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			if (e.getTouch(stage))
			{
				var touches:Vector.<Touch> = e.getTouches(stage);
				for each (var touch:Touch in touches)
				{
					if (touch.getLocation(stage).x > 270)
					{
						if (touch.phase == TouchPhase.BEGAN)
						{
							stopResetVelocityTimer();
							
							var now:Number = new Date().time;
							if (clickTime == 0)
							{
								clickTime = now;
							}
							
							if (now - clickTime < 250)
							{
								lastMaxVelocity -= 300;
								symulation.platform.velocity.x = lastMaxVelocity;
							}
							else if (symulation.platform.velocity.x > -500)
							{
								symulation.platform.velocity.x = -500;
								lastMaxVelocity = -500;
							}
							
							clickTime = now;
						}
						else if (touch.phase == TouchPhase.ENDED)
						{
							startResetVelocityTimer();
						}
					}
					else if (touch.getLocation(stage).x < 270)
					{
						if (touch.phase == TouchPhase.BEGAN)
						{
							stopResetVelocityTimer();
							
							var now2:Number = new Date().time;
							if (clickTime2 == 0)
							{
								clickTime2 = now;
							}
							
							if (now2 - clickTime2 < 250)
							{
								lastMaxVelocity2 += 300;
								symulation.platform2.velocity.x = lastMaxVelocity2;
							}
							else if (symulation.platform2.velocity.x < 500)
							{
								symulation.platform2.velocity.x = 500;
								lastMaxVelocity2 = 500;
							}
							
							clickTime2 = now2;
						}
						else if (touch.phase == TouchPhase.ENDED)
						{
							startResetVelocityTimer2();
						}
					}
				}
			}
		}
		
		private function startResetVelocityTimer():void 
		{
			clearTimeout(timerId)
			timerId = setTimeout(resetVelocityTimer, 300);
		}
		
		private function stopResetVelocityTimer():void 
		{
			clearTimeout(timerId);
		}
		
		private function resetVelocityTimer():void 
		{
			if (symulation.platform.velocity.x <= -500)
			{
				symulation.platform.velocity.x = -500;
				lastMaxVelocity = -500;
			}
		}
		
		private function startResetVelocityTimer2():void 
		{
			clearTimeout(timerId2)
			timerId2 = setTimeout(resetVelocityTimer2, 300);
		}
		
		private function stopResetVelocityTimer2():void 
		{
			clearTimeout(timerId2);
		}
		
		private function resetVelocityTimer2():void 
		{
			if (symulation.platform2.velocity.x >= 500)
			{
				symulation.platform2.velocity.x = 500;
				lastMaxVelocity2 = 500;
			}
		}
		
		private function onEFrame(e:Event):void 
		{
			gameStage.cow.x = symulation.ball.position.x;
			gameStage.cow.y = symulation.ball.position.y;
			gameStage.cow.rotation = symulation.ball.rotation;
			
			gameStage.platform.x = symulation.platform.position.x;
			gameStage.platform2.x = symulation.platform2.position.x;
			
			if (gameStage.cow.y > 960)
			{
				theend();
			}
			else if (gameStage.cow.x > 540 || gameStage.cow.x < -110)
			{
				dropNewCow();
			}
			else
			{
				now = new Date().time;
				symulation.update((now - startTime + 1) / 1000);
				//symulation.update(1/60);
				startTime = now;
			}
		}
		
		private function dropNewCow():void 
		{
			score++;
			if (score >= 10)
			{
				level++;
				symulation.space.gravity = Vec2.weak(0, 500+100*level);
			}
			gameStage.banner.savedTxtf.text = "" + score+"/" + (level * 10);
			symulation.dropNewCow();
		}
		
		public function theend():void 
		{
			symulation.reset();
			symulation.update(0.1);
			
			gameStage.cow.x = symulation.ball.position.x;
			gameStage.cow.y = symulation.ball.position.y;
			gameStage.platform.x = symulation.platform.position.x;
			
			removeEventListener(Event.ENTER_FRAME, onEFrame);
			removeEventListener(TouchEvent.TOUCH, onTouch);
			
			gameStage.playBtn.removeEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
			gameStage.playBtn.addEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
			gameStage.playBtn.alpha = 1;
			gameStage.playBtn.touchable = true;
		}
		
	}

}