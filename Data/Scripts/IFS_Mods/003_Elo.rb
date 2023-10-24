# made by nine

# using PokemonStorage cause idk where else to put it
class PokemonStorage
  elo_file = "ExportedPokemons/elo.csv"

  def win_prob(elo1, elo2)
    return 1.0 / (1 + 1.0 * (10 ** (1.0 * (elo1 - elo2) / 400)))
  end

  def get_k(elo) # using a variable K value ensures no elo will be artifically inflated/deflated if the team only faces way weaker/stronger teams
    k = 30
    if elo > 3000 # almost nothing will make it past 3k elo, only way how would be a 100% winrate team with thousands of matches
      k = 1
    elsif elo > 2600
      k = 3
    elsif elo > 2400
      k = 10
    elsif elo > 1500
      k = 15
    elsif elo > 1000
      k = 25
    end
    return k
  end

  def get_change(elo_player, elo_enemy, winner)
      # ensure floating point numbs cause whynaut
      elo_player = elo_player.to_f
      elo_enemy = elo_enemy.to_f
      winner = winner.to_f
    
      # probability team will win
      prob_ene = win_prob(elo_player, elo_enemy)
      prob_plr = win_prob(elo_enemy, elo_player)
    
      # what is used for a "major" win/loss, aka an upset
      # diff is elo, percent is win percent
      major_diff = 750
      major_percent = 0.80
    
      # sanity
      if elo_player < 100 || elo_enemy < 100
        return [0, 0]
      end
    
      if winner == 1 && elo_player >= elo_enemy
        if prob_plr >= major_percent
          d_plr = get_k(elo_player + major_diff) * (1 - prob_plr)
          d_ene = get_k(elo_enemy + major_diff) * prob_ene * -1
        else
          d_plr = get_k(elo_player) * prob_plr
          d_ene = get_k(elo_enemy) * prob_ene * -1
        end
      elsif winner == 1 && elo_player < elo_enemy
        if prob_ene > major_percent
          d_plr = get_k(elo_player - (elo_enemy - elo_player) - major_diff) * (1 - prob_plr)
          d_ene = get_k(elo_player + (elo_enemy - elo_player) - major_diff) * prob_ene * -1
        else
          d_plr = get_k(elo_player - (elo_enemy - elo_player)) * (1 - prob_plr)
          d_ene = get_k(elo_player + (elo_enemy - elo_player)) * prob_ene * -1
        end
      elsif winner == 2 && elo_player <= elo_enemy
        if prob_ene >= major_percent
          d_plr = get_k(elo_player + major_diff) * prob_plr * -1
          d_ene = get_k(elo_enemy + major_diff) * (1 - prob_ene)
        else
          d_plr = get_k(elo_player) * prob_plr * -1
          d_ene = get_k(elo_enemy) * prob_ene
        end
      elsif winner == 2 && elo_player > elo_enemy
        if prob_plr > major_percent
          d_plr = get_k(elo_enemy + (elo_player - elo_enemy) - major_diff) * prob_plr * -1
          d_ene = get_k(elo_enemy - (elo_player - elo_enemy) - major_diff) * prob_plr
        else
          d_plr = get_k(elo_enemy + (elo_player - elo_enemy)) * prob_plr * -1
          d_ene = get_k(elo_enemy - (elo_player - elo_enemy)) * prob_plr
        end
      else
        # draw
        d_plr = 0
        d_ene = 0
      end
      return [d_plr, d_ene]
  end

  def write_elo(team, elo=1000)
    lines = File.readlines(elo_file)
    text_found = false

    lines.map! do |line|
      if line.include?(search_text)
        text_found = true
        # Replace the line with the replacement text
        line = "\n#{team},#{elo}" 
      end
      line
    end

    # Check if the text was found in the file
    if text_found
      # Write the modified lines back to the file
      File.open(elo_file, 'w') do |file|
        file.puts(lines)
      end
    else
      puts "[ELO] write_elo: Team #{team} not found, adding to csv"
      File.open(elo_file, 'w') do |file|
        file.puts("\n#{team},#{elo}")
      end
    end
    # File.open("ExportedPokemons/elo.csv", 'a') { |f| f.write(playerdirsupp + "," + enemydirsupp + "," + result.to_s + "\n") } # ref
  end

  def get_elo(team)
    lines = File.readlines(elo_file)
    match = -1
    lines.map! do |line|
      if line.include?(search_text)
        match = line.strip.split(',')[1]
      end
      line
    end
    if match == -1
      puts "[ELO] get_elo: Team #{team} not found, adding to csv"
      write_elo(team, elo) # this may error out but idk, FIXME if does
    end
    return match 
  end

  # TODO:
  # this
  def get_tier(elo) 
    # 2.0k+ = anything goes/hackmon level?
    # 1.6k-2.0k = uber?
    # 1.2k-1.6k = OU/Elite4/ArtificalMons?
    # 0.8k-1.2k = ~UU/HoF/NaturalMons?
    # <800 = PU?

    return 'WIP'
  end



end