class AddAnswerableToAnswers < ActiveRecord::Migration
  def change
    add_reference :answers, :answerable, polymorphic: true, index: true
  end
end
