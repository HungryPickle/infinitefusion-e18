#===============================================================================
#
#===============================================================================
class PokemonSystem
  attr_accessor :textspeed
  attr_accessor :battlescene
  attr_accessor :battlestyle
  attr_accessor :frame
  attr_accessor :textskin
  attr_accessor :screensize
  attr_accessor :language
  attr_accessor :runstyle
  attr_accessor :bgmvolume
  attr_accessor :sevolume
  attr_accessor :textinput
  attr_accessor :quicksurf
  attr_accessor :battle_type
  attr_accessor :download_sprites
#==================================
# Modded Values - Infinite Showdown
#==================================
  attr_accessor :autobattler
  attr_accessor :typedisplay
  attr_accessor :battlegui
  attr_accessor :darkmode
  attr_accessor :improved_pokedex
  attr_accessor :recover_consumables
  attr_accessor :expall_redist
  # attr_accessor :shiny_trainer_pkmn
  
  attr_accessor :Sylvibigicons

  attr_accessor :sd_stat_tracker # refactoring/depreciated soon
  attr_accessor :player_wins # refactoring/depreciated soon
  attr_accessor :enemy_wins # refactoring/depreciated soon
  attr_accessor :sb_loopinput # refactoring/depreciated soon
  attr_accessor :sb_loopbreaker # refactoring/depreciated soon
  
  attr_accessor :sd_nomoney
  # attr_accessor :sd_noexp
#==================================
# Modded - Infinite Showdown - Getting Depreciated/Needs Refactor
#==================================
  attr_accessor :sb_randomizeteam
  attr_accessor :sb_team_size
  attr_accessor :sb_select
  attr_accessor :sb_level
  attr_accessor :sb_playerfolder
  
  attr_accessor :savefolder

#==================================
  
  def initialize
    @textspeed = 1 # Text speed (0=slow, 1=normal, 2=fast)
    @battlescene = 0 # Battle effects (animations) (0=on, 1=off)
    @battlestyle = 0 # Battle style (0=switch, 1=set)
    @frame = 0 # Default window frame (see also Settings::MENU_WINDOWSKINS)
    @textskin = 0 # Speech frame
    @screensize = (Settings::SCREEN_SCALE * 2).floor - 1 # 0=half size, 1=full size, 2=full-and-a-half size, 3=double size
    @language = 0 # Language (see also Settings::LANGUAGES in script PokemonSystem)
    @runstyle = 0 # Default movement speed (0=walk, 1=run)
    @bgmvolume = 100 # Volume of background music and ME
    @sevolume = 100 # Volume of sound effects
    @textinput = 1 # Text input mode (0=cursor, 1=keyboard)
    @quicksurf = 0
    @battle_type = 0
    @download_sprites = 0
#==================================
# Modded - Infinite Showdown
#==================================
    @autobattler = 0
    @typedisplay = 0
    @battlegui = 0
    @darkmode = 0
    @improved_pokedex = 0
    @recover_consumables = 0
    @expall_redist = 0
    # @shiny_trainer_pkmn = 0
	
    @Sylvibigicons = 0
	
#==================================
# Modded - Getting Depreciated/Needs Refactor
#==================================
	@sd_stat_tracker = 0
	@player_wins = 0
    @enemy_wins = 0
    @sb_loopinput = 0
    @sb_loopbreaker = 0
	
    # @unfusetraded = 0
    @sb_randomizeteam = 0
    @sb_team_size = 0
    @sb_select = 0
    @sb_playerfolder = @sb_randomizeteam
    @sb_level = 0
    @savefolder = 0
#==================================
	
  end
end

#===============================================================================
#
#===============================================================================
module PropertyMixin
  def get
    (@getProc) ? @getProc.call : nil
  end

  def set(value)
    @setProc.call(value) if @setProc
  end
end

class Option
  attr_reader :description

  def initialize(description)
    @description = description
  end
end

#===============================================================================
#
#===============================================================================
class EnumOption < Option
  include PropertyMixin
  attr_reader :values
  attr_reader :name

  def initialize(name, options, getProc, setProc, description = "")
    super(description)
    @name = name
    @values = options
    @getProc = getProc
    @setProc = setProc
  end

  def next(current)
    index = current + 1
    index = @values.length - 1 if index > @values.length - 1
    return index
  end

  def prev(current)
    index = current - 1
    index = 0 if index < 0
    return index
  end
end

#===============================================================================
#
#===============================================================================
class EnumOption2
  include PropertyMixin
  attr_reader :values
  attr_reader :name

  def initialize(name, options, getProc, setProc)
    @name = name
    @values = options
    @getProc = getProc
    @setProc = setProc
  end

  def next(current)
    index = current + 1
    index = @values.length - 1 if index > @values.length - 1
    return index
  end

  def prev(current)
    index = current - 1
    index = 0 if index < 0
    return index
  end
