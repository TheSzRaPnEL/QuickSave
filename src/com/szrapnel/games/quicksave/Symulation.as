package com.szrapnel.games.quicksave
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.geom.Geom;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.space.Broadphase;
	import nape.space.Space;
	import nape.util.BitmapDebug;
	import starling.core.Starling;
	
    public class Symulation
	{
		private static const debugMode:Boolean = false;
        private var _space:Space;
		private var _ball:Body;
		private var _platform:Body;
		private var _platform2:Body;
		private var debug:BitmapDebug;
		private var leftWall:Body;
		private var rightWall:Body;
		private var rightWallBot:Body;
		private var dockWallTop:Body;
		private var dockWallBot:Body;
		private var bouncyMaterial:Material;
		private var glueMaterial:Material;
		private var interactionListener:InteractionListener;
		private var f1c:CbType = new CbType();
		private var f2c:CbType = new CbType();
		private var antiGlitch:Body;
 
        public function Symulation():void
		{
            super();
			
			generate();
        }
		
        private function generate():void
		{
            var gravity:Vec2 = Vec2.weak(0, 600);
            space = new Space(gravity);
			space.worldAngularDrag = 0.001;
			space.worldLinearDrag = 0.001;
			
			//bouncyMaterial = new Material(1, 0.5, 1, 0.5);
			bouncyMaterial = new Material(1, 1, 2, 1);
			glueMaterial = new Material(0.01, 2, 4, 2, 1);
			
			setUp();
			
			interactionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, f1c, f2c, collision);
			space.listeners.add(interactionListener);
        }
		
		private function collision(collision:InteractionCallback):void 
		{
			//collision.int1.castBody.applyImpulse(Vec2.weak(0, 5000));
			//collision.int2.castBody.applyImpulse(Vec2.weak(10000, 10000));
			//trace(collision.int1.isBody);
			if (Geom.intersectsBody(ball, leftWall))
			{
				ball.position.y = ball.position.y - 50;
				ball.applyImpulse(Vec2.weak(0, 200));
			}
		}
		
        private function setUp():void
		{
            var w:int = 540;
            var h:int = 960;
			
            _ball = new Body(BodyType.DYNAMIC);
            ball.shapes.add(new Polygon(Polygon.box(50, 50)));
            //ball.shapes.add(new Circle(25));
			ball.shapes.at(0).fluidEnabled = false;
			ball.shapes.at(0).sensorEnabled = false;
            ball.position.setxy(w / 2, -100);
			ball.setShapeMaterials(bouncyMaterial);
            ball.angularVel = 10;
            ball.space = space;
			ball.cbTypes.add(f1c);
			
			antiGlitch = new Body(BodyType.KINEMATIC);
			antiGlitch.shapes.add(new Polygon(Polygon.box(50, 50)));
			antiGlitch.position.setxy(w / 2, -109);
			antiGlitch.space = space;
			
			_platform = new Body(BodyType.KINEMATIC);
			platform.allowRotation = false;
            platform.shapes.add(new Polygon(Polygon.rect(10, -5, 125, 25)));
            platform.shapes.add(new Polygon(Polygon.rect(10, -40, 15, 40)));
            platform.shapes.add(new Polygon(Polygon.rect(120, -40, 15, 40)));
			platform.setShapeMaterials(glueMaterial);;
			platform.shapes.at(0).fluidEnabled = false;
			platform.shapes.at(0).sensorEnabled = false;
			platform.shapes.at(1).fluidEnabled = false;
			platform.shapes.at(1).sensorEnabled = false;
			platform.shapes.at(2).fluidEnabled = false;
			platform.shapes.at(2).sensorEnabled = false;
            platform.position.setxy(100, h/2);
            platform.velocity.x = 0;
			platform.cbTypes.add(f2c);
            platform.space = space;
			
			_platform2 = new Body(BodyType.KINEMATIC);
			platform2.allowRotation = false;
            platform2.shapes.add(new Polygon(Polygon.rect(10, -5, 125, 25)));
            platform2.shapes.add(new Polygon(Polygon.rect(10, -40, 15, 40)));
            platform2.shapes.add(new Polygon(Polygon.rect(120, -40, 15, 40)));
			platform2.setShapeMaterials(glueMaterial);;
			platform2.shapes.at(0).fluidEnabled = false;
			platform2.shapes.at(0).sensorEnabled = false;
			platform2.shapes.at(1).fluidEnabled = false;
			platform2.shapes.at(1).sensorEnabled = false;
			platform2.shapes.at(2).fluidEnabled = false;
			platform2.shapes.at(2).sensorEnabled = false;
            platform2.position.setxy(100, h / 2 + 200);
            platform2.velocity.x = 0;
			platform2.cbTypes.add(f2c);
            platform2.space = space;
			
			leftWall = new Body(BodyType.STATIC);
            leftWall.shapes.add(new Polygon(Polygon.rect(-50, -100, 55, h + 200)));
			leftWall.setShapeMaterials(glueMaterial);
            leftWall.space = space;
			
			rightWall = new Body(BodyType.STATIC);
            rightWall.shapes.add(new Polygon(Polygon.rect(w - 5, -100, 35, 475)));
			rightWall.setShapeMaterials(glueMaterial);
            rightWall.space = space;
			
			rightWallBot = new Body(BodyType.STATIC);
            rightWallBot.shapes.add(new Polygon(Polygon.rect(w - 5, 545, 35, 455)));
			rightWallBot.setShapeMaterials(glueMaterial);
            rightWallBot.space = space;
			
			dockWallTop = new Body(BodyType.STATIC);
            dockWallTop.shapes.add(new Polygon(Polygon.rect(0, 0, 50, 25)));
			dockWallTop.setShapeMaterials(glueMaterial);
			dockWallTop.position.setxy(w - 22, 373);
			dockWallTop.space = space;
			
			dockWallBot = new Body(BodyType.STATIC);
            dockWallBot.shapes.add(new Polygon(Polygon.rect(0, 0, 50, 25)));
			dockWallBot.setShapeMaterials(glueMaterial);
			dockWallBot.position.setxy(w - 22, 523);
            dockWallBot.space = space;
			
			if (debugMode)
			{
				debug = new BitmapDebug(w, h, 0, true);
				debug.display.scaleX = Starling.current.viewPort.width / 540;
				debug.display.scaleY = Starling.current.viewPort.height / 960;
				Starling.current.nativeStage.addChild(debug.display);
			}
        }
		
		public function reset():void
		{
			ball.position.setxy(270, -100);
			ball.velocity = Vec2.weak(0, 0);
            ball.angularVel = 0;
			ball.rotation = 0;
			
			platform.position.setxy(100, 480);
            platform.velocity.x = 0;
			
			platform2.position.setxy(100, 680);
            platform2.velocity.x = 0;
		}
		
		public function dropNewCow():void
		{
			ball.position.setxy((540 - 90) * Math.random(), -100);
			ball.angularVel = 0;
			ball.rotation = 0;
            ball.velocity = Vec2.weak(0, 0);
		}
		
        public function update(time:Number):void
		{
            space.step(time);	
			
			lowerForces();
			illegalCollisions();
			
			if (debugMode)
			{
				debug.clear();
				debug.draw(space);
				debug.flush();
			}
			
			antiGlitch.space = null;
        }
		
		private function illegalCollisions():void 
		{
			if (platform.position.x < 0)
			{
				platform.position.x = 0;
				platform.velocity.x = 0;
			}
			if (ball.position.x < 24 && platform.position.x < 24)
			{
				platform.position.x = 25;
				platform.velocity.x = 0;
			}
			
			if (platform2.position.x > 420)
			{
				platform2.position.x = 420;
				platform2.velocity.x = 0;
			}
			if (ball.position.x > 500 && platform2.position.x > 400)
			{
				platform2.position.x = 400;
				platform2.velocity.x = 0;
			}
		}
		
		private function lowerForces():void 
		{
			if (platform.position.x < 520)
			{
				platform.velocity.x += 35;
			}
			else
			{
				platform.position.x = 520;
				platform.velocity.x = 0;
			}
			
			if (platform2.position.x > -50)
			{
				platform2.velocity.x -= 35;
			}
			else
			{
				platform2.position.x = -50;
				platform2.velocity.x = 0;
			}
		}
		
		public function get ball():Body 
		{
			return _ball;
		}
		
		public function get platform():Body 
		{
			return _platform;
		}
		
		public function get platform2():Body 
		{
			return _platform2;
		}
		
		public function get space():Space 
		{
			return _space;
		}
		
		public function set space(value:Space):void 
		{
			_space = value;
		}
    }
}