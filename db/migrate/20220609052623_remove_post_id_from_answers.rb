class RemovePostIdFromAnswers < ActiveRecord::Migration
  def change
    remove_column :answers, :post_id, :integer
  end
end
