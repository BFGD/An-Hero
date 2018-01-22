package objects
{
	import core.Assets;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	
	import states.Battle;
	
	public class SlimeBall extends Sprite
	{
		public static const SHOOT:String = "shoot";
		
		private var battle:Battle;
		public var slimeBallShoot:MovieClip;
		private var currentAnim:MovieClip;
		public function SlimeBall(battle:Battle)
		{
			this.battle = battle;
			init();
		}
		
		public function init():void
		{
			slimeBallShoot = new MovieClip(Assets.ta.getTextures("SlimeSplooge_"),4);
			slimeBallShoot.pivotX = slimeBallShoot.width * 0.5;
			slimeBallShoot.pivotY = slimeBallShoot.height * 0.5;
			slimeBallShoot.loop = true;
		}
		
		public function anim(anim:String, start:Boolean):void
		{
			var animation:MovieClip; 
			switch(anim)
			{
				case SHOOT:
					animation = slimeBallShoot;
					break;
			}
			
			if(start)
			{
				if(currentAnim == null)
				{
					addChild(animation);
					Starling.juggler.add(animation);
					currentAnim = animation;
				} 
				else if(currentAnim != null)
				{
					removeChild(currentAnim);
					Starling.juggler.remove(currentAnim);
					
					addChild(animation);
					Starling.juggler.add(animation);
					currentAnim = animation;
				}
			} 
			else
			{
				removeChild(animation);
				Starling.juggler.remove(animation);
			}	
		}
	}
}