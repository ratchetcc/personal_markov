class MainController < ApplicationController
  def index
    @markov = Rails.application.config.markov_generator.generate_sentence
  end
end
