class Article < ApplicationRecord
  # Translated fields with globalize and for active admin
  active_admin_translates :title, :body

  # Ransack allowlist for searchable associations
  def self.ransackable_associations(auth_object = nil)
    ["translations"]
  end

  # Ransack allowlist for searchable attributes
  def self.ransackable_attributes(auth_object = nil)
    ["id", "title", "body", "created_at", "updated_at"]
  end

  # Add ransackable_attributes to the translation model
  class Translation < Globalize::ActiveRecord::Translation
    def self.ransackable_attributes(auth_object = nil)
      ["article_id", "body", "created_at", "id", "locale", "title", "updated_at"]
    end
  end

end
