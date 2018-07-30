class Beer < ApplicationRecord
  has_many :creators, dependent: :destroy
  has_many :tips, dependent: :destroy
  has_many :beer_volumes
  has_many :volumes, through: :beer_volumes
  validates_presence_of :name
  accepts_nested_attributes_for :creators, reject_if: :reject_creators
  accepts_nested_attributes_for :tips, reject_if: :reject_tips
  accepts_nested_attributes_for :volumes, reject_if: :reject_volumes

  def reject_creators(attributes)
    attributes['name'].blank?
  end

  def reject_tips(attributes)
    attributes['description'].blank?
  end

  def reject_volumes(attributes)
    attributes['unit'].blank? && attributes['value'].blank?
  end
end
