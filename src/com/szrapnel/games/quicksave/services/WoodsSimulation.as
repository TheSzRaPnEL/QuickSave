package com.szrapnel.games.quicksave.services
{
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	
	public class WoodsSimulation extends FirePitSimulation
	{
		private var obstacleTop:Body;
		private var obstacleBot:Body;
		
		public function WoodsSimulation():void
		{
			super();
		}
		
		public override function generate():void
		{
			super.generate();
			
			obstacleTop = new Body(BodyType.KINEMATIC);
			obstacleTop.userData.name = "ObstacleTop";
			bodies.push(obstacleTop);
			obstacleTop.shapes.add(new Circle(20));
			obstacleTop.setShapeMaterials(glueMaterial);
			obstacleTop.position.setxy(170, 280);
			obstacleTop.space = space;
			
			obstacleBot = new Body(BodyType.KINEMATIC);
			obstacleBot.userData.name = "ObstacleBot";
			bodies.push(obstacleBot);
			obstacleBot.shapes.add(new Circle(20));
			obstacleBot.setShapeMaterials(glueMaterial);
			obstacleBot.position.setxy(370, 560);
			obstacleBot.space = space;
		}
		
		public override function reset():void
		{
			super.reset();
			
			obstacleTop.position.setxy(170, 280);
			obstacleTop.velocity.x = 250;
			
			obstacleBot.position.setxy(370, 560);
			obstacleBot.velocity.x = -250;
		}
		
		public override function update(time:Number):void
		{
			super.update(time);
			
			if (obstacleTop.position.x > 470)
			{
				obstacleTop.velocity.x = -250;
			}
			
			if (obstacleTop.position.x < 70)
			{
				obstacleTop.velocity.x = 250;
			}
			
			if (obstacleBot.position.x > 470)
			{
				obstacleBot.velocity.x = -250;
			}
			
			if (obstacleBot.position.x < 70)
			{
				obstacleBot.velocity.x = 250;
			}
		}
		
	}
}