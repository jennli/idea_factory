class AddAvatarColumnToIdea < ActiveRecord::Migration
  def up
    add_attachment :ideas, :avatar
  end

  def down
    remove_attachment :ideas, :avatar
  end
end
