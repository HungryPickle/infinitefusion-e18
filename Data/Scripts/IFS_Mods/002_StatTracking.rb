#===============================================================================
# Using a module here to avoid naming conflicts
# when spread across multiple classes/scripts.
#===============================================================================
#==================================
# Trapstarrs Stat Tracker Module
#==================================
module SDStatTracker
  def show_stat_tracker?
    if ($PokemonSystem.sd_stat_tracker && $PokemonSystem.sd_stat_tracker == 1 &&
      $PokemonSystem.sb_loopinput && $PokemonSystem.sb_loopinput == 1 &&
      $PokemonSystem.autobattler && $PokemonSystem.autobattler != 0)
      return true
	  else
	    return false
    end
  end
end

#===============================================================================
# Trapstarrs Stat Tracker - Battle Display
#===============================================================================
class PokeBattle_Scene
  include SDStatTracker
  def update_stat_display
    if show_stat_tracker?
      # Create or update the text object
      if @win_display_text.nil?
        @win_display_text = Sprite.new(@viewport)
        @win_display_text.bitmap = Bitmap.new(Graphics.width, 24)
        @win_display_text.z = 9999
        @win_display_text.y = Graphics.height - 96
      end
      @win_display_text.bitmap.clear

      # Set the font color based on dark mode setting
      if $PokemonSystem.darkmode && $PokemonSystem.darkmode == 1
        @win_display_text.bitmap.font.color.set(225, 225, 225)  # Set to a lighter gray color for dark mode
      else
        @win_display_text.bitmap.font.color.set(40, 40, 44)  # Default to a black color
      end

      # Update the text
      text = "[ Player: #{$PokemonSystem.player_wins} | Enemy: #{$PokemonSystem.enemy_wins} ]"
      @win_display_text.bitmap.clear
      rect = @win_display_text.bitmap.rect
      @win_display_text.bitmap.draw_text(rect.x, rect.y, rect.width, rect.height, text, 1)
    else
      # Dispose of the text object if it exists and the condition isn't met
      unless @win_display_text.nil?
        @win_display_text.dispose
        @win_display_text = nil
      end
    end
  end

  def pbGraphicsUpdate
    # Update lineup animations
    if @animations.length>0
      shouldCompact = false
      @animations.each_with_index do |a,i|
        a.update
        if a.animDone?
          a.dispose
          @animations[i] = nil
          shouldCompact = true
        end
      end
      @animations.compact! if shouldCompact
    end
    # Update other graphics
    @sprites["battle_bg"].update if @sprites["battle_bg"].respond_to?("update")
    Graphics.update
    @frameCounter += 1
    @frameCounter = @frameCounter%(Graphics.frame_rate*12/20)
#==================================
	update_stat_display # Trapstarr - Stat Tracker
#==================================
  end
end
  
#===============================================================================