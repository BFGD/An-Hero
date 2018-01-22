package objects
{
	import core.Assets;
	
	import interfaces.ICharacters;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	
	import states.Battle;
	
	public class HealthBars extends Sprite
	{
		private var battle:Battle;
		public var heroHealthBar:MovieClip;
		public var bossHealthBar:MovieClip;
		
		public function HealthBars(battle:Battle)
		{
			this.battle = battle;
			init()
		}
		
		public function init():void
		{
			heroHealthBar = new MovieClip(Assets.ta.getTextures("Health_"),1);
			heroHealthBar.pivotX = heroHealthBar.width *0.5;
			heroHealthBar.pivotY = 24;
			heroHealthBar.currentFrame = 0;
			heroHealthBar.pause();
			heroHealthBar.x = 150;
			heroHealthBar.y = -100;
			addChild(heroHealthBar);
			Starling.juggler.add(heroHealthBar);
			
			
			bossHealthBar = new MovieClip(Assets.ta.getTextures("Health_"),1);
			bossHealthBar.pivotX = bossHealthBar.width *0.5;
			bossHealthBar.pivotY = 24;
			bossHealthBar.currentFrame = 0;
			bossHealthBar.pause();
			bossHealthBar.x = 800;
			bossHealthBar.y = -100;
			addChild(bossHealthBar);
			Starling.juggler.add(bossHealthBar);
		}
		
		public function reduceHealthBar(character:String, amount:int):void
		{
			switch(character)
			{
				case "hero":
					heroHealthBar.play();
					heroHealthBar.currentFrame += amount;
					heroHealthBar.pause();
					trace("Hero health reduced by: " + amount);
					break;
					
				case "slime boss":
					bossHealthBar.currentFrame += amount;
					trace("Slime boss health BAR reduced by: " + amount);
					break;
			}
		}
	}
}