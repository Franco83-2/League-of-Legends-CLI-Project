class LeagueInfo

  def self.get_info_hash
    info = RestClient.get("https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?champData=all&api_key=RGAPI-780468b9-126f-452c-9602-3129eb592c12")
    info_hash = JSON.parse(info)
    info_hash
  end

  def self.get_champion_name_list 
    self.get_info_hash.map do |key, value|
      if key == "data"
        value.map {|k, v| k}
      end
    end.compact.flatten.sort
  end

  def self.get_champion_info_full(champion)
        self.get_info_hash.map do |key, value|
      if key == "data"
        value.each do |k, v| 
          if k == champion
            return v
          end
        end
      end
    end
  end

  def self.get_champion_lore(champion)
    data = self.get_champion_info_full(champion)
    data["lore"].gsub(/(?i)<br[^>]*>/, "").gsub(/\'\'/,"")
  end

  def self.get_champion_skins(champion)
    data = self.get_champion_info_full(champion)
    data["skins"].map do |skin, data|
      skin["name"] if skin["name"] != "default"
    end
  end

  def self.get_champion_abilities(champion)
    data = self.get_champion_info_full(champion)
    abilities = "QWER"
    index = -1
      data["spells"].map do |spell, data|
        puts "#{abilities[index+1]} Ability : #{spell["name"]}"
        puts "#{spell["description"]}"
        puts ""
        index += 1
      end
    end

    def self.get_champion_tips(champion)
    data = self.get_champion_info_full(champion)
      puts "                 Tips for Allies:"
      puts ""
      data["allytips"].each.with_index(1) {|tip, index| puts "#{index}. #{tip}"}
      puts ""
      puts "                 Tips for Enemies:"
      #binding.pry
      puts ""
      data["enemytips"].each.with_index(1) {|tip, index| puts "#{index}. #{tip}"}
    end

end