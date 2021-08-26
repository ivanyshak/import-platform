class Customer < ApplicationRecord
  # relation was implemented to know to which import current customer related
  belongs_to :import

  validates_length_of :first_name, minimum: 2, allow_blank: false
  validates :email, email: { mode: :strict }, uniqueness: true
  validates :date_of_birth, presence: true
  validate :validate_age

  # search in customer table implemented by first_name, last_name and email fields
  scope :w_query, -> (q) { where('first_name ILIKE :q OR last_name ILIKE :q OR email ILIKE :q', q: "%#{q}%") if q.present? }

  def self.search(params)
    w_query(params[:query])
  end

  private
  # this custom validation should validate if Customer is older 18 and younger 100
  def validate_age
    if date_of_birth.present? && (date_of_birth > 18.years.ago.to_date || date_of_birth < 100.years.ago.to_date)
        errors.add(:date_of_birth, 'You should be over 18 years old.')
    end
  end
end
