class BoardMembership < ApplicationRecord
  belongs_to :board,
  class_name: :Board,
  primary_key: :id,
  foreign_key: :board_id

  belongs_to :member,
  class_name: :User,
  primary_key: :id,
  foreign_key: :member_id


end