end

#===============================================================================
#
#===============================================================================
class NumberOption
  include PropertyMixin
  attr_reader :name
  attr_reader :optstart
  attr_reader :optend

  def initialize(name, optstart, optend, getProc, setProc)
    @name = name
    @optstart = optstart
    @optend = optend
    @getProc = getProc
    @setProc = setProc
  end

  def next(current)
    index = current + @optstart
    index += 1
    index = @optstart if index > @optend
    return index - @optstart
  end

  def prev(current)
    index = current + @optstart
    index -= 1
    index = @optend if index < @optstart
    return index - @optstart
  end
end

#===============================================================================
#
#===============================================================================
class SliderOption < Option
  include PropertyMixin
  attr_reader :name
  attr_reader :optstart
  attr_reader :optend

  def initialize(name, optstart, optend, optinterval, getProc, setProc, description = "")
    super(description)
    @name = name
    @optstart = optstart
    @optend = optend
    @optinterval = optinterval
    @getProc = getProc
    @setProc = setProc
  end

  def next(current)
    index = current + @optstart
    index += @optinterval
    index = @optend if index > @optend
    return index - @optstart
  end

  def prev(current)
    index = current + @optstart
    index -= @optinterval
    index = @optstart if index < @optstart
    return index - @optstart
  end
end

#===============================================================================
# Modded - Infinite Showdown
#===============================================================================
class ButtonOption < Option
  include PropertyMixin
  attr_reader :name
  
  def initialize(name, selectProc, description = "")
    super(description)
    @name = name
    @selectProc = selectProc
  end

  def next(current)
    self.activate
    return current
  end

  def prev(current)
    return current
  end

  def activate
    @selectProc.call
  end
end

#===============================================================================
# Main options list
#===============================================================================
class Window_PokemonOption < Window_DrawableCommand
  attr_reader :mustUpdateOptions
  attr_reader :mustUpdateDescription
  attr_reader :selected_position

  def initialize(options, x, y, width, height)
    @previous_Index = 0
    @options = options
    @nameBaseColor = Color.new(24 * 8, 15 * 8, 0)
    @nameShadowColor = Color.new(31 * 8, 22 * 8, 10 * 8)
    @selBaseColor = Color.new(31 * 8, 6 * 8, 3 * 8)
    @selShadowColor = Color.new(31 * 8, 17 * 8, 16 * 8)
    @optvalues = []
    @mustUpdateOptions = false
    @mustUpdateDescription = false
    @selected_position = 0
    @allow_arrows_jump=false
    for i in 0...@options.length
      @optvalues[i] = 0
    end
    super(x, y, width, height)
  end

  def changedPosition
    @mustUpdateDescription = true
    super
  end

  def descriptionUpdated
    @mustUpdateDescription = false
  end

  def nameBaseColor=(value)
    @nameBaseColor = value
  end

  def nameShadowColor=(value)
    @nameShadowColor = value
  end

  def [](i)
    return @optvalues[i]
  end

  def []=(i, value)
    @optvalues[i] = value
    refresh
  end

  def setValueNoRefresh(i, value)
    @optvalues[i] = value
  end

  def itemCount
    return @options.length + 1
  end

  def dont_draw_item(index)
    return false
  end

  def drawItem(index, _count, rect)
    return if dont_draw_item(index)
    rect = drawCursor(index, rect)
    optionname = (index == @options.length) ? _INTL("Confirm") : @options[index].name
    optionwidth = rect.width * 9 / 20
#==================================
# Modded - Infinite Showdown
#==================================
    if @options[index] && @options[index].is_a?(ButtonOption)
      optionwidth = rect.width
    end
