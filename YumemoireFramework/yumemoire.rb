module Yumemoire
  class Window
    def self.initialize
    end

    def self.menu # Shows the main menu
    end

    def self.minimap # Shows player location
    end

    def self.statistics # Shows statistics hub for player.
    end
  end

  class Player < Window
    def self.initialize
    end

    # Complementary player activities
    def self.encyclopedia
    end

    def self.visit_pet_archive
    end

    def self.synthesize_medicine
    end

    def self.hallucinate_dream
    end

    # Places to visit
    def self.visit_innkeeper
      # Yumemoire::Player.hallucinate_dream Coming soon

    end

    def self.visit_shoe_carpenter # Eventually a subset of shoe store.
    end

    def self.visit_coffin_keeper # When in zombie status alternative to inn keeper.
    end

    def self.visit_pet_groomer
    end

    def self.visit_zombie_pet_groomer # When in zombie status alternative to pet groomer.
    end

    def self.choose_state
    end
  end

  class Gribatomaton < Window
    def self.initialize
    end

    ## Scouting Actions
    def self.scout_enemy
    end

    def self.scout_player
    end

    ## Attack actions
    def self.attack_enemy
    end

    def self.attack_player
    end

    def self.groom_self
    end

    def self.choose_state
    end
  end

  class Enemy < Window
    def self.initialize
    end

    def self.enemy_innkeeper
    end

    def self.enemy_coffin_keeper
    end

    def self.enemy_shoe_carpenter
    end

    def self.choose_state
    end
  end

  class NPC < Window
    def self.initialize
    end

    def self.innkeper
    end

    def self.coffin_keeper
    end

    def self.shoe_carpenter
    end

    def self.zombie_shoe_carpenter
    end

    def self.pet_groomer
    end

    def self.zombie_pet_groomer
    end
  end
end
