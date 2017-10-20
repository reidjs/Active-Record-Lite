class Company < ApplicationRecord
  # belongs_to :board,
  # class_name: :Board,
  # primary_key: :id,
  # foreign_key: :company_id

  belongs_to :parent_company,
  class_name: :Company,
  primary_key: :id,
  foreign_key: :parent_company_id,
  optional: true

  belongs_to :exchange,
  class_name: :Exchange,
  primary_key: :id,
  foreign_key: :exchange_id,
  optional: true




end