#==================================
    pbDrawShadowText(self.contents, rect.x, rect.y, optionwidth, rect.height, optionname,
                     @nameBaseColor, @nameShadowColor)
    return if index == @options.length
    if @options[index].is_a?(EnumOption)
      if @options[index].values.length > 1
        totalwidth = 0
        for value in @options[index].values
          totalwidth += self.contents.text_size(value).width
        end
        spacing = (optionwidth - totalwidth) / (@options[index].values.length - 1)
        spacing = 0 if spacing < 0
        xpos = optionwidth + rect.x
        ivalue = 0
        for value in @options[index].values
          pbDrawShadowText(self.contents, xpos, rect.y, optionwidth, rect.height, value,
                           (ivalue == self[index]) ? @selBaseColor : self.baseColor,
                           (ivalue == self[index]) ? @selShadowColor : self.shadowColor
          )
          xpos += self.contents.text_size(value).width
          xpos += spacing
          ivalue += 1
        end
      else
        pbDrawShadowText(self.contents, rect.x + optionwidth, rect.y, optionwidth, rect.height,
                         optionname, self.baseColor, self.shadowColor)
      end
    elsif @options[index].is_a?(NumberOption)
      value = _INTL("Type {1}/{2}", @options[index].optstart + self[index],
                    @options[index].optend - @options[index].optstart + 1)
      xpos = optionwidth + rect.x
      pbDrawShadowText(self.contents, xpos, rect.y, optionwidth, rect.height, value,
                       @selBaseColor, @selShadowColor)
    elsif @options[index].is_a?(SliderOption)
      value = sprintf(" %d", @options[index].optend)
      sliderlength = optionwidth - self.contents.text_size(value).width
      xpos = optionwidth + rect.x
      self.contents.fill_rect(xpos, rect.y - 2 + rect.height / 2,
                              optionwidth - self.contents.text_size(value).width, 4, self.baseColor)
      self.contents.fill_rect(
        xpos + (sliderlength - 8) * (@options[index].optstart + self[index]) / @options[index].optend,
        rect.y - 8 + rect.height / 2,
        8, 16, @selBaseColor)
      value = sprintf("%d", @options[index].optstart + self[index])
      xpos += optionwidth - self.contents.text_size(value).width
      pbDrawShadowText(self.contents, xpos, rect.y, optionwidth, rect.height, value,
                       @selBaseColor, @selShadowColor)
#==================================
# Modded - Infinite Fusion
#==================================
    elsif @options[index].is_a?(ButtonOption)
      # Print no value
#==================================
    else
      value = @options[index].values[self[index]]
      xpos = optionwidth + rect.x
      pbDrawShadowText(self.contents, xpos, rect.y, optionwidth, rect.height, value,
                       @selBaseColor, @selShadowColor)
    end
  end

  def update
    oldindex = self.index
    @mustUpdateOptions = false
    super
    dorefresh = (self.index != oldindex)
    if self.active && self.index < @options.length
      if Input.repeat?(Input::LEFT)
        self[self.index] = @options[self.index].prev(self[self.index])
        dorefresh =
          @selected_position = self[self.index]
        @mustUpdateOptions = true
        @mustUpdateDescription = true
      elsif Input.repeat?(Input::RIGHT)
        self[self.index] = @options[self.index].next(self[self.index])
        dorefresh = true
        @selected_position = self[self.index]
        @mustUpdateOptions = true
        @mustUpdateDescription = true
#==================================
# Modded - Infinite Fusion
#==================================
      elsif Input.trigger?(Input::USE)
        if @options[self.index].is_a?(ButtonOption)
          @options[self.index].activate
          dorefresh = true
          @mustUpdateOptions = true
          @mustUpdateDescription = true
        end
#==================================
      end
    end
    refresh if dorefresh
  end
end

