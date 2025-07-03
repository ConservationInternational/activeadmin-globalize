class TranslateArticles < ActiveRecord::Migration[7.0]
  def up
    Article.create_translation_table! title: :string, body: {type: :text}
  end

  def down
    Article.drop_translation_table!
  end
end
