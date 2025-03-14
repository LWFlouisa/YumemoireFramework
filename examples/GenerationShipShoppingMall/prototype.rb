# You have seven day to archive all J-Pop albums.
# Each day contains 24 hours.
# Run out of days and remain behind as Mall leaves without arching its J-Pop albums. And earth is destroyed by an apocalyptic Volcano.

# There are 130 J-Pop albums of crucial importance, and you can exchange each able to archivists for cash.
# In situations of duplicate albums, you get to keep that album. Collect all duplicates to unlock in game "OVAs".

# There are four intrative states: Steal, Stab, Shoot,

# You can stab enemies whom try to shoot you, but you can steal their gun. They can stab you to prevent you from stealing their gun.

# You have  10 HP, 4 ATK, and 2 Heal
# Enemy has 10 HP, 4 ATK, and 2 Heal
# Run out of HP and you die, must restart.
# They run out of HP, you continue with an hours decrement.
# Run out of hours in a day and you lose a day.

$days_left        =   7
$hours_left       = 168
$jpop_albums      = 130
$duplicate_albums =   3
$reset_hours      = 168
$enemies_beheaded =   0

$player_hp = 10
$enemy_hp  = 10

###################################################################################
#                              Enemy Naming Scheme                                #
###################################################################################
def monster_name
  def five_elements
    possible_elements = File.readlines("lib/monsternames/elements.txt")

    $chosen_element = possible_elements.sample.strip.to_s
  end

  def adjectives
    possible_adjectives = File.readlines("lib/monsternames/gendered_adverb.txt")

    $chosen_adjective = possible_adjectives.sample.strip.to_s 
  end

  five_elements
  adjectives

  $current_monster_name = $chosen_element + " " + $chosen_adjective
end 

###################################################################################
#             Turn Based Operations For Stealing, Stabbing, And Shooting          #
###################################################################################
def steal_operations
  chances_of_acquisition = ["Success", "Failure"]

  aquisition_success = chances_of_acquisition.sample

  if    aquisition_success == "Success"
    $jpop_albums = $jpop_albums - 1
  elsif aquisition_success == "Failure"
    $jpop_albums = $jpop_albums + 1
  end
end

def stab_operations
  chances_of_being_stabbed = ["Success", "Failure"]

  stab_success = chances_of_being_stabbed.sample

  if    stab_success == "Success"
    $player_hp = $player_hp - 1
  elsif stab_success == "Failure"
    $enemy_hp = $enemy_hp - 1
  end
end

def shoot_operations
  chances_of_assassination = ["Success", "Failure"]

  assassination_success = chances_of_assassination.sample

  if    assassination_success == "Success"
    $player_hp = $player_hp - 1
  elsif assassination_success == "Failure"
    $enemy_hp = $enemy_hp - 1
  end
end

def retrieve_albums
  $jpop_albums = $jpop_albums - 1
end

###################################################################################
#                               Main Game Loops                                   #
###################################################################################
system("clear")

monster_name

puts "The Generation ship and shopping mall needs your help to archive the remaining JPOP Albums of historical importance. Can you make it before the world destroying volcano erupts?"

loop do
  $hours_left = $hours_left - 1

  if $days_left <= 0
    system("clear")

    puts "The generation shopping mall took off for space without you."
    puts "GAME OVER"

    abort
  end

  if $player_hp <= 0
    system("clear")

    puts "GAME OVER"

    abort
  elsif $enemy_hp <= 0
    puts "You defeated an enemy..."

    $hours_left = $hours_left - 1

    sleep(1.5)

    system("clear")

    $enemy_hp         = $reset_enemy_hp
    $enemies_beheaded = $enemies_beheaded + 1

    monster_name

    puts "You have beheaded #{$enemies_beheaded} bandits."
  end

  if       $hours_left < 160
    $hours_left = $hours_left - 1

    puts "You have #{$days_left} days and #{$hours_left} hours."
  elsif    $hours_left < 144
    $hours_left = $hours_left - 1

    puts "You have #{$days_left} days and #{$hours_left} hours."
  elsif $hours_left < 120
    $hours_left = $hours_left - 1

    puts "You have #{$days_left} days and #{$hours_left} hours."
  elsif $hours_left <  96
    $hours_left = $hours_left - 1

    puts "You have #{$days_left} days and #{$hours_left} hours."
  elsif $hours_left <  72
    $hours_left = $hours_left - 1

    puts "You have #{$days_left} days and #{$hours_left} hours."
  elsif $hours_left <  48
    $hours_left = $hours_left - 1

    puts "You have #{$days_left} days and #{$hours_left} hours."
  elsif $hours_left <  24
    $hours_left = $hours_left - 1

    puts "You have #{$days_left} days and #{$hours_left} hours."
  elsif $hours_left <   0
    $days_left  = $days_left - 1
    $hours_left = $reset_hours

    puts "You have #{$days_left} days and #{$hours_left} hours."
  else
    $hours_left = $hours_left - 1

    puts "You have #{$days_left} days and #{$hours_left} hours."
  end

  if $jpop_albums < 1
    system("clear")

    puts "YON WON"

    abort
  else
    puts "You have #{$jpop_albums} left to archive."
  end

  puts " "

  puts "Enemy Name: #{$current_monster_name}"

  game_states = {
    "Archive" => "Steal",
    "Steal"   => "Stab",
    "Stab"    => "Shoot",
    "Shoot"   => "Steal",
  }

  possible_computer_choices = [
    "Steal", "Stab", "Shoot"
  ]

  @cchoice = possible_computer_choices.sample.to_s

  print "\nDo you wish to Archive, Steal, Stab, or Shoot? << "; @choice = gets.chop

  if    game_states[@cchoice] == @chooice
    puts ">> The enemy managed to knick you, and tries to steal your JPOP albums."

    $enemy_hp = $enemy_hp - 1

    steal_operations
  elsif game_states[@choice]  == @cchoice
    shoot_or_stab = ["Shoot", "Stab", "Steal", "Autodeath"]

    action = shoot_or_stab.sample

    if action == "Shoot"
      shoot_operations
    elsif action == "Steal"
      steal_operations
    elsif action == "Stab"
      stab_operations
    else
      puts "The enemy failed to steal, shoot, or stab you..."

      $enemy_hp = 0
    end
  elsif @cchoice == @choice
    puts ">> The managed to knick the enemy, before they could steal your JPOP albums."

    $player_hp = $player_hp - 1
  elsif @choice == "Archive"
    retrieve_albums
  else
    puts ">> Command was not understood..."
  end
end
