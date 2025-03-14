module Yumemoire
  class Window
    def clear_screen
      system("clear")
    end

    ##########################################################################################
    #                       Global variables that effect gameplay.                           #
    ##########################################################################################
    def self.initialize
      # Standard Operations
      $stalemates    = 0 # Keeps track of how many stalemates
      $player_struck = 0 # Keeps track of how many times player hit the enemy.
      $enemy_struck  = 0 # Keeps track of how many times enemy hit the player.

      ## Current Lunar Phase
      $current_phase = 0

      # One allows you to always maintain a certain maximum reset hp. The other can be altered.
      $true_reset_hp = File.read("lib/data/user/player_stats/true_reset_hp.txt").strip.to_i
      $reset_hp      = File.read("lib/data/user/player_stats/true_reset_hp.txt").strip.to_i

      # Standard base stats
      $personal_demon_metric = File.read("lib/data/user/personal_demon_metric.txt").strip.to_i
      $player_healing_rate   = File.read("lib/data/user/player_stats/player_healing_rate.txt").strip.to_i

      $player_hp   = File.read("lib/data/user/player_stats/player_hp.txt").strip.to_i
      $player_atk  = 2
      $player_heal = 1 #$player_healing_rate

      $enemy_hp   = 10
      $enemy_atk  = 2
      $enemy_heal = 4

      # Amount of days in a year.
      $current_day = 0
      $lunar_ticks = 30

      # Resets the player's HP
      $true_hp_reset = 10
      $reset_hp = 10

      # In game currency
      $value_of_yen     = 172
      $value_of_franc   = 1
      $value_of_lunario = $value_of_franc * 500

      # For every five Francs you get 860 yen.
      $player_lunario = $value_of_lunario * 5
      $player_franc   = $value_of_franc * 5
      $player_yen     = $value_of_yen * 5

      # Yes or no spider
      $has_pet_spider = false
    end

    def self.menu # Shows the main menu
      puts "\e[38;2;187;127;118m  \e[8;42;107t"

      loop do
        system("clear")

        title_text = File.read("lib/images/title/title2.txt")

        puts title_text

        print "What would you like to do? [ Play / Beastiary / Language / Laboratory / Quit ] >> "; option = gets.chomp

        if option == "Play"
          Yumemoire::Player.choose_state
        elsif option == "Beastiary"
          system("cd lib/beastiary; ruby beastiary.rb")
        elsif option == "Language"
          print ">> Glossary or translation? >> "; lang_choice = gets.chomp

          if    lang_choice == "Glossary"
            Yumemoire::Player.encyclopedia.study
          elsif lang_choice == "Translate"
            Yumemoire::Player.encyclopedia.translate
          else
            puts ">> This language option does not exist."
          end
        elsif option == "Laboratory"
          print "What type of color synthesis? >> "; synthesis_type = gets.chomp

          if synthesis_type == "Real"
            Yumemoire::Player.synthesize.colors.automixREAL
          elsif synthesis_type == "Synthetic"
            Yumemoire::Player.synthesize.colors.automixSYNTH
          else
            puts ">> There is no such laboratory..."

            abort
          end
        elsif option == "Quit"
          system("clear")

          abort
        else
          puts "Unregonized command..."

          sleep(1.5)
        end
      end
    end

   ##########################################################################################
   # This draws two different types of maps, one for general town navigation, and others    #
   # for dungeon navigation, which will follow a more standard roguelike method of          #
   # procedural content generation.                                                         #
   ##########################################################################################
    def self.minimap # Shows player location
      clear_screen

      def self.first_person
        all_possible_maps = [
          "lib/dungeon/map_one", "lib/dungeon/map_two",
          "lib/dungeon/map_tre", "lib/dungeon/map_fro",
          "lib/dungeon/map_fiv", "lib/dungeon/map_six",
          "lib/dungeon/map_sev", "lib/dungeon/map_eit",
          "lib/dungeon/map_nin", "lib/dungeon/map_ten",
          "lib/dungeon/map_elv", "lib/dungeon/map_twe",
          "lib/dungeon/map_thi", "lib/dungeon/map_frt",
        ]

        map_one = File.read("lib/dungeon/map_one/map.txt").strip.to_s
        map_two = File.read("lib/dungeon/map_two/map.txt").strip.to_s
        map_tre = File.read("lib/dungeon/map_tre/map.txt").strip.to_s
        map_fro = File.read("lib/dungeon/map_fro/map.txt").strip.to_s
        map_fiv = File.read("lib/dungeon/map_fiv/map.txt").strip.to_s
        map_six = File.read("lib/dungeon/map_six/map.txt").strip.to_s
        map_sev = File.read("lib/dungeon/map_sev/map.txt").strip.to_s
        map_eit = File.read("lib/dungeon/map_eit/map.txt").strip.to_s
        map_nin = File.read("lib/dungeon/map_nin/map.txt").strip.to_s
        map_ten = File.read("lib/dungeon/map_ten/map.txt").strip.to_s
        map_elv = File.read("lib/dungeon/map_elv/map.txt").strip.to_s
        map_twe = File.read("lib/dungeon/map_twe/map.txt").strip.to_s
        map_thi = File.read("lib/dungeon/map_thi/map.txt").strip.to_s
        map_frt = File.read("lib/dungeon/map_fri/map.txt").strip.to_s
        
        map_number    = File.read("lib/dungeon/initializer/map_number.txt").strip.to_s
        map_directory = all_possible_maps[map_number]
        current_map   = "#{map_directory}/map.txt"

        if    current_map == "lib/dungeon/map_one/map.txt"; puts map_one 
        elsif current_map == "lib/dungeon/map_two/map.txt"; puts map_two
        elsif current_map == "lib/dungeon/map_tre/map.txt"; puts map_tre
        elsif current_map == "lib/dungeon/map_fro/map.txt"; puts map_fro
        elsif current_map == "lib/dungeon/map_fiv/map.txt"; puts map_fiv
        elsif current_map == "lib/dungeon/map_six/map.txt"; puts map_six
        elsif current_map == "lib/dungeon/map_sev/map.txt"; puts map_sev
        elsif current_map == "lib/dungeon/map_eit/map.txt"; puts map_eit
        elsif current_map == "lib/dungeon/map_nin/map.txt"; puts map_nin
        elsif current_map == "lib/dungeon/map_ten/map.txt"; puts map_ten
        elsif current_map == "lib/dungeon/map_elv/map.txt"; puts map_elv
        elsif current_map == "lib/dungeon/map_twe/map.txt"; puts map_twe
        elsif current_map == "lib/dungeon/map_thi/map.txt"; puts map_thi
        elsif current_map == "lib/dungeon/map_frt/map.txt"; puts map_frt
        else
          puts "This Map Is Not Available."
        end
      end

      def self.top_down
        clear_screen

        # In development
      end
    end

    def self.statistics # Shows statistics hub for player.
      puts "\e[38;2;187;127;118m[ Currency is #{$player_franc} Francs And #{$player_yen} Yen ]\e[0m"

      puts "\e[38;2;187;127;118m\n[ Stalemates: #{$stalemates} ] [ Player Strikes: #{$player_struck} ] [ Enemy Strikes: #{$enemy_struck} ]\e[0m"
      puts "\e[38;2;187;127;118m  [ #{$player_lunario} Lunario ( You wont need this for most game functions. ) ]"

      puts "\e[38;2;187;127;118m\n\e[0m"
      puts "\e[38;2;187;127;118mSouer De Chaos ( Ana Nuveyatusuki ) HP: #{$player_hp} \e[0m"
      #puts "\e[38;2;187;127;118m#{$current_monster_name} HP: #{$enemy_hp}\e[0m"
      puts "\e[38;2;187;127;118mSouer De Commande ( Ana Nuveyatusuki ) HP: #{$enemy_hp}\e[0m"
      puts "\e[38;2;187;127;118m\n\e[0m"
    end
  end

  ##########################################################################################
  #                 This covers functionality for the lunar calender.                      #
  ##########################################################################################
  class LunarCalender
    def self.lunar_cycle
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
    end

  end

  class Player
    def self.initialize
      Yumemoire::Window.minimap.first_person
      Yumemoire::Window.statistics
    end

    # Complementary player activities
    def self.encyclopedia
      def self.study
        Yumemoire::Window.clear_screen

        word_index = File.read("lib/encyclopedia/encyclopedia/glossary.txt")

        puts word_index

        print "\nWhat word would you like to look up? >> "; research = gets.chomp

        if    research == "Lunario"
          puts "BOB >> This is the largest form of in game currency, and is not used in ordinary game mechanics. It is mainly used for giving offerings to the lunar goddess, or paying the fair for dimension hopping that will come in the tiles version."

          gets.chomp
        elsif research == "Yen"
          puts "BOB >> The smallest form of in game currency, this is mainly used for smaller fair items."

          gets.chomp

        elsif research == "Franc"
          puts "BOB >> This is the largest form of in game currency within the scope of standard in game use. Once the tiles version of released, Lunario exists as travel currency."

          gets.chomp
        elsif research == "RPS"
          puts "BOB >> RPS ia the ancronym for a form of games based on the mechanics of rock, paper, and scissors."

          gets.chomp
        elsif research == "exit"
          abort
        else
          puts "BOB >> The definition for this word does not exist."
        end
      end

      def self.translate
        sleep(1.5)

        print "What word would you like to translate? >> "; translate = gets.chomp

        # Get the word count based on how many words are in a sentence.
        #word_count = translate.split(" ").to_i

        dictionary = {
          ## Word Classes

          ## Francophonic
          "Le"  => "The ( Masculine ) [ Francophonic ]",
          "La"  =>  "The ( Feminine ) [ Francophonic ]",
          "Les" =>    "The ( Plural ) [ Francophonic ]",
          "Un"  =>                 "A [ Francophonic ]",
          "Une" =>                "An [ Francophonic ]",
          "Des" =>              "Some [ Francophonic ]",

          ## Japonic
          "Anu"  => "The ( Masculine ) [ Pseudo-Japonic ]",
          "Ana"  =>  "The ( Feminine ) [ Pseudo-Japonic ]",
          "Anos" =>    "The ( Plural ) [ Pseudo-Japonic ]",
          "Tu"   =>                 "A [ Pseudo-Japonic ]",
          "Ta"   =>                "An [ Pseudo-Japonic ]",
          "Tos"  =>             "Some [ Pseudo-Japaonic ]",

          ## German By Route Of Alsatian
          "Der" => "The ( Masculine ) [ Germanic ]",
          "Die" =>  "The ( Feminine ) [ Germanic ]",
          "Das" =>    "The ( Plural ) [ Germanic ]",
          "A"   =>                 "A [ Germanic ]",
          "Ein" =>                "An [ Germanic ]",

          ## Compound Word Specific Word Classes
          "Lanu"  => "The ( masculine ) [ Ahusacos Specific ]",
          "Lana"  =>  "The ( feminine ) [ Ahusacos Specific ]",
          "Lanos" =>    "The ( plural ) [ Ahusacos Specific ]",
          "Tun"   =>                 "A [ Ahusacos Specific ]",
          "Tan"   =>                "An [ Ahusacos Specific ]",
          "Deso"  =>         "It / Some [ Ahusacos Specific ]",

          ## Negation Clauses
          "Ne"   => "Not [ Francophonic ]",
          "Na"   =>      "Not [ Japonic ]",
          "Nix " =>       "Not [ Hybrid ]",
          "Nein" =>     "Not [ Germanic ]",

          ## Personal Pronouns
          "Je"        =>       "I",
          "Vous"      => "You all",
          "Toi"       =>     "You",
          "Nous"      =>      "We",
          "Il"        =>      "He",
          "Ils"       =>     "Him",
          "Elle"      =>     "She",
          "Elles"     =>     "Her",

          ## Common Posessives
          "mien"   =>  "mine",
          "votre"  =>  "your",
          "tien"   => "yours",
          "notre"  =>   "our",
          "notres" =>  "ours",
          "sien"   =>   "his",
          "sienne" =>  "hers",

          ## Not used outside of context of military context, used to refer to groups of units.
          ## In practice, right-wing factions use the wrong plural pronoun to misgender entire units
          ## as a way to lower moral of left-wing factions. Because of this, after the Franco-Japanese
          ## Wars, they stopped being used widely.

          ## War Plurals
          "Nousil"    =>  "He plural",
          "Nousils"   => "Him plural",
          "Nouselle"  => "She plural",
          "Nouselles" => "Her plural",

          ## Plural Posessives
          "sienotre"    =>     "our men",
          "sienenotre"  =>   "our women",
          "sienotres"   =>   "our men's",
          "sienenotres" => "our women's",

          ## Famille / Family

          ### Francophonic
          "Pere"       =>        "Father",
          "Mere"       =>        "Mother",
          "Frere"      =>       "Brother",
          "Soeur"      =>        "Sister",
          "Cousifrere" =>   "Male Cousin",
          "Cousisoeur" => "Female Cousin",
          "Cousiles"   =>  "Both Cousins",
          "Tante"      =>          "Aunt",
          "Oncle"      =>         "Uncle",

          ### Color Acidity Framework
          # These colors are for a system that rates colors based on their acidity or alkalinity.

          ##### Reds
          "PH4DR1" => "Salmon",
          "PH5DR1" => "Pale Salmon",
          "PH4DR3" => "Salmon Pink",

          ##### Oranges
          "PH4DR2" => "Copper",
          "PH8WE1" => "Japanese Bistre",

          ##### Yellow
          "PH6DR1" => "Maize",
          "PH5DR2" => "Khaki",
          "PH6DR3" => "Bland",

          ##### Green
          "PH6DR2" =>     "Pale Lime",
          "PH7NU1" => "Vibrant Green",
          "PH7NU2" =>  "Medium Green",
          "PH8WE2" =>   "Kelly Green",

          ##### Blue
          "PH9WE2" =>       "Viridian",
          "PHAWE3" =>    "Ultramarine",
          "PH9WE3" => "Muted Sapphire",
          "PH8WE3" =>  "Dark Sapphire",
          "PH7NU3" =>      "Grey Blue",

          ##### Purple
          "PH9WE1" => "Dull Purple",
          "PH5DR3" => "Light Mauve",

          ##### Unusual Or Rare Color
          "PH1WE3CH1"    => "Dark Lavender", # A theoretical compound that blends Salmon with Sapphire blue.
          "PH4WE2CH2"    =>  "Atomic Hazel", # A highly toxic combination of copper and arsenic.
          "Atomic Hazel" =>       "#6D6C46", # Hex code for atomic hazel.

          ### Chomatic Shades
          ### Arsenic Scale

          ### Unknown Origin
          "PHAWE1"       =>      "Bordeaux", # I don't know how I got this color.'

          ### Hand Mixed Colors
          "#83b281" => "Dusty Green",

          ### Synthesized From Real Colors
          "#A9A8AD" => "Faded Carolina Blue", # Pale Lime, Salmon Pink, Bland, Grey Blue    [ Hypothesis Acidic Blue ]
          "#A0A5B9" => "Manilla Lavender",    # Salmon, Pale Salmon, Grey Blue, Grey Blue   [ Hypothesis Slightly Alkaline Grey Blue ]
          "#8cc874" => "Asparagus",           # Pale Lime, Maize, Light Mauve, Medium Green [ Hypothesis Alkaline Green ]
          "#a0b36c" => "Tan Green",           # Pale Salmon, Kelly Green, Bland, Khaki      [ Hypothesis Slightly Tan Green ]
          "#5673A9" => "Dusky Blue",          # Grey Blue, Light Mauve, Khaki, Sapphire     [ Hypothesis Highly Alkaline Blue ]
          "#A59C94" => "Warm Grey",           # Vibrant Green, Salmon, Sapphire Dark, Bland [ Hypothesis Slightly Acidic Grey ]

          ### Synthesized From Synthetic Colors
          "#788a9a" => "Steel",               # Faded Carolina Blue, Tan Green, Warm Grey, Dusky Blue [ Hypothesis Slightly Alkaline Medium Chromatic Blue ]
          "#415588" => "Dusky Blue Medium"    # Genetically related to standard Dusky blue. Faded Carolina Blue, Tan Green, Warm Grey, Dusky Blue [ Hypothesis More Shaded Alkaline Blue ]
        }

        print "Your translation: "
        print "#{translate} => #{dictionary[translate]}"
        puts " "

        gets.chomp
      end

      ## Developers only, do not touch.
      def self.word_generator
        Yumemoire::Window.clear_screen

        # Single Character Word: esa 
        # Three Character Word: ehykiemu 
        # Five Character Word: uaeneenyehyehi 
        # Seven Character Word: faeneenuemugewyya

        # Single
        #uu ua uos
 
        # Triple
        #emekopu emekopa emekopos
 
        # Septuple
        #jawudueheiu jawudueheia jawudueheios
 
        # Seven
        #enakyiykoerieridu enakyiykoerierida enakyiykoerieridos

        def self.word_lengths
          def self.one_character
            dipthongs  = File.readlines("dictionary/dipthongs.txt")
            tripthongs = File.readlines("dictionary/tripthongs.txt")

            chosen_tripthong = tripthongs.sample.strip.to_s
            chosen_dipthong  = dipthongs.sample.strip.to_s

            generated_word = chosen_tripthong + chosen_dipthong

            masculine      = generated_word.chop +  "u"
            feminine       = generated_word.chop +  "a"
            plural         = generated_word.chop + "os"
    
            puts "Single Factor"
            puts "#{masculine} #{feminine} #{plural}"

            puts " "
          end

          def self.three_character
            dipthongs  = File.readlines("dictionary/dipthongs.txt")
            tripthongs = File.readlines("dictionary/tripthongs.txt")

            chosen_tripthong1 = tripthongs.sample.strip.to_s
            chosen_dipthong1  = dipthongs.sample.strip.to_s

            chosen_tripthong2 = tripthongs.sample.strip.to_s
            chosen_dipthong2  = dipthongs.sample.strip.to_s

            chosen_tripthong3 = tripthongs.sample.strip.to_s
            chosen_dipthong3  = dipthongs.sample.strip.to_s

            component_one = chosen_tripthong1 + chosen_dipthong1
            component_two = chosen_tripthong2 + chosen_dipthong2
            component_tre = chosen_tripthong3 + chosen_dipthong3

            generated_word = component_one + component_two + component_tre

            masculine      = generated_word.chop +  "u"
            feminine       = generated_word.chop +  "a"
            plural         = generated_word.chop + "os"
    
            puts "Three Factor"
            puts "#{masculine} #{feminine} #{plural}"

            puts " "
          end

          def self.five_character
            dipthongs  = File.readlines("dictionary/dipthongs.txt")
            tripthongs = File.readlines("dictionary/tripthongs.txt")

            chosen_tripthong1 = tripthongs.sample.strip.to_s
            chosen_dipthong1  = dipthongs.sample.strip.to_s

            chosen_tripthong2 = tripthongs.sample.strip.to_s
            chosen_dipthong2  = dipthongs.sample.strip.to_s

            chosen_tripthong3 = tripthongs.sample.strip.to_s
            chosen_dipthong3  = dipthongs.sample.strip.to_s

            chosen_tripthong4 = tripthongs.sample.strip.to_s
            chosen_dipthong4  = dipthongs.sample.strip.to_s

            chosen_tripthong5 = tripthongs.sample.strip.to_s
            chosen_dipthong5  = dipthongs.sample.strip.to_s

            component_one = chosen_tripthong1 + chosen_dipthong1
            component_two = chosen_tripthong2 + chosen_dipthong2
            component_tre = chosen_tripthong3 + chosen_dipthong3
            component_fro = chosen_tripthong4 + chosen_dipthong4
            component_fiv = chosen_tripthong5 + chosen_dipthong5

            generated_word = component_one + component_two + component_tre + component_fro + component_fiv

            masculine      = generated_word.chop +  "u"
            feminine       = generated_word.chop +  "a"
            plural         = generated_word.chop + "os"
    
            puts "Five Factor"
            puts "#{masculine} #{feminine} #{plural}"

            puts " "
          end

          def self.seven_character
            dipthongs  = File.readlines("dictionary/dipthongs.txt")
            tripthongs = File.readlines("dictionary/tripthongs.txt")

            chosen_tripthong1 = tripthongs.sample.strip.to_s
            chosen_dipthong1  = dipthongs.sample.strip.to_s

            chosen_tripthong2 = tripthongs.sample.strip.to_s
            chosen_dipthong2  = dipthongs.sample.strip.to_s

            chosen_tripthong3 = tripthongs.sample.strip.to_s
            chosen_dipthong3  = dipthongs.sample.strip.to_s

            chosen_tripthong4 = tripthongs.sample.strip.to_s
            chosen_dipthong4  = dipthongs.sample.strip.to_s

            chosen_tripthong5 = tripthongs.sample.strip.to_s
            chosen_dipthong5  = dipthongs.sample.strip.to_s

            chosen_tripthong6 = tripthongs.sample.strip.to_s
            chosen_dipthong6  = dipthongs.sample.strip.to_s

            chosen_tripthong7 = tripthongs.sample.strip.to_s
            chosen_dipthong7  = dipthongs.sample.strip.to_s

            component_one = chosen_tripthong1 + chosen_dipthong1 # dipthongs.sample.strip.to_s
            component_two = chosen_tripthong2 + chosen_dipthong2 # dipthongs.sample.strip.to_s
            component_tre = chosen_tripthong3 + chosen_dipthong3 # dipthongs.sample.strip.to_s
            component_fro = chosen_tripthong4 + chosen_dipthong4 # dipthongs.sample.strip.to_s
            component_fiv = chosen_tripthong5 + chosen_dipthong5 # dipthongs.sample.strip.to_s
            component_six = chosen_tripthong6 + chosen_dipthong6 # dipthongs.sample.strip.to_s
            component_sev = chosen_tripthong7 + chosen_dipthong7 # dipthongs.sample.strip.to_s

            generated_word = component_one + component_two + component_tre + component_fro + component_fiv + component_six + component_sev

            masculine      = generated_word.chop +  "u"
            feminine       = generated_word.chop +  "a"
            plural         = generated_word.chop + "os"
    
            puts "Seven Factor"
            puts "#{masculine} #{feminine} #{plural}"

            puts " "
          end

          def self.hybrid_compounds
            japanese_words = File.readlines("dictionary/japanese_words.txt")
            french_words   = File.readlines("dictionary/french_words.txt")

            current_nihongo  = japanese_words.sample.strip.to_s
            current_francais = french_words.sample.strip.to_s

            generated_word = current_nihongo + current_francais

            masculine_class = "Te "
            feminine_class  = "Ta "
            plural_class    = "Deso "

            generated_masculine_form = masculine_class + generated_word
            generated_feminine_form  = feminine_class  + generated_word
            generated_plural_form    = plural_class    + generated_word

            masculine_end_word = generated_masculine_form.chop + "u"
            feminine_end_word  = generated_feminine_form.chop + "a"
            plural_end_word    = generated_plural_form.chop + "os"

            puts "Naturalistic"
            puts "#{masculine_end_word}"
            puts "#{feminine_end_word}"
            puts "#{plural_end_word}"
          end
        end

        #word_lengths.one_character
        #word_lengths.three_character
        #word_lengths.hybrid_compounds
        #word_lengths.five_character
        #word_lengths.seven_character

        #Yumemoire::Player.word_lengths.one_character
        #Yumemoire::Player.word_lengths.three_character
        #Yumemoire::Player.word_lengths.five_character
        #Yumemoire::Player.word_lengths.seven_character
        Yumemoire::Player.word_legnths.hybrid_compounds

        gets.chomp
      end

      #def self.grammar_generator
      #end

      #def self.procedural_euphemisms
      #end

      #def self.language_statistics
      #end
    end

    def self.visit_pet_archive
      gribatomaton_forms = File.readlines("lib/lifeform/previous_forms.txt")
     
      ## Form information
      gribatomaton_form1 = File.read("lib/lifeform/forms/form_1.txt").strip.to_s
      gribatomaton_form2 = File.read("lib/lifeform/forms/form_2.txt").strip.to_s
      gribatomaton_form3 = File.read("lib/lifeform/forms/form_3.txt").strip.to_s
      gribatomaton_form4 = File.read("lib/lifeform/forms/form_4.txt").strip.to_s
      gribatomaton_form5 = File.read("lib/lifeform/forms/form_5.txt").strip.to_s
      gribatomaton_form6 = File.read("lib/lifeform/forms/form_6.txt").strip.to_s
      gribatomaton_form7 = File.read("lib/lifeform/forms/form_7.txt").strip.to_s

      size_limit         = gribatomaton_form.size.to_i
      index              = File.read("lib/lifeform/index.txt").strip.to_i

      size_limit.times do
        puts gribatomaton_forms[index]

        File.open("lib/lifeform/index.txt", "w") { |f|
          index = index + 1

          f.puts index
        }
      end

      print "What form would you like to research? >> "; research = gets.chomp

      if    "level 1" == research; puts gribatomaton_form1
      elsif "level 2" == research; puts gribatomaton_form2
      elsif "level 3" == research; puts gribatomaton_form3
      elsif "level 4" == research; puts gribatomaton_form4
      elsif "level 5" == research; puts gribatomaton_form5
      elsif "level 6" == research; puts gribatomaton_form6
      elsif "level 7" == research; puts gribatomaton_form7
      else
        puts " >> This form of Gribatomaton does not exist."
      end
    end

    ## Synthesize functions
    def self.synthesize
      def self.colors

        # Consider switching to MD5 or SHA based color generation.
        def self.automixREAL
        end

        def self.automixSYNTH 
        end

        def self.color_theory # Use prolog to research color theory. mostly for developing translator.
        end
      end

      # Syntheize medication that can undo zombie state.
      def self.medicine
      end
    end

    def self.hallucinate_dream
      all_possible_maps = [
        "lib/dreams/map_one", "lib/dreams/map_two",
        "lib/dreams/map_tre", "lib/dreams/map_fro",
        "lib/dreams/map_fiv", "lib/dreams/map_six",
        "lib/dreams/map_sev", "lib/dreams/map_eit",
        "lib/dreams/map_nin", "lib/dreams/map_ten",
        "lib/dreams/map_elv", "lib/dreams/map_twe",
        "lib/dreams/map_thi", "lib/dreams/map_frt",
      ]

      map_one = File.read("lib/dreams/map_one/map.txt").strip.to_s
      map_two = File.read("lib/dreams/map_two/map.txt").strip.to_s
      map_tre = File.read("lib/dreams/map_tre/map.txt").strip.to_s
      map_fro = File.read("lib/dreams/map_fro/map.txt").strip.to_s
      map_fiv = File.read("lib/dreams/map_fiv/map.txt").strip.to_s
      map_six = File.read("lib/dreams/map_six/map.txt").strip.to_s
      map_sev = File.read("lib/dreams/map_sev/map.txt").strip.to_s
      map_eit = File.read("lib/dreams/map_eit/map.txt").strip.to_s
      map_nin = File.read("lib/dreams/map_nin/map.txt").strip.to_s
      map_ten = File.read("lib/dreams/map_ten/map.txt").strip.to_s
      map_elv = File.read("lib/dreams/map_elv/map.txt").strip.to_s
      map_twe = File.read("lib/dreams/map_twe/map.txt").strip.to_s
      map_thi = File.read("lib/dreams/map_thi/map.txt").strip.to_s
      map_frt = File.read("lib/dreams/map_fri/map.txt").strip.to_s
        
      map_number    = File.read("lib/dreams/initializer/map_number.txt").strip.to_s
      map_directory = all_possible_maps[map_number]
      current_map   = "#{map_directory}/map.txt"

      if    current_map == "lib/dreams/map_one/map.txt"; puts map_one 
      elsif current_map == "lib/dreams/map_two/map.txt"; puts map_two
      elsif current_map == "lib/dreams/map_tre/map.txt"; puts map_tre
      elsif current_map == "lib/dreams/map_fro/map.txt"; puts map_fro
      elsif current_map == "lib/dreams/map_fiv/map.txt"; puts map_fiv
      elsif current_map == "lib/dreams/map_six/map.txt"; puts map_six
      elsif current_map == "lib/dreams/map_sev/map.txt"; puts map_sev
      elsif current_map == "lib/dreams/map_eit/map.txt"; puts map_eit
      elsif current_map == "lib/dreams/map_nin/map.txt"; puts map_nin
      elsif current_map == "lib/dreams/map_ten/map.txt"; puts map_ten
      elsif current_map == "lib/dreams/map_elv/map.txt"; puts map_elv
      elsif current_map == "lib/dreams/map_twe/map.txt"; puts map_twe
      elsif current_map == "lib/dreams/map_thi/map.txt"; puts map_thi
      elsif current_map == "lib/dreams/map_frt/map.txt"; puts map_frt
      else
        puts "This Map Is Not Available."
      end
    end

    # Places to visit
    def self.human_locations
      def self.visit_innkeeper
        # Yumemoire::Player.hallucinate_dream Coming soon

      end

      def self.visit_shoe_carpenter # Eventually a subset of shoe store.
      end

      def self.visit_pet_groomer
      end
    end

    def self.zombie_locations
      def self.visit_coffin_keeper # When in zombie status alternative to inn keeper.
      end

      def self.zombie_shoe_carpenter
      end

      def self.visit_zombie_pet_groomer # When in zombie status alternative to pet groomer.
      end
    end

    def self.choose_state
    end
  end

  class Gribatomaton
    def self.initialize
    end

    ## Scouting Actions
    def self.scout_enemy
    end

    def self.scout_player
    end

    ## Attack actions
    def self.attack_enemy
      def self.wildcard_action
      end

      def self.study_player
      end

      def self.guess_player_action
      end
    end

    def self.attack_player
    end

    def self.groom_self
    end

    def self.choose_state
    end
  end

  class Enemy
    def self.initialize
    end

    def self.enemy_innkeeper
    end

    def self.enemy_coffin_keeper
    end

    def self.enemy_shoe_carpenter
    end

    def self.choose_state
      def self.wildcard_action
      end

      def self.study_player
      end

      def self.guess_player_action
      end
    end
  end

  class NPC
    #def self.initialize
    #end

    def self.human_locations
      def self.innkeeper
        if $player_hp > 0
          if $player_yen >= 172
            sleep(1.5)

            puts "\e[38;2;187;127;118mInn Keeper: Have a nice stay!\e[0m"

            $player_hp = $reset_hp
            $player_yen = $player_yen - 172

            sleep(1.5)
          else
            sleep(1.5)

            puts "\e[38;2;187;127;118mInn Keeper: Seems you don't have enough Yen.\e[0m"

            sleep(1.5)
          end
        else
          sleep(1.5)

          puts "\e[38;2;187;127;118mInn Keeper: Seems like you don't need the sleep!\e[0m"

          sleep(1.5)
        end
      end

      def self.shoe_carpenter
      end

      def self.pet_groomer
      end
    end

    def self.zomboe_locations
      def self.coffin_keeper
      end

      def self.zombie_shoe_carpenter
      end

      def self.zombie_pet_groomer
      end
    end
  end
end
