class Asset < ApplicationRecord
  belongs_to :content
  validates :sequence_number, uniqueness: {scope: :content_id}, presence: true
  default_scope { order(sequence_number: :asc) }
end