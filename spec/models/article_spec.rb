require 'spec_helper'

# Model taken from the dummy app
describe Article do
  it 'is translatable' do
    expect(Article.translates?).to be(true)
  end

  describe 'localized article' do
    let(:article) { create(:localized_article) }
    subject { article }

    it { is_expected.to have(3).translations }

    it 'has an Italian translation' do
      I18n.with_locale :it do
        expect(article.title).to eq('Italian title')
        expect(article.body).to eq('Italian Body')
      end
    end

    it 'has a Hungarian translation' do
      I18n.with_locale :hu do
        expect(article.title).to eq('Article title')
        expect(article.body).to eq('Hungarian Body')
      end
    end
  end
end
