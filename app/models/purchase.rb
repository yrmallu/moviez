class Purchase < ApplicationRecord
  include ActionView::Helpers::DateHelper

  belongs_to :user
  belongs_to :content
  belongs_to :variant

  before_create :set_expires_at
  after_create :expire_user_cache

  default_scope { order(expires_at: :asc) }

  scope :alive, lambda { where("expires_at > ?", Time.now) }
  scope :dead, lambda { where("expires_at < ?", Time.now) }

  validate :is_not_a_duplicate_purchase, on: :create

  def expires_in
    distance_of_time_in_words(self.expires_at, Time.now)
  end

  def is_not_a_duplicate_purchase
    if self.user.purchases.alive.where(content: self.content).first
      errors.add(:base, "You've already purchased this item.")
    end
  end

  def expire_user_cache
    user.expire_library_cache
  end


  private

  def set_expires_at
    self.expires_at = Time.now + 2.days
  end

end