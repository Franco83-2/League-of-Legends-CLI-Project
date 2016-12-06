class LeagueCLI

  def self.greeting
    puts "Welcome to the League of Legends Champion info tool. Here you can find information about any League of Legends Champion."
    puts "Please input a champion name to get started, or type list to get a list of all available champions. Type exit to exit!"
  end

  def self.get_search_item
    gets.strip.downcase.capitalize
  end

  def self.start(input)
    choice = "hi"
    while choice != "back"
    puts "What information would you like to obtain? You can choose from:"
    puts "Lore, Abilities, Tips, and Skins"
    puts "You can also type \"back\" to go to the main menu."
    choice = gets.downcase.strip
      if choice == "lore" 
        Ascii.lore
        puts LeagueInfo.get_champion_lore(input)
        puts ""
      elsif choice == "skins"
        Ascii.skins
        puts LeagueInfo.get_champion_skins(input)
        puts ""
      elsif choice == "tips"
        Ascii.tips
        LeagueInfo.get_champion_tips(input) 
        puts ""
      elsif choice == "abilities"
        Ascii.abilities
        LeagueInfo.get_champion_abilities(input) 
        puts ""
      elsif choice != "back"
        puts "Type \"back\" to go to the main menu, or pick another set of information to check"
        puts ""
      end
   end
  end


end