#===============================================================================
# Options main screen
#===============================================================================
class PokemonOption_Scene
  def getDefaultDescription
    return _INTL("Speech frame {1}.", 1 + $PokemonSystem.textskin)
  end

  def pbUpdate
    pbUpdateSpriteHash(@sprites)
    if @sprites["option"].mustUpdateDescription
      updateDescription(@sprites["option"].index)
      @sprites["option"].descriptionUpdated
    end
  end

  def initialize
    @autosave_menu = false
  end

  def initUIElements
    @sprites["title"] = Window_UnformattedTextPokemon.newWithSize(
      _INTL("Options"), 0, 0, Graphics.width, 64, @viewport)
    @sprites["textbox"] = pbCreateMessageWindow
    @sprites["textbox"].text = _INTL("Speech frame {1}.", 1 + $PokemonSystem.textskin)
    @sprites["textbox"].letterbyletter = false
    pbSetSystemFont(@sprites["textbox"].contents)
  end

  def pbStartScene(inloadscreen = false)
    @sprites = {}
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999
    initUIElements
    # These are the different options in the game. To add an option, define a
    # setter and a getter for that option. To delete an option, comment it out
    # or delete it. The game's options may be placed in any order.
    @PokemonOptions = pbGetOptions(inloadscreen)
    @PokemonOptions = pbAddOnOptions(@PokemonOptions)
    @sprites["option"] = initOptionsWindow
    # Get the values of each option
    for i in 0...@PokemonOptions.length
      @sprites["option"].setValueNoRefresh(i, (@PokemonOptions[i].get || 0))
    end
    @sprites["option"].refresh
    pbDeactivateWindows(@sprites)
    pbFadeInAndShow(@sprites) { pbUpdate }
  end

  def initOptionsWindow
    optionsWindow = Window_PokemonOption.new(@PokemonOptions, 0,
                                             @sprites["title"].height, Graphics.width,
                                             Graphics.height - @sprites["title"].height - @sprites["textbox"].height)
    optionsWindow.viewport = @viewport
    optionsWindow.visible = true
    return optionsWindow
  end

  def updateDescription(index)
    index = 0 if !index
    begin
      horizontal_position = @sprites["option"].selected_position
      optionDescription = @PokemonOptions[index].description
      if optionDescription.is_a?(Array)
        if horizontal_position < optionDescription.size
          new_description = optionDescription[horizontal_position]
        else
          new_description = getDefaultDescription
        end
      else
        new_description = optionDescription
      end

      new_description = getDefaultDescription if new_description == ""
      @sprites["textbox"].text = _INTL(new_description)
    rescue
      @sprites["textbox"].text = getDefaultDescription
    end
  end

  def pbGetOptions(inloadscreen = false)
    options = []

    options << SliderOption.new(_INTL("Music Volume"), 0, 100, 5,
                                proc { $PokemonSystem.bgmvolume },
                                proc { |value|
                                  if $PokemonSystem.bgmvolume != value
                                    $PokemonSystem.bgmvolume = value
                                    if $game_system.playing_bgm != nil && !inloadscreen
                                      playingBGM = $game_system.getPlayingBGM
                                      $game_system.bgm_pause
                                      $game_system.bgm_resume(playingBGM)
                                    end
                                  end
                                }, "Sets the volume for background music"
    )

    options << SliderOption.new(_INTL("SE Volume"), 0, 100, 5,
                                proc { $PokemonSystem.sevolume },
                                proc { |value|
                                  if $PokemonSystem.sevolume != value
                                    $PokemonSystem.sevolume = value
                                    if $game_system.playing_bgs != nil
                                      $game_system.playing_bgs.volume = value
                                      playingBGS = $game_system.getPlayingBGS
                                      $game_system.bgs_pause
                                      $game_system.bgs_resume(playingBGS)
                                    end
                                    pbPlayCursorSE
                                  end
                                }, "Sets the volume for sound effects"
    )
    options << EnumOption.new(_INTL("Text Speed"), [_INTL("Normal"), _INTL("Fast")],
                              proc { $PokemonSystem.textspeed },
                              proc { |value|
                                $PokemonSystem.textspeed = value
                                MessageConfig.pbSetTextSpeed(MessageConfig.pbSettingToTextSpeed(value))
                              }, "Sets the speed at which the text is displayed"
    )
    # if $game_switches && ($game_switches[SWITCH_NEW_GAME_PLUS] || $game_switches[SWITCH_BEAT_THE_LEAGUE]) #beat the league
    #   options << EnumOption.new(_INTL("Text Speed"), [_INTL("Normal"), _INTL("Fast"), _INTL("Instant")],
    #                             proc { $PokemonSystem.textspeed },
    #                             proc { |value|
    #                               $PokemonSystem.textspeed = value
    #                               MessageConfig.pbSetTextSpeed(MessageConfig.pbSettingToTextSpeed(value))
    #                             }, "Sets the speed at which the text is displayed"
    #   )
    # else
    #   options << EnumOption.new(_INTL("Text Speed"), [_INTL("Normal"), _INTL("Fast")],
    #                             proc { $PokemonSystem.textspeed },
    #                             proc { |value|
    #                               $PokemonSystem.textspeed = value
    #                               MessageConfig.pbSetTextSpeed(MessageConfig.pbSettingToTextSpeed(value))
    #                             }, "Sets the speed at which the text is displayed"
    #   )
    # end
    options <<
      EnumOption.new(_INTL("Download sprites"), [_INTL("On"), _INTL("Off")],
                     proc { $PokemonSystem.download_sprites},
                     proc { |value|
                       $PokemonSystem.download_sprites = value
                     },
                     "Automatically download custom sprites from the internet"
      )

    options << EnumOption.new(_INTL("Battle Effects"), [_INTL("On"), _INTL("Off")],
    proc { $PokemonSystem.battlescene },
    proc { |value| $PokemonSystem.battlescene = value },
    "Display move animations in battles"
    )

    options << EnumOption.new(_INTL("Default Movement"), [_INTL("Walking"), _INTL("Running")],
                              proc { $PokemonSystem.runstyle },
                              proc { |value| $PokemonSystem.runstyle = value },
                              ["Default to walking when not holding the Run key",
                               "Default to running when not holding the Run key"]
    )

    options << NumberOption.new(_INTL("Speech Frame"), 1, Settings::SPEECH_WINDOWSKINS.length,
                                proc { $PokemonSystem.textskin },
                                proc { |value|
                                  $PokemonSystem.textskin = value
                                  MessageConfig.pbSetSpeechFrame("Graphics/Windowskins/" + Settings::SPEECH_WINDOWSKINS[value])
                                }
    )

    options << EnumOption.new(_INTL("Text Entry"), [_INTL("Cursor"), _INTL("Keyboard")],
                              proc { $PokemonSystem.textinput },
                              proc { |value| $PokemonSystem.textinput = value },
                              ["Enter text by selecting letters on the screen",
                               "Enter text by typing on the keyboard"]
    )

    options << EnumOption.new(_INTL("Screen Size"), [_INTL("S"), _INTL("M"), _INTL("L"), _INTL("XL"), _INTL("Full")],
                              proc { [$PokemonSystem.screensize, 4].min },
                              proc { |value|
                                if $PokemonSystem.screensize != value
                                  $PokemonSystem.screensize = value
                                  pbSetResizeFactor($PokemonSystem.screensize)
                                end
                              }, "Sets the size of the screen"
    )
    options << EnumOption.new(_INTL("Quick Field Moves"), [_INTL("Off"), _INTL("On")],
                              proc { $PokemonSystem.quicksurf },
                              proc { |value| $PokemonSystem.quicksurf = value },
                              "Use Field Moves quicker"
    )

    if $scene && $scene.is_a?(Scene_Map)
      options.concat(pbGetInGameOptions())
    end

    options << ButtonOption.new(_INTL("Infinite Showdown Options"),
                              proc {
                                @showdown_menu = true
                                openShowdownMenu()
                              }, "Configure IFS options"
    )
    return options
  end

  def pbGetInGameOptions()
    options = []

    if $game_switches
      options <<
        EnumOption.new(_INTL("Autosave"), [_INTL("On"), _INTL("Off")],
                       proc { $game_switches[AUTOSAVE_ENABLED_SWITCH] ? 0 : 1 },
                       proc { |value|
                         if !$game_switches[AUTOSAVE_ENABLED_SWITCH] && value == 0
                           @autosave_menu = true
                           openAutosaveMenu()
                         end
                         $game_switches[AUTOSAVE_ENABLED_SWITCH] = value == 0
                       },
                       "Automatically saves when healing at Pokémon centers"
        )
    end

    if $game_switches && ($game_switches[SWITCH_NEW_GAME_PLUS] || $game_switches[SWITCH_BEAT_THE_LEAGUE]) #beat the league
      options <<
        EnumOption.new(_INTL("Battle type"), [_INTL("1v1"), _INTL("2v2"), _INTL("3v3")],
                       proc { $PokemonSystem.battle_type },
                       proc { |value|
                         if value == 0
                           $game_variables[VAR_DEFAULT_BATTLE_TYPE] = [1, 1]
                         elsif value == 1
                           $game_variables[VAR_DEFAULT_BATTLE_TYPE] = [2, 2]
                         elsif value == 2
                           $game_variables[VAR_DEFAULT_BATTLE_TYPE] = [3, 3]
                         else
                           $game_variables[VAR_DEFAULT_BATTLE_TYPE] = [1, 1]
                         end
                         $PokemonSystem.battle_type = value
                       }, "Sets the number of Pokémon sent out in battles (when possible)"
        )
    end
    return options
  end

  def openShowdownMenu()
    return if !@showdown_menu
    pbFadeOutIn {
      scene = ShowdownOptionsScene.new
      screen = PokemonOptionScreen.new(scene)
      screen.pbStartScreen
    }
    @showdown_menu = false
  end

  def pbAddOnOptions(options)
    return options
  end

  def openAutosaveMenu()
    return if !@autosave_menu
    pbFadeOutIn {
      scene = AutosaveOptionsScene.new
      screen = PokemonOptionScreen.new(scene)
      screen.pbStartScreen
    }
    @autosave_menu = false
  end

  def pbOptions
    oldSystemSkin = $PokemonSystem.frame # Menu
    oldTextSkin = $PokemonSystem.textskin # Speech
    pbActivateWindow(@sprites, "option") {
      loop do
        Graphics.update
        Input.update
        pbUpdate
        if @sprites["option"].mustUpdateOptions
          # Set the values of each option
          for i in 0...@PokemonOptions.length
            @PokemonOptions[i].set(@sprites["option"][i])
          end
          if $PokemonSystem.textskin != oldTextSkin
            @sprites["textbox"].setSkin(MessageConfig.pbGetSpeechFrame())
            @sprites["textbox"].text = _INTL("Speech frame {1}.", 1 + $PokemonSystem.textskin)
            oldTextSkin = $PokemonSystem.textskin
          end
          if $PokemonSystem.frame != oldSystemSkin
            @sprites["title"].setSkin(MessageConfig.pbGetSystemFrame())
            @sprites["option"].setSkin(MessageConfig.pbGetSystemFrame())
            oldSystemSkin = $PokemonSystem.frame
          end
        end
        if Input.trigger?(Input::BACK)
          break
        elsif Input.trigger?(Input::USE)
          break if isConfirmedOnKeyPress
        end
      end
    }
  end

  def isConfirmedOnKeyPress
    return @sprites["option"].index == @PokemonOptions.length
  end

  def pbEndScene
    pbPlayCloseMenuSE
    pbFadeOutAndHide(@sprites) { pbUpdate }
    # Set the values of each option
    for i in 0...@PokemonOptions.length
      @PokemonOptions[i].set(@sprites["option"][i])
    end
    pbDisposeMessageWindow(@sprites["textbox"])
    pbDisposeSpriteHash(@sprites)
    pbRefreshSceneMap
    @viewport.dispose
  end
