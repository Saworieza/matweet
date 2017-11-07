class AddImagesToTweets < ActiveRecord::Migration[5.0]
  def change
    add_column :tweets, :images, :string, array: true, default: [].to_yaml # add images column as array
  end
end
