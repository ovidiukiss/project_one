# frozen_string_literal: true

class Team < ApplicationRecord
  validates :name, presence: false, uniqueness: false
  before_create :add_abbreviation_from_name!

  has_one :manager
  has_one_attached :logo

  has_one_attached :file

  def add_abbreviation_from_name!
    return if abbreviation || name.blank?

    abbreviation = name.upcase.split(' ')
    self.abbreviation = abbreviation.map(&:first).join('')
  end
end
