package objects
{
	import core.Assets;
	import core.Game;
	
	import interfaces.ICharacters;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import states.Battle;
	
	public class Hero extends Sprite implements ICharacters
	{
		// static animation sequences
		public static const IDLE:String = "idle";
		public static const WALK:String = "walk";
		public static const JAB:String = "jab";
		public static const SWIPE:String = "swipe";
		
		public var health:int = 100;
		private var battle:Battle;
		
		public var heroIdle:MovieClip;
		public var heroWalk:MovieClip;
		private var currentAnim:MovieClip = null;
		private var heroJab:MovieClip;
		public var heroSwipe:MovieClip;
		
		
		public function Hero(battle:Battle)
		{
			this.battle = battle;
			init();
		}
		
		public function init():void
		{
			//heroIdle = new HeroIdle();
			//addChild(heroIdle);
			
			//test
			heroIdle = new MovieClip(Assets.ta.getTextures(Game.getCharacterString() + "_Right_Idle"),4);
			heroIdle.pivotX = heroIdle.width * 0.5;
			heroIdle.pivotY = 144;
			
			heroWalk = new MovieClip(Assets.ta.getTextures(Game.getCharacterString() + "_Right_Walk"),12);
			heroWalk.pivotX = heroWalk.width * 0.5;
			heroWalk.pivotY = 144;
			
			heroJab = new MovieClip(Assets.ta.getTextures(Game.getCharacterString() + "_Right_Attack_Jab"),12);
			heroJab.pivotX = heroJab.width * 0.5;
			heroJab.pivotY = 144;
			
			heroSwipe = new MovieClip(Assets.ta.getTextures(Game.getCharacterString() + "_Right_Attack_Swipe"),30);
			heroSwipe.pivotX = heroSwipe.width * 0.5;
			heroSwipe.pivotY = 144;
			
		}
		
		public function swipe():void
		{
			heroSwipe.play();
			removeChild(currentAnim);
			Starling.juggler.remove(currentAnim);
			
			addChild(heroSwipe);
			Starling.juggler.add(heroSwipe);
			
		}
		
		public function removeSwipe():void
		{
			removeChild(currentAnim);
			Starling.juggler.remove(currentAnim);
		}
		
		public function anim(anim:String, start:Boolean, setFrame:int = -1):void
		{
			var animation:MovieClip; 
			switch(anim)
			{
				case IDLE:
					animation = heroIdle;
					break;
				
				case WALK:
					animation = heroWalk;
					break;
				
				case JAB:
					animation = heroJab;
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
			
			if(setFrame > -1)
			{
				animation.currentFrame = setFrame;
				animation.pause();
			}
		}
		
		public function update():void
		{
			if(heroSwipe.currentFrame == 2)
			{
				heroSwipe.stop();
			}
		}
	}
}