end

#===============================================================================
#
#===============================================================================
class PokemonOptionScreen
  def initialize(scene)
    @scene = scene
  end

  def pbStartScreen(inloadscreen = false)
    @scene.pbStartScene(inloadscreen)
    @scene.pbOptions
    @scene.pbEndScene
  end
end

#===============================================================================
#
#===============================================================================
class ShowdownOptionsScene < PokemonOption_Scene
  def initialize
    @changedColor = false
  end

  def pbStartScene(inloadscreen = false)
    super
    @sprites["option"].nameBaseColor = Color.new(35, 130, 200)
    @sprites["option"].nameShadowColor = Color.new(20, 75, 115)
    @changedColor = true
    for i in 0...@PokemonOptions.length
      @sprites["option"][i] = (@PokemonOptions[i].get || 0)
    end
    @sprites["title"]=Window_UnformattedTextPokemon.newWithSize(
      _INTL("Infinite Showdown options"),0,0,Graphics.width,64,@viewport)
    @sprites["textbox"].text=_INTL("Configure Infinite Showdown Options")


    pbFadeInAndShow(@sprites) { pbUpdate }
  end

  def pbFadeInAndShow(sprites, visiblesprites = nil)
    return if !@changedColor
    super
  end

  def pbGetOptions(inloadscreen = false)
    options = []
    options << ButtonOption.new(_INTL("Graphics"),
      proc {
        @showdown_menu = true
        openShowdownMenu1()
      }, "Configure Graphics Settings"
    )
    options << ButtonOption.new(_INTL("QoL/Others"),
      proc {
        @showdown_menu = true
        openShowdownMenu2()
      }, "Customize Quality of Life options"
    )
    options << ButtonOption.new(_INTL("Showdown Options"),
      proc {
        @showdown_menu = true
        openShowdownMenu3()
      }, "Configure Showdown Battler Options"
    )
    return options
  end

  def openShowdownMenu1()
    return if !@showdown_menu
    pbFadeOutIn {
      scene = ShowdownOptSc_1.new
      screen = PokemonOptionScreen.new(scene)
      screen.pbStartScreen
    }
    @showdown_menu = false
  end
  def openShowdownMenu2()
    return if !@showdown_menu
    pbFadeOutIn {
      scene = ShowdownOptSc_2.new
      screen = PokemonOptionScreen.new(scene)
      screen.pbStartScreen
    }
    @showdown_menu = false
  end
  def openShowdownMenu3()
    return if !@showdown_menu
    pbFadeOutIn {
      scene = ShowdownOptSc_3.new
      screen = PokemonOptionScreen.new(scene)
      screen.pbStartScreen
    }
    @showdown_menu = false
  end
