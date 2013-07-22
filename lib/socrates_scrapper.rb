module SocratesScrapper
  class Scrapper

    def initialize agent, url
      @agent = agent
      @page = load_socrates_page(url)
    end

    def load_socrates_page url
      @agent.get(url)
    end

    def submit_form
      form = @page.form
      form.email = ENV['SOCRATES_EMAIL']
      form.password = ENV['SOCRATES_PASSWORD']
      form.submit
    end

    def go_to_cohorts_path id
      @agent.get("http://socrates.devbootcamp.com/cohorts/#{id}")
    end

    def scrape_cohort_name page
      page.search('h1').text.delete("\n")
    end

    def scrape_cohort_page page
      labels = [:location, :status, :email]
      attributes = page.search('.muted').text.split("\n").reject(&:empty?)
      Hash[labels.zip(attributes)]
    end

    def scrape_cohort id
      page = go_to_cohorts_path(id)
      attributes = scrape_cohort_page(page)
      cohort = {
                  name: scrape_cohort_name(page),
                  location: attributes[:location],
                  status: attributes[:status],
                  email: attributes[:email],
                  cohort_id: id
      }
      cohort
    end

    def start!
      cohorts = []
      submit_form
      1.upto(20) do |cohort_id|
        begin
          cohorts << scrape_cohort(cohort_id)
        rescue
          next
        end
      end
      cohorts
    end
  end
end

