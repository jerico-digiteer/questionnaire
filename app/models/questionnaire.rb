class Questionnaire < ApplicationRecord
    has_many :questions, dependent: :destroy
    has_many :responses, dependent: :destroy
    accepts_nested_attributes_for :questions, allow_destroy: true
  end