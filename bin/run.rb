require_relative '../config/environment.rb'

LeagueCLI.greeting
input = "ok"
 while input != "Exit"
  input = LeagueCLI.get_search_item
  if input == "List"
    LeagueInfo.get_champion_name_list.each.with_index(1) do |champion, index|
      puts "#{index}. #{champion}"
    end
  elsif LeagueInfo.get_champion_name_list.detect {|champ| champ == input}
    LeagueCLI.start(input)
  elsif input != "Exit"
    puts "That is not a League of Legends Champion, or there was a typo. Please try again, or type exit."
    puts ""
  else
    puts "Thank you for using the League of Legends Champion info tool!"
  end
  LeagueCLI.greeting
end