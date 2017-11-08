class AddAttachmentMediaToTweets < ActiveRecord::Migration
  def self.up
    change_table :tweets do |t|
      t.attachment :media
    end
  end

  def self.down
    remove_attachment :tweets, :media
  end
end
