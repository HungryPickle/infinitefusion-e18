
#==============================================================================#
#                         Better Fast-forward Mode                             #
#                                   v1.0                                       #
#                                                                              #
#                                 by Marin                                     #
#==============================================================================#
#                                   Usage                                      #
#                                                                              #
# SPEEDUP_STAGES are the speed stages the game will pick from. If you click F, #
# it'll choose the next number in that array. It goes back to the first number #
#                                 afterward.                                   #
#                                                                              #
#             $GameSpeed is the current index in the speed up array.           #
#   Should you want to change that manually, you can do, say, $GameSpeed = 0   #
#                                                                              #
# If you don't want the user to be able to speed up at certain points, you can #
#                use "pbDisallowSpeedup" and "pbAllowSpeedup".                 #
#==============================================================================#
#                    Please give credit when using this.                       #
#==============================================================================#

PluginManager.register({
  name: "Better Fast-forward Mode",
  version: "1.1",
  credits: "Marin",
  link: "https://reliccastle.com/resources/151/"
})

#==================================
# Modded - Infinite Showdown
#==================================
SPEEDUP_STAGES = [1,2,3,5]

def pbAllowSpeedup
  $CanToggle = true
end

def pbDisallowSpeedup
  $CanToggle = false
end

def updateTitle
  auto_text = $AutoBattler ? " | Auto-Battle (ON)" : ""
  loop_text = $LoopBattle ? " | Loop Battle (ON)" : ""
  speed_display = SPEEDUP_STAGES[$GameSpeed].to_s 
  title = "Infinite Showdown | Version: #{Settings::GAME_VERSION_NUMBER} | Speed: x#{speed_display}" + auto_text + loop_text
  System.set_window_title(title)
end


# Default game speed.
$GameSpeed = 0
$LoopBattle = false
$AutoBattler = false
if $PokemonSystem && $PokemonSystem.autobattler
  $AutoBattler = $PokemonSystem.autobattler == 1
else
  updateTitle
end
$frame = 0
$CanToggle = true

module Graphics
  class << Graphics
    alias fast_forward_update update
  end

  def self.update
    if $PokemonSystem
      if Input.trigger?(Input::JUMPUP) && $PokemonSystem.autobattler
        $AutoBattler = !$AutoBattler
        $PokemonSystem.autobattler = $AutoBattler ? 1 : 0
        updateTitle
      end
      
      if Input.trigger?(Input::JUMPDOWN) && $PokemonSystem.sb_loopinput
        $LoopBattle = !$LoopBattle
        $PokemonSystem.sb_loopinput = $LoopBattle ? 1 : 0
        updateTitle
      end
    end

    handleGameSpeedInput if $CanToggle
    handleFrameUpdate
  end

  def self.handleGameSpeedInput
    if Input.trigger?(Input::AUX1)
      $GameSpeed += 1
      $GameSpeed = 0 if $GameSpeed >= SPEEDUP_STAGES.size
      updateTitle
    end

    if Input.trigger?(Input::AUX2)
      # debug or file related checks
    end
  end
  
  def self.handleFrameUpdate
    $frame += 1
    return unless $frame % SPEEDUP_STAGES[$GameSpeed] == 0
    fast_forward_update
    $frame = 0
  end
end
