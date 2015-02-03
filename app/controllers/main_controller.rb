class MainController < ApplicationController
  
  def index
    @markov = Rails.application.config.en_markov.generate_sentence 4
  end
  
end
