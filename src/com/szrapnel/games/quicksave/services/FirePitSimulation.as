package com.szrapnel.games.quicksave.services
{
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	public class FirePitSimulation implements ISimulation
	{
		private var _space:Space;
		private var topWall:Body;
		private var leftWall:Body;
		private var rightWall:Body;
		private var rightWallBot:Body;
		private var dockWallTop:Body;
		private var dockWallBot:Body;
		private var bouncyMaterial:Material;
		private var glueMaterial:Material;
		private var superGlueMaterial:Material;
		private var antiGlitch:Body;
		private var bodies:Vector.<Body>;
		
		public function FirePitSimulation():void
		{
			bodies = new Vector.<Body>;
			super();
		}
		
		public function generate():void
		{
			var gravity:Vec2 = Vec2.weak(0, 400);
			space = new Space(gravity);
			space.worldAngularDrag = 0.001;
			space.worldLinearDrag = 0.001;
			
			bouncyMaterial = new Material(1, 0.5, 0.5, 1);
			glueMaterial = new Material(0, 5, 5, 0.01, 1);
			superGlueMaterial = new Material(0, 15, 15, 0.01, 5);
			
			setUp();
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
			ball.position.setxy(w / 2, -100);
			ball.setShapeMaterials(bouncyMaterial);
			ball.angularVel = 10;
			ball.space = space;
			
			antiGlitch = new Body(BodyType.KINEMATIC);
			antiGlitch.shapes.add(new Polygon(Polygon.box(50, 50)));
			antiGlitch.position.setxy(w / 2, -109);
			antiGlitch.space = space;
			
			var platform:Body = new Body(BodyType.KINEMATIC);
			platform.userData.name = "Platform";
			bodies.push(platform);
			platform.allowRotation = false;
			platform.shapes.add(new Polygon(Polygon.rect(10, -5, 175, 25)));
			//platform.shapes.add(new Polygon(Polygon.rect(25, -40, 10, 40)));
			//platform.shapes.add(new Polygon(Polygon.rect(145, -40, 10, 40)));
			platform.shapes.add(new Polygon(Polygon.rect(10, -40, 15, 40)));
			platform.shapes.add(new Polygon(Polygon.rect(170, -40, 15, 40)));
			platform.setShapeMaterials(superGlueMaterial);
			platform.shapes.at(0).material = superGlueMaterial;
			platform.shapes.at(1).material = superGlueMaterial;
			platform.shapes.at(2).material = superGlueMaterial;
			//platform.shapes.at(3).material = glueMaterial;
			//platform.shapes.at(4).material = glueMaterial;
			platform.shapes.at(0).fluidEnabled = false;
			platform.shapes.at(0).sensorEnabled = false;
			platform.shapes.at(1).fluidEnabled = false;
			platform.shapes.at(1).sensorEnabled = false;
			platform.shapes.at(2).fluidEnabled = false;
			platform.shapes.at(2).sensorEnabled = false;
			//platform.shapes.at(3).sensorEnabled = false;
			//platform.shapes.at(3).sensorEnabled = false;
			//platform.shapes.at(4).sensorEnabled = false;
			//platform.shapes.at(4).sensorEnabled = false;
			platform.position.setxy(100, h / 2);
			platform.velocity.x = 0;
			platform.space = space;
			
			topWall = new Body(BodyType.STATIC);
			topWall.shapes.add(new Polygon(Polygon.rect(-50, -400, 640, 40)));
			topWall.setShapeMaterials(glueMaterial);
			topWall.space = space;
			
			leftWall = new Body(BodyType.STATIC);
			leftWall.shapes.add(new Polygon(Polygon.rect(-50, -400, 55, h + 500)));
			leftWall.setShapeMaterials(glueMaterial);
			leftWall.space = space;
			
			rightWall = new Body(BodyType.STATIC);
			rightWall.shapes.add(new Polygon(Polygon.rect(w - 5, -400, 35, 775)));
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
		}
		
		public function reset():void
		{
			var ball:Body = getBody("Ball");
			ball.position.setxy(270, -100);
			ball.velocity = Vec2.weak(0, 0);
			ball.angularVel = 0;
			ball.rotation = 0;
			
			var platform:Body = getBody("Platform");
			platform.position.setxy(100, 480);
			platform.velocity.x = 0;
		}
		
		public function dropNewCow():void
		{
			var ball:Body = getBody("Ball");
			ball.position.setxy((540 - 90) * Math.random(), -100);
			ball.angularVel = 0;
			ball.rotation = 0;
			ball.velocity = Vec2.weak(0, 0);
		}
		
		public function update(time:Number):void
		{
			space.step(time, 4, 4);
			
			lowerForces();
			illegalCollisions();
			
			antiGlitch.space = null;
		}
		
		private function illegalCollisions():void
		{
			var platform:Body = getBody("Platform");
			if (platform.position.x < 0)
			{
				platform.position.x = 0;
				platform.velocity.x = 0;
			}
			
			if (getBody("Ball").position.x < 24 && platform.position.x < 24)
			{
				platform.position.x = 25;
				platform.velocity.x = 0;
			}
		}
		
		private function lowerForces():void
		{
			var platform:Body = getBody("Platform");
			if (platform.position.x < 520)
			{
				platform.velocity.x += 35;
			}
			else
			{
				platform.position.x = 520;
				platform.velocity.x = 0;
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