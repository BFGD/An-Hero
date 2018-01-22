package objects
{

	import com.greensock.TweenMax;
	
	import core.Assets;
	
	import flash.events.MouseEvent;
	
	import interfaces.ICharacters;
	import interfaces.IState;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import states.Battle;
	
	public class SlimeBoss extends Sprite implements ICharacters
	{
		// static animation sequences
		public static const IDLE:String = "idle";
		public static const MOVE:String = "move";
		public static const ATTACK:String = "attack";
		
		public var health:int = 100;
		public var reverseHealth:int = 0;
		private var battle:Battle;
		public var slimeIdle:MovieClip;
		private var slimeMove:MovieClip;
		public var slimeAttack:MovieClip;
		
		private var currentAnim:MovieClip = null;
		
		
		public function SlimeBoss(battle:Battle)
		{
			this.battle = battle;
			init();
		}
		
		public function init():void
		{
			slimeIdle = new MovieClip(Assets.ta.getTextures("Slime_Idle"),4);
			slimeIdle.pivotX = slimeIdle.width * 0.5;
			slimeIdle.pivotY = 235;
			slimeIdle.touchable = true;
			
			slimeMove = new MovieClip(Assets.ta.getTextures("SlimeBoss_Move"),4);
			slimeMove.pivotX = slimeMove.width * 0.5;
			slimeMove.pivotY = 235;
			
			slimeAttack = new MovieClip(Assets.ta.getTextures("Slime_Attack"),2);
			slimeAttack.pivotX = slimeAttack.width * 0.5;
			slimeAttack.loop = false;
			slimeAttack.pivotY = 235;
			
		
			
		}
		
		public function anim(anim:String, start:Boolean):void
		{
			var animation:MovieClip; 
			switch(anim)
			{
				case IDLE:
					animation = slimeIdle;
					break;
				
				case MOVE:
					animation = slimeMove;
					break;
				
				case ATTACK:
					animation = slimeAttack;
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
		
		}
		
		public function shootSlime():void
		{
			currentAnim.removeFromParent()
			Starling.juggler.remove(currentAnim);
				

			addChild(slimeAttack)
			Starling.juggler.add(slimeAttack);
			
			
		}
		
		public function update():void
		{
			if(slimeAttack.isComplete)
			{
				slimeAttack.removeFromParent();
				Starling.juggler.remove(slimeAttack);
				
				addChild(slimeIdle);
				Starling.juggler.add(slimeIdle);
			}
		}
	}
}