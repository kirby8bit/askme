class ChangeColorDefaultValueInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :color, '#370617'
  end
end
