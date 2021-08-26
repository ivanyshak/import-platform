class Import < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader

  has_many :customers, dependent: :destroy

  validates :title, presence: true

  enum state: [:created, :started, :completed]

  scope :w_query, -> (q) { where(title: q) if q.present? }

  def self.search(params)
    w_query(params[:query])
  end
end