end


#===============================================================================
# GRAPHICS
#===============================================================================
class ShowdownOptSc_1 < PokemonOption_Scene
  def initialize
    @changedColor = false
  end

  def pbStartScene(inloadscreen = false)
    super
    @sprites["option"].nameBaseColor = Color.new(35, 200, 35)
    @sprites["option"].nameShadowColor = Color.new(20, 115, 20)
    @changedColor = true
    for i in 0...@PokemonOptions.length
      @sprites["option"][i] = (@PokemonOptions[i].get || 0)
    end
    @sprites["title"]=Window_UnformattedTextPokemon.newWithSize(
      _INTL("Graphics settings"),0,0,Graphics.width,64,@viewport)
    @sprites["textbox"].text=_INTL("Configure Graphics Settings")


    pbFadeInAndShow(@sprites) { pbUpdate }
  end

  def pbFadeInAndShow(sprites, visiblesprites = nil)
    return if !@changedColor
    super
  end

  def pbGetOptions(inloadscreen = false)
    options = []

    options << EnumOption.new(_INTL("Type Display"), [_INTL("Off"), _INTL("Icons"), _INTL("TCG"), _INTL("Sqr"), _INTL("Txt")],
                      proc { $PokemonSystem.typedisplay },
                      proc { |value| $PokemonSystem.typedisplay = value },
                      ["Don't draw the type indicator in battle",
                      "Draws handmade custom type icons in battle | Artwork by Lolpy1",
                      "Draws TCG themed type icons in battle | by Trapstarr",
                      "Draws the square type icons in battle | Triple Fusion artwork by Lolpy1",
                      "Draws the text type display in battle | by Trapstarr"]
    )

    options << EnumOption.new(_INTL("Swap Battle Graphics"), [_INTL("Off"), _INTL("Type 1"), _INTL("Type 2")],
                      proc { $PokemonSystem.battlegui },
                      proc { |value| $PokemonSystem.battlegui = value },
                      ["This feature is a work in progress, more to come soon",
                      "Swaps the HP/Exp bar to v1 | created by Mirasein",
                      "Swaps the HP/Exp bar to v2 | created by Mirasein"]
   )
   
    options << EnumOption.new(_INTL("Dark Mode"), [_INTL("Off"), _INTL("On")],
                      proc { $PokemonSystem.darkmode },
                      proc { |value| $PokemonSystem.darkmode = value },
                      ["Default UI",
                      "Swaps the messagebox graphics during battle"]
    )
	
    options << EnumOption.new(_INTL("Big Pokémon Icons"), [_INTL("Off"), _INTL("Limited"), _INTL("All")],
                      proc { $PokemonSystem.Sylvibigicons },
                      proc { |value| $PokemonSystem.Sylvibigicons = value },
                      ["Pokémon will use their small box sprites for icons",
                      "Pokémon icons will use their full-size battle sprites (except in boxes) | By Sylvi",
                      "Pokémon icons will use their full-size battle sprites | By Sylvi"]
    )

    return options
  end
