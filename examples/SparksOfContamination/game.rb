#puts "\e[38;10;25;38;33m begin' \e[0m"

# Sparks Of Contamination
# A clean up room in an old mansion must clean up the contamination from the last undead spill over.
# but more seems to be coming in an endless expanse. Hold back the goop, before the goops goops you.

$cleaned           = 0 # Amount your clean up crew cleaned.
$contamination     = 0 # Contamination spread.
$day_counter       = 0 # Thirty days before the next lunar shift.
$zombies           = 0 # How many zombies you bludgeons or strangled.

$mechanical_shovel    = false # Shovel used for cleaning up waste.
$mechanical_hammer    = false # Hammer used for bludgeoning zombies.
$suspicious_tee_shirt = false # Useful for a pinch, but you lose a day in the process.
$flashlight           = false # You need a flashlight to light up the mansion.

#############################################################################
#                        Elemental Monster Names                            #
#############################################################################
def monster_name
  def five_elements
    possible_elements = File.readlines("lib/monsternames/elements.txt")

    $chosen_element = possible_elements.sample.strip.to_s
  end

  def adjectives
    possible_adjectives = File.readlines("lib/monsternames/gendered_adverb.txt")

    $chosen_adjective = possible_adjectives.sample.strip.to_s 
  end
end 

monster_name.five_elements
monster_name.adjectives

$current_monster_name = $chosen_element + " " + $chosen_adjective

#############################################################################
#                          Tools Of The Trade                               #
#############################################################################
def find_tool
  tools_available = File.readlines("lib/inventory/possible_items.txt")

  #tools_available = [
    #"flashlight", "shovel", "hammer", "shirt"
  #]

  found_tool = tools_available.sample.strip.to_s

  if    found_tool == "flashlight"
    if $flashlight == false
      $flashlight = true

      puts "You found a flashlight."
    else
      puts "You already found the flashlight, this one winds up so you'll never run out of zombie juice."
    end
  elsif found_tool ==     "shovel"
    if $mechanical_shovel == false
      $mechanical_shovel = true

      puts "You found a mechanical shovel. But do you trust it? It's seen things!"
    else
      puts "You already found out the shovel you found is watching you.."
    end
  elsif found_tool ==     "hammer"
    if $mechanical_hammer == false
      $mechanical_hammer = true

      puts "You found a mechanical hammer."
    else
      puts "You already found the mechanical hammer."
    end
  elsif found_tool ==      "shirt"
    if $suspicious_tee_shirt == false
      $suspicious_tee_shirt = true

      puts "You forgot that you could just take off your shirt and strangle your enemies. Live fearlessly."
    else
      puts "You already found your mechanical tee shirt."
    end
  end
end

def flashlight
  system("clear")

  if true == $flashlight
    rooms = File.readlines("lib/data/world/rooms/room_list.txt")

    # room light
    garage     = File.read("lib/data/world/rooms/garage.txt").strip.to_s
    laundry    = File.read("lib/data/world/rooms/laundry.txt").strip.to_s
    livingroom = File.read("lib/data/world/rooms/livingroom.txt").strip.to_s
    kitchen    = File.read("lib/data/world/rooms/kitchen.txt").strip.to_s
    hallway    = File.read("lib/data/world/rooms/hallway.txt").strip.to_s
    bedroom    = File.read("lib/data/world/rooms/bedroom.txt").strip.to_s
    albumroom  = File.read("lib/data/world/rooms/albumroom.txt").strip.to_s

    current_room = rooms.sample.strip.to_s

    #current_room

    if    current_room ==      "Garage";     puts garage
    elsif current_room ==     "Laundry";    puts laundry
    elsif current_room == "Living Room"; puts livingroom
    elsif current_room ==     "Kitchen";    puts kitchen
    elsif current_room ==     "Hallway";    puts hallway
    elsif current_room ==     "Bedroom";    puts bedroom
    elsif current_room ==  "Album Room";  puts albumroom
    end
  else
    puts ">> You have no flashlight to temporarily light the room."
  end

  gets.chomp
end

def mechanical_shovel
  if true == $mechanical_shovel
    $contamination = $contamination - 1
    $cleaned       = $cleaned       + 1

    puts ">> You've used the mechanical shovel to scoop up contamination.'"
  else
    puts ">> You don't have a shovel to scoop up contamination with."
  end
end

def mechanical_hammer
  if true == $mechanical_hammer
    $zombies       = $zombies       - 1
    $contamination = $contamination + 1

    puts ">> You've smashed in a zombies head with a shovel. You got contaminated by zombie cooties."
  else
    puts ">> You don't have a mechanical hammer to smash in a zombie's head, so you flee like a mouse."
  end
end

def suspicious_tee_shirt
  if true == $suspicious_tee_shirt
    $days_counter = $day_counter + 1
    $zombies      = $zombies     - 1

    puts ">> You slowly strangle a zombie with all your might, but lose a day in the process."
  else
    puts ">> You haven't taken off your tee shirt, as you need sleeves to roll to whack some zombies."
  end
end

#############################################################################
#                                 Main                                      #
#############################################################################
loop do
  #puts "\e[48;10;25;38;33m begin' \e[0m"

  system("clear")

  if $contamination > 99
    system("clear")

    puts "You were already dead before the contamination reached you."
  elsif $cleaned    > 99
    system("clear")

    puts "You managed to get the whole house cleaned before the day limit ended."
  elsif $day_counter > 30
    system("clear")

    puts "You failed to clean the mansion and ran out of days to clean."
  else
    conditions = {
      "bludgeon" => "strangle",
      "strangle" =>    "scoop",
      "scoop"    => "bludgeon",
    }

    puts "Days Left: #{$day_counter}"

    puts "Zombie: #{$current_monster_name}"

    puts " "

    if $zombies < 0
      $zombies = $zombies + 1

      puts "Your zombie kill count is: #{$zombies}"      
    else
      puts "Your zombie kill count is: #{$zombies}"
    end

    if $contamination < 0
      $contamination = $contamination + 1

      puts "Your contamination level is: #{$contamination}"
    else
      puts "Your contamination level is: #{$contamination}"
    end

    if $cleaned < 0
      $cleaned = $cleaned + 1

      puts "Your cleaning score: #{$cleaned}"
    else
      puts "Your cleaning score: #{$cleaned}"
    end

    puts " "
    puts "light = flashlight"
    puts "find tool = find your tools"
    puts " "
    print "bludgeon, strangle, scoop << "
    @choice = gets.chomp.downcase

    zombie_choices = [
      "bludgeon", "strangle", "scoop"
    ]

    @cchoice = zombie_choices.sample

    if    conditions[@choice]  == @cchoice
      $contamination = $contamination + 1

      puts ">> The contamination has managed to spread further into the mansion."
    elsif conditions[@cchoice] == @choice
      if    @choice == "bludgeon"; mechanical_hammer
      elsif @choice ==    "scoop"; mechanical_shovel
      elsif @choice == "strangle"; suspicious_tee_shirt
      else
        print ">> This is not a valid choice."
      end
    elsif @choice == @cchoice
      puts ">> You and the zombies have trapped each other into a tiny cramped room."
    elsif @choice == "light"
      flashlight
    elsif @choice == "find tool"
      find_tool
    else
      puts ">> This is not a valid choice."
    end

    gets.chomp

    $day_counter = $day_counter + 1
  end
end
