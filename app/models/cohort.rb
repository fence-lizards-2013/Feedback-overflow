class Cohort < ActiveRecord::Base
  include SocratesScrapper
  attr_accessible :name, :location, :status, :email, :cohort_id
  has_many :users

  def self.scrapper
    url = 'http://socrates.devbootcamp.com/login'
    agent = Mechanize.new
    scrapper = Scrapper.new(agent, url)
    cohorts = scrapper.start!
    cohorts.each do |cohort|
      Cohort.create!(cohort)
    end
  end
end