end


#===============================================================================
# QOL/OTHERS
#===============================================================================
class ShowdownOptSc_2 < PokemonOption_Scene
  def initialize
    @changedColor = false
  end

  def pbStartScene(inloadscreen = false)
    super
    @sprites["option"].nameBaseColor = Color.new(200, 35, 35)
    @sprites["option"].nameShadowColor = Color.new(115, 20, 20)
    @changedColor = true
    for i in 0...@PokemonOptions.length
      @sprites["option"][i] = (@PokemonOptions[i].get || 0)
    end
    @sprites["title"]=Window_UnformattedTextPokemon.newWithSize(
      _INTL("QoL Options"),0,0,Graphics.width,64,@viewport)
    @sprites["textbox"].text=_INTL("Configure Quality of Life options")


    pbFadeInAndShow(@sprites) { pbUpdate }
  end

  def pbFadeInAndShow(sprites, visiblesprites = nil)
    return if !@changedColor
    super
  end

  def pbGetOptions(inloadscreen = false)
    options = []

    if $scene && $scene.is_a?(Scene_Map)
      options.concat(pbGetInGameOptions())
    end
    return options
  end
  
  def pbGetInGameOptions()
    options = []
    
    options << EnumOption.new(_INTL("Improved Pokedex"), [_INTL("Off"), _INTL("On")],
                      proc { $PokemonSystem.improved_pokedex },
                      proc { |value| $PokemonSystem.improved_pokedex = value },
                      ["Don't use the Improved Pokedex",
                      "Registers a fusions base Pokemon to the Pokedex when catching/evolving"]
    )

    options << EnumOption.new(_INTL("Recover Consumables"), [_INTL("Off"), _INTL("On")],
                      proc { $PokemonSystem.recover_consumables },
                      proc { |value| $PokemonSystem.recover_consumables = value },
                      ["Don't recover consumable items after battle",
                      "Recover consumable items after battle"]
    )

    options << SliderOption.new(_INTL("ExpAll Redistribution"), 0, 10, 1,
                      proc { $PokemonSystem.expall_redist },
                      proc { |value| $PokemonSystem.expall_redist = value },
                      "0 = Off, 10 = Max | Redistributes total exp from expAll to lower level pokemon"
    )

    # options << EnumOption.new(_INTL("Shiny Trainer Pokemon"), [_INTL("Off"), _INTL("Ace"), _INTL("All")],
                      # proc { $PokemonSystem.shiny_trainer_pkmn },
                      # proc { |value| $PokemonSystem.shiny_trainer_pkmn = value },
                      # ["Trainer pokemon will have their normal shiny rates",
                      # "Draws the opposing trainers ace pokemon as shiny",
                      # "All trainers pokemon in their party will be shiny"]
    # )
    return options
  end
