system("clear")

$player_hp   = 19 # File.read("lib/player_stats/player_hp.txt").strip.to_i
$player_atk  = 2
$player_heal = 1 #$player_healing_rate

$enemy_hp   = 10
$enemy_atk  = 2
$enemy_heal = 4

# Amount of days in a year.
$current_day = 0
$lunar_ticks = 30

#class GameMode
#
#  def change_gamemode
#    puts "\e[H\e[2J"
#
#    print "\e[8;22;53t"
#
#    puts "================"
#    puts "TERMINAL SHOOTER"
#    puts "================"
#
#    puts "\e[H\e[2J"
#
#    print "Game mode is: "
#
#    a = ["Even", "Advantage", "Ambushed", "Last Stand"]
#
#    auto_i = a.sample
#
#    if auto_i == "Even"
#
#      puts "Even"
#
#      $player_health = 100
#      $enemy_health = 100
#    elsif auto_i == "Advantage"
#      puts "Advantage"
#
#      $player_health = 130
#      $enemy_health = 65
#    elsif auto_i == "Ambushed"
#      puts "Ambushed"
#
#      $player_health = 45
#      $enemy_health = 130
#    elsif auto_i == "Last Stand"
#      puts "Last Stand"
#
#      $player_health = 100
#      $enemy_health = 10000
#    end
#
#    sleep(1.5
#
#    s = Spaceships.new
#    s.p_navigate
#
#  end
#  
#end

##########################################################################################
#                                    Lunar Phase                                         #
##########################################################################################
def lunar_cycle
  lunar_phases = [0, 1, 2, 3, 4, 5, 6, 7]

  # The current lunar phase mod 7
  current_phase  = $current_phase % 7
  #$current_phase = $current_phase + 1 % 7

  if    current_phase == lunar_phases[0]
    puts "\e[38;2;187;127;118mLa phase lunaire actuelle est: Full Moon. Réinitialisation des statistiques du joueur...\e[0m"

    sleep(1)

    $player_hp   = $player_hp
    $player_atk  = $player_atk
    $player_heal =  2

    # Negative Healing ala illness
    #$player_illness = 2
  elsif current_phase == lunar_phases[1]
    puts "\e[38;2;187;127;118mLa phase lunaire actuelle est: Waning Gibbous. Réinitialisation des statistiques du joueur...\e[0m"

    sleep(1)

    $player_hp   = $player_hp - 2
    $player_atk  = $player_atk + 2
    $player_heal = 2

    # Negative Healing ala illness
    #$player_illness = 2
  elsif current_phase == lunar_phases[2]
    puts "\e[38;2;187;127;118mLa phase lunaire actuelle est: First Quarter. Réinitialisation des statistiques du joueur...\e[0m"

    sleep(1)

    $player_hp   = $player_hp  - 4
    $player_atk  = $player_atk + 4
    $player_heal = 2

    # Negative Healing ala illness
    #$player_illness = 2
  elsif current_phase == lunar_phases[3]
    puts "\e[38;2;187;127;118mLa phase lunaire actuelle est: Waxing Crescent. Réinitialisation des statistiques du joueur...\e[0m"

    sleep(1)

    $player_hp   = $player_hp  - 6
    $player_atk  = $player_atk + 6
    $player_heal = 2

    # Negative Healing ala illness
    #$player_illness = 2
  elsif current_phase == lunar_phases[4]
    puts "\e[38;2;187;127;118mLa phase lunaire actuelle est: New Moon. Réinitialisation des statistiques du joueur...\e[0m"

    sleep(1)

    $player_hp   = $player_hp  - 8
    $player_atk  = $player_atk + 8
    $player_heal = 2

    # Negative Healing ala illness
    #$player_illness = 8
  elsif current_phase == lunar_phases[5]
    puts "\e[38;2;187;127;118mLa phase lunaire actuelle est: Waning Crescent. Réinitialisation des statistiques du joueur...\e[0m"

    sleep(1)

    $player_hp   = $player_hp  - 5
    $player_atk  = $player_atk + 6
    $player_heal = 2

    # Negative Healing ala illness
    #$player_illness = 6
  elsif current_phase == lunar_phases[6]
    puts "\e[38;2;187;127;118mLa phase lunaire actuelle est: Third Quarter. Réinitialisation des statistiques du joueur...\e[0m"

    sleep(1)

    $player_hp   = $player_hp  - 3 #  7
    $player_atk  = $player_atk + 8 # 10
    $player_heal = 2

    # Negative Healing ala illness
    #$player_illness = 4
  elsif current_phase == lunar_phases[7]
    puts "\e[38;2;187;127;118mLa phase lunaire actuelle est: Waning Gibbous. Réinitialisation des statistiques du joueur...\e[0m"

    sleep(1)

    $player_hp   = $player_hp  - 1 # 9
    $player_atk  = $player_atk - 2 # 2
    $player_heal = 2

    # Negative Healing ala illness
    #$player_illness = 2
  end

  sleep(1.5)

  s = Spaceships.new
  s.p_navigate
