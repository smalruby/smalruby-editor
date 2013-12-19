class AddFilenameToSourceCode < ActiveRecord::Migration
  def change
    add_column :source_codes, :filename, :string
  end
end
