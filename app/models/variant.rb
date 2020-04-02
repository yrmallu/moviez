class Variant < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  belongs_to :content

  def price_in_dollars
    number_to_currency price
  end
end