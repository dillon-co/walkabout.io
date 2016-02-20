class AddImagesToPages < ActiveRecord::Migration
  def change
    add_column :pages, :images, :text, array: true, default: []
  end
end
