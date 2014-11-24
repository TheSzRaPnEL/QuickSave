package com.szrapnel.games.quicksave.services
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.quicksave.events.LevelEvent;
	import com.szrapnel.games.quicksave.events.SimulationEvent;
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.BitmapDebug;
	import starling.core.Starling;
	import starling.events.EventDispatcher;
	
	public class FirePitSimulation implements ISimulation
	{
		private static const debugMode:Boolean = false;
		
		private var _space:Space;
		private var topWall:Body;
		private var leftWall:Body;
		private var rightWall:Body;
		private var rightWallBot:Body;
		private var dockWallTop:Body;
		private var dockWallBot:Body;
		protected var bouncyMaterial:Material;
		protected var glueMaterial:Material;
		protected var bodies:Vector.<Body>;
		private var debug:BitmapDebug;
		protected var _interactionListener:InteractionListener;
		private var f1c:CbType = new CbType();
		private var f2c:CbType = new CbType();
		protected var _grabbed:Boolean;
		protected var _isBull:Boolean;
		private var _bullCounter:int;
		protected var ballToPlatformOffset:int = 0;
		private var _eventDispatcher:EventDispatcher;
		
		public function FirePitSimulation():void
		{
			_eventDispatcher = new EventDispatcher();
			bodies = new Vector.<Body>;
			_isBull = false;
			super();
		}
		
		public function generate():void
		{
			var gravity:Vec2 = Vec2.weak(0, 400);
			space = new Space(gravity);
			space.worldAngularDrag = 0.0000015;
			space.worldLinearDrag = 0.0000015;
			
			bouncyMaterial = new Material(1, 1, 2, 1);
			glueMaterial = new Material(0.1, 2, 4, 2);
			
			setUp();
			
			grabbed = false;
			
			if (_interactionListener == null)
			{
				_interactionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, f1c, f2c, collision);
				space.listeners.add(interactionListener);
			}
		}
		
		protected function collision(collision:InteractionCallback):void
		{
			var cow:Body = collision.int1.castBody;
			var platform:Body = getBody("Platform");
			if (cow.position.y < platform.position.y && cow.position.y > platform.position.y - 45)
			{
				cow.type = BodyType.KINEMATIC;
				cow.velocity = Vec2.weak();
				cow.angularVel = 0;
				space.listeners.remove(interactionListener);
				grabbed = true;
				ballToPlatformOffset = cow.position.x - platform.position.x;
				cow.position.y = platform.position.y - 35;
				getBody("RightWall").position.x = 1000;
				TweenLite.to(cow, 0.2, {rotation: int(cow.rotation / (Math.PI / 2)) * (Math.PI / 2), onComplete: rotationComplete_handler});
			}
		}
		
		private function rotationComplete_handler():void 
		{
			eventDispatcher.dispatchEvent(new SimulationEvent(SimulationEvent.COW_GRABBED));
		}
		
		private function setUp():void
		{
			var w:int = 540;
			var h:int = 960;
			
			var ball:Body = new Body(BodyType.DYNAMIC);
			ball.userData.name = "Ball";
			bodies.push(ball);
			ball.shapes.add(new Polygon(Polygon.box(50, 50)));
			ball.shapes.at(0).fluidEnabled = false;
			ball.shapes.at(0).sensorEnabled = false;
			ball.position.setxy(430 * Math.random() + 20, -100);
			ball.setShapeMaterials(bouncyMaterial);
			ball.angularVel = 10;
			ball.space = space;
			ball.cbTypes.add(f1c);
			
			var platform:Body = new Body(BodyType.KINEMATIC);
			platform.userData.name = "Platform";
			bodies.push(platform);
			platform.allowRotation = false;
			platform.shapes.add(new Polygon(Polygon.rect(10, -5, 150, 25)));
			platform.shapes.add(new Polygon(Polygon.rect(10, -40, 15, 40)));
			platform.shapes.add(new Polygon(Polygon.rect(145, -40, 15, 40)));
			platform.setShapeMaterials(glueMaterial);
			platform.shapes.at(0).fluidEnabled = false;
			platform.shapes.at(0).sensorEnabled = false;
			platform.shapes.at(1).fluidEnabled = false;
			platform.shapes.at(1).sensorEnabled = false;
			platform.shapes.at(2).fluidEnabled = false;
			platform.shapes.at(2).sensorEnabled = false;
			platform.position.setxy(100, h / 2);
			platform.velocity.x = 0;
			platform.space = space;
			
			var platformInner:Body = new Body(BodyType.KINEMATIC);
			platformInner.userData.name = "PlatformInner";
			bodies.push(platformInner);
			platformInner.allowRotation = false;
			platformInner.shapes.add(new Polygon(Polygon.rect(25, -10, 120, 5)));
			platformInner.setShapeMaterials(glueMaterial);
			platformInner.shapes.at(0).fluidEnabled = false;
			platformInner.shapes.at(0).sensorEnabled = false;
			platformInner.position.setxy(100, h / 2);
			platformInner.velocity.x = 0;
			platformInner.space = space;
			platformInner.cbTypes.add(f2c);
			
			topWall = new Body(BodyType.STATIC);
			topWall.shapes.add(new Polygon(Polygon.rect(-50, -400, 640, 40)));
			topWall.setShapeMaterials(glueMaterial);
			topWall.space = space;
			
			leftWall = new Body(BodyType.STATIC);
			leftWall.shapes.add(new Polygon(Polygon.rect(-50, -400, 55, h + 500)));
			leftWall.setShapeMaterials(glueMaterial);
			leftWall.space = space;
			
			rightWall = new Body(BodyType.STATIC);
			rightWall.userData.name = "RightWall";
			bodies.push(rightWall);
			rightWall.shapes.add(new Polygon(Polygon.rect(w - 5, -400, 35, h + 500)));
			rightWall.setShapeMaterials(glueMaterial);
			rightWall.space = space;
			
			if (debugMode)
			{
				debug = new BitmapDebug(w, h, 0, true);
				Starling.current.nativeStage.addChild(debug.display);
				debug.display.x = int(Starling.current.stage.stageWidth - 540) / 2;
			}
		}
		
		public function reset():void
		{
			dropNewCow();
			
			var platform:Body = getBody("Platform");
			platform.position.setxy(100, 480);
			platform.velocity.x = 0;
			
			var platformInner:Body = getBody("PlatformInner");
			platformInner.position.setxy(100, 480);
			platformInner.velocity.x = 0;
		}
		
		public function dropNewCow():void
		{
			grabbed = false;
			
			var rightWall:Body = getBody("RightWall");
			rightWall.position.x = 0;
			
			var ball:Body = getBody("Ball");
			ball.type = BodyType.DYNAMIC;
			ball.position.setxy(430 * Math.random() + 20, -100);
			ball.angularVel = 10 * Math.random() - 5;
			ball.rotation = 0;
			ball.velocity = Vec2.weak(600 * Math.random() - 300, 0);
			
			space.listeners.add(interactionListener);
		}
		
		public function update(time:Number):void
		{
			for each (var body:Body in bodies)
			{
				if (Math.abs(body.velocity.x) > 1200)
				{
					body.velocity.x *= 1200 / Math.abs(body.velocity.x);
				}
				if (Math.abs(body.velocity.y) > 1200)
				{
					body.velocity.y *= 1200 / Math.abs(body.velocity.y);
				}
			}
			
			space.step(time, 4, 4);
			
			lowerForces();
			illegalCollisions();
			
			if (debugMode)
			{
				debug.clear();
				debug.draw(space);
				debug.flush();
			}
		}
		
		private function illegalCollisions():void
		{
			var platform:Body = getBody("Platform");
			if (platform.position.x < 0)
			{
				platform.position.x = 0;
				platform.velocity.x = 0;
			}
			
			var platformInner:Body = getBody("PlatformInner");
			if (platformInner.position.x < 0)
			{
				platformInner.position.x = 0;
				platformInner.velocity.x = 0;
			}
			
			var cow:Body = getBody("Ball");
			if (cow.position.x < 24 && platform.position.x < 24 && cow.position.y > platform.position.y - 80 && cow.position.y < platform.position.y + 60)
			{
				eventDispatcher.dispatchEvent(new LevelEvent(LevelEvent.LOST));
			}
		}
		
		private function lowerForces():void
		{
			var platform:Body = getBody("Platform");
			if (platform.position.x < 520)
			{
				platform.velocity.x += 35;
				if (grabbed)
				{
					getBody("Ball").position.x = platform.position.x + ballToPlatformOffset;
				}
			}
			else
			{
				platform.position.x = 520;
				platform.velocity.x = 0;
				if (grabbed)
				{
					getBody("Ball").velocity.x = 0;
					getBody("Ball").position.x = 600;
				}
			}
			
			var platformInner:Body = getBody("PlatformInner");
			if (platformInner.position.x < 520)
			{
				platformInner.velocity.x += 35;
			}
			else
			{
				platformInner.position.x = 520;
				platformInner.velocity.x = 0;
			}
		}
		
		public function getBody(name:String):Body
		{
			for each (var body:Body in bodies)
			{
				if (body.userData.name == name)
				{
					return body;
				}
			}
			return null;
		}
		
		public function get grabbed():Boolean 
		{
			return _grabbed;
		}
		
		public function set grabbed(value:Boolean):void 
		{
			_grabbed = value;
		}
		
		public function get space():Space
		{
			return _space;
		}
		
		public function set space(value:Space):void
		{
			_space = value;
		}
		
		public function get eventDispatcher():EventDispatcher
		{
			return _eventDispatcher;
		}
		
		public function get interactionListener():InteractionListener 
		{
			return _interactionListener;
		}
		
	}
}