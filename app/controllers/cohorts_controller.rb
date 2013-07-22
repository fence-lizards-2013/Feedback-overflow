class CohortsController < ApplicationController
  def index
    @cohorts = Cohort.all
  end
end
