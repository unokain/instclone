class DropTableFeeds < ActiveRecord::Migration[5.2]
  def change
    drop_table :feeds
  end
end
