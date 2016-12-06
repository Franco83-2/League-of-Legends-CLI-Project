class Scrape
  SPELLS = ["Barrier","Clairvoyance","Clarity","Cleanse","Exhaust","Flash","Fortify","Garrison","Ghost","Heal","Ignite","Mark/Dash","Promote","Rally","Revive","Smite","Surge","Teleport"]
  
  def self.main_page
    base_url = "http://www.mobafire.com/league-of-legends/champions"
    html = open(base_url)
    index = Nokogiri::HTML(html)
  end

  def self.champion_page(champion)
    champion = self.champion_substituter(champion)
    data = self.main_page
    data.css(".champ-box").each do |box|
      if champion.downcase == box.css(".info .champ-name").text.downcase
         return "http://www.mobafire.com" + box.attr('href')
      end
    end
  end

  def self.champion_substituter(champion)
    if champion == "velkoz"
      champion = "vel'koz"
    elsif champion == "chogath"
      champion = "cho'gath"
    else
      return champion
    end
  end

  def self.guide_page(champion)
    base_url = self.champion_page(champion)
    html = open(base_url)
    index = Nokogiri::HTML(html)

  end

  def self.guide_info_link(champion)
    data = self.guide_page(champion)
    return "http://www.mobafire.com" + data.css(".complete-build .title a").attr('href')
  end

    def self.guide_info(champion)
    base_url = self.guide_info_link(champion)
    html = open(base_url)
    index = Nokogiri::HTML(html)
  end

  def self.guide_recommendations(champion)
    data = self.guide_info(champion)
    summs = self.summoner_spells(data)
    puts summs
  end

    def self.summoner_spells(data)
        data.css(".build-spells a").map do |link|
      SPELLS.map do |spell|
        if link.attr('href').downcase.include?(spell.downcase)
          spell
        end
      end
    end.flatten.compact
  end

end

#Scrape.guide_recommendations("chogath")