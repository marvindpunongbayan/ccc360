class ClearOutEmailTemplates < ActiveRecord::Migration
  def self.up
    EmailTemplate.delete_all
  end

  def self.down
  end
end