end

#===============================================================================
# SHOWDOWN SETTINGS
#===============================================================================
class ShowdownOptSc_3 < PokemonOption_Scene
  def initialize
    @changedColor = false
  end

  def pbStartScene(inloadscreen = false)
    super
    @sprites["option"].nameBaseColor = Color.new(200, 35, 200)
    @sprites["option"].nameShadowColor = Color.new(115, 20, 115)
    @changedColor = true
    for i in 0...@PokemonOptions.length
      @sprites["option"][i] = (@PokemonOptions[i].get || 0)
    end
    @sprites["title"]=Window_UnformattedTextPokemon.newWithSize(
      _INTL("Showdown Settings"),0,0,Graphics.width,64,@viewport)
    @sprites["textbox"].text=_INTL("Configure Showdown Options")


    pbFadeInAndShow(@sprites) { pbUpdate }
  end

  def pbFadeInAndShow(sprites, visiblesprites = nil)
    return if !@changedColor
    super
  end

  def pbGetOptions(inloadscreen = false)
    options = []

    if $scene && $scene.is_a?(Scene_Map)
      options.concat(pbGetInGameOptions())
    else
      options << ButtonOption.new(_INTL("### EMPTY ###"),
      proc {}
      )
    end
    return options
  end

  def pbGetInGameOptions()
    options = []
	
    options << ButtonOption.new(_INTL("            ### Showdown Battler ###"),
                      proc {},
                      ["Showdown battle keybind = 'S' | Auto-Battler keybind = 'A'"]
    )
    options << EnumOption.new(_INTL("Auto-Battler"), [_INTL("Off"), _INTL("On")],
                      proc { $PokemonSystem.autobattler },
                      proc { |value| $PokemonSystem.autobattler = value },
                      ["You fight your own battles",
                      "Allows Trapstarr to take control of your pokemon"]
    )
    options << EnumOption.new(_INTL("Level"), [_INTL("Default"), _INTL("5"), _INTL("50"), _INTL("100")],
                      proc { $PokemonSystem.sb_level },
                      proc { |value| $PokemonSystem.sb_level = value },
                      ["Pokemons keep their original level",
                        "Pokemons are level 5",
                        "Pokemons are level 50",
                        "Pokemons are level 100"]
    )
    options << EnumOption.new(_INTL("Team Size"), [_INTL("1"), _INTL("2"), _INTL("3"), _INTL("4"), _INTL("5"), _INTL("6")],
                      proc { $PokemonSystem.sb_team_size },
                      proc { |value| $PokemonSystem.sb_team_size = value },
                      ["1 Pokemon",
                        "2 Pokemon",
                        "3 Pokemon",
                        "4 Pokemon",
                        "5 Pokemon",
                        "6 Pokemon"]
    )
    options << EnumOption.new(_INTL("Player Team"), [_INTL("Party"), _INTL("Folder")],
                      proc { $PokemonSystem.sb_randomizeteam },
                      proc { |value| $PokemonSystem.sb_randomizeteam = value },
                      ["Battle using your current party",
                      "Choose your party from the ExportedPokemons folder"]
    )
    options << EnumOption.new(_INTL("Team Select"), [_INTL("Off"), _INTL("On")],
                      proc { $PokemonSystem.sb_select },
                      proc { |value| $PokemonSystem.sb_select = value },
                      ["Doesn't prompt you to select your team",
                      "Let you select your team"]
    )
    options << EnumOption.new(_INTL("Stat Tracker"), [_INTL("Off"), _INTL("On")],
                      proc { $PokemonSystem.sd_stat_tracker },
                      proc { |value| $PokemonSystem.sd_stat_tracker = value },
                      ["Does not display the stat tracker during Showdown battles",
                      "Shows stats such as Win/Loss tracker for Showdown battles"]
    )
    options << ButtonOption.new(_INTL("                ### Battle Rules ###"),
    proc {}
    )	
    options << EnumOption.new(_INTL("Money"), [_INTL("Off"), _INTL("On")],
                      proc { $PokemonSystem.sd_nomoney },
                      proc { |value| $PokemonSystem.sd_nomoney = value },
                      ["Do not gain or lose money during Showdown battles",
                      "Allows the player to gain/lose money during Showdown battles"]
    )
    # options << EnumOption.new(_INTL("Experience Gain"), [_INTL("Off"), _INTL("On")],
                      # proc { $PokemonSystem.sd_noexp },
                      # proc { |value| $PokemonSystem.sb_exp = value },
                      # ["Do not gain experience during Showdown battles with party",
                      # "Allows the player to gain experience during Showdown battles with party"]
    # )
    return options
  end
end