end

class Spaceships
  def kamikaze
    puts ">> The player's ship has self-destructed. The player floats in space with 1 hp."

    $player_hp = 1
    $enemy_hp  = $enemy_hp - 20

    puts ">> Help has arrived."

    sleep(1.5)

    check_state
  end

  def player_input
    puts "Enemy: #{$enemy_hp} Player: #{$player_hp} Lunar Days: #{$current_day}"
    puts "===========" + "================" + "============"
    puts "[1] Attack " + "[2] Repair Ship " + "[3] Kamikaze"
    puts "===========" + "================" + "============"
    print "> "
    input = gets.chomp
    if input == "1"
      player_spaceship
    elsif input == "2"
      player_spaceship_r
    elsif input == "3"
      puts ">> Your ship self-destructed..."

      sleep(1.5)

      kamikaze
    else
      puts ">> Instructions not understood."

      sleep(1)

      e_navigate
    end
  end

  def check_state
    if $player_hp <= 0
      puts "You lost this battle..."

      sleep(1.5)

      $player_hp   = 19 # File.read("lib/player_stats/player_hp.txt").strip.to_i
      #$player_atk  = 2
      #$player_heal = 1 #$player_healing_rate

      $enemy_hp   = 10
      #$enemy_atk  = 2
      #$enemy_heal = 4

      p_navigate
    elsif $enemy_hp <= 0
      puts "You won this battle..."

      sleep(1.5)

      $player_hp   = 19 # File.read("lib/player_stats/player_hp.txt").strip.to_i
      #$player_atk  = 2
      #$player_heal = 1 #$player_healing_rate

      $enemy_hp   = 10
      #$enemy_atk  = 2
      #$enemy_heal = 4

      p_navigate
    end

    if $current_day < $lunar_ticks
      this_day = 29

      puts "\e[38;2;187;127;118mLa prochaine phase lunaire est en cours: #{this_day - $current_day} days...\e[0m"
    else
      lunar_cycle

      # Reset lunar ticks to twenty days away.
      $current_day = 1
    end

    s = Spaceships.new
    s.e_navigate
  end

  def enemy_damage_formulas
  end

  def enemy_spacehsip
    3.times do
      print "Player is at..."
      print $player_hp -= 1
      puts " hp."
    end

    sleep(1.5)

    p_navigate
  end

  def enemy_repair_spaceship
    #3.times do
      print "Player..."
      print $enemy_hp += 1
      puts " hp."
    #end

    sleep(1.5)

    system("clear")
    p_navigate
  end

  def e_navigate
    system("clear")

    enemy_spaceship = File.read("img/ships/enemy_ship.txt").strip.to_s

    puts enemy_spaceship

    enemy_input = ["Attack", "Repair"]

    current_action = enemy_input.sample

    if current_action == "Attack"
      enemy_spaceship
    elsif current_action == "Repair"
      enemy_repair_spaceship
    end

    sleep(1.5)

    p_navigate
  end

  def p_navigate
    player_spaceship = File.read("img/ships/player_ship.txt").strip.to_s

    puts player_spaceship
    player_input
  end

  def player_damage_formulas
  end

  def player_spaceship # Attack Mode Player
    3.times do
      print "Enemy is at..."
      print $enemy_hp -= 1
      puts " hp."
    end

    sleep(1.5)

    check_state
  end

  def player_spaceship_r # Repair Mode Player
    3.times do
      print "You are at..."
      print $player_hp += 1
      puts " hp."
    end

    sleep(1.5)

    check_state
  end

end

s = Spaceships.new
s.p_navigate
