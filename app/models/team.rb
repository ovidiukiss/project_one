# frozen_string_literal: true

class Team < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  before_create :add_abbreviation_from_name!

  has_one :manager
  has_one_attached :logo

  def add_abbreviation_from_name!
    return if abbreviation

    abbreviation = name.upcase.split(' ')
    self.abbreviation = abbreviation.map(&:first).join('')
  end
end
