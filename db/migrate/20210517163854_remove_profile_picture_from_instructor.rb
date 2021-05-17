class RemoveProfilePictureFromInstructor < ActiveRecord::Migration[6.1]
  def change
    remove_column :instructors, :profile_picture, :string
  end
end
