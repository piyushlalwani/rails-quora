class Answer < ActiveRecord::Base
  has_many :answers, :as => :answerable
  belongs_to :answerable, :polymorphic => true
  belongs_to :user
end
