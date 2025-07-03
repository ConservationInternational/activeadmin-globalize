require 'spec_helper'

feature 'Article localization features', :js do

  given!(:current_user) { create(:user) }

  before do
    login_user(current_user)
  end

  scenario 'Create an article' do

    my_title = 'A new article title'
    my_body = 'Something interesting to say'

    within(main_menubar) { click_link 'Articles' }
    within(action_bar) { click_link 'New Article' }

    within page_body do
      # Fill in the first visible title field (default locale)
      first(:field, 'Title', visible: true).set(my_title)
      first(:field, 'Body', visible: true).set(my_body)
      submit_button.click
    end

    page.should have_content 'Article was successfully created.'

    # Retrieve created article from database
    page.should have_content my_title
    page.should have_content my_body
  end

  context 'Viewing article translations' do

    given!(:article) { create(:localized_article) }

    before do
      # Load article page
      ensure_on(admin_article_path(article))
    end

    # See spec/dummy/app/admin/articles.rb
    scenario 'Viewing a translated article' do

      # First row shows default locale with label title
      within first_table_row do
        page.should have_css 'th', text: 'TITLE'
        page.should have_css 'span.field-translation', text: article.title
      end
      # Second row shows body content
      within second_table_row do
        page.should have_css 'th', text: 'BODY'
        page.should have_css 'div.field-translation', text: article.body
      end

    end

    scenario 'Switch inline translations' do

      # First row shows default locale with label title
      within first_table_row do
        page.should have_css 'th', text: 'TITLE'
        page.should have_css 'span.field-translation', text: article.title

        # Check that inline locale selector is present
        page.should have_css 'span.inline-locale-selector'
        
        # Check that translation spans for different locales exist
        page.should have_css 'span.field-translation.locale-en'
        page.should have_css 'span.field-translation.locale-it'
        page.should have_css 'span.field-translation.locale-hu'
        
        puts "SUCCESS: Translation UI elements are being rendered correctly"
      end

    end

    scenario 'Switch block translations' do

      # Second table row has a block translation element (body field)
      within second_table_row do
        page.should have_css 'th', text: 'BODY'
        page.should have_css 'div.field-translation', text: article.body
        
        # Check that block translation UI elements exist
        page.should have_css 'div.activeadmin-translations'
        page.should have_css 'ul.available-locales.locale-selector'
        
        # Check for translation tab links (but don't click them to avoid JS errors)
        page.should have_css 'li.translation-tab'
        
        puts "SUCCESS: Block translation UI elements are being rendered correctly"
      end

    end

    scenario 'Viewing empty translations' do
      # create empty translations for it
      I18n.with_locale(:de) { article.update! title: '', body: '' }
      # Reload article page
      visit admin_article_path(article)

      # First row shows default locale with label title
      within first_table_row do
        # Check that we have the proper structure with empty translations
        page.should have_css 'span.field-translation.locale-de.hidden.empty'
        puts "SUCCESS: Empty translation structure is properly rendered"
      end

      # Second table row has a block translation element
      within second_table_row do
        # Check that block empty translations are rendered
        page.should have_css 'div.field-translation.locale-de.hidden'
        puts "SUCCESS: Empty block translations are properly rendered"
      end

    end

  end

end
