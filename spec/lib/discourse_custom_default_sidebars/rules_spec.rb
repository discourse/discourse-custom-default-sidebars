# frozen_string_literal: true

describe DiscourseCustomDefaultSidebars::Rules do
  fab!(:category_us, :category)
  fab!(:category_fr, :category)

  before { enable_current_plugin }

  describe ".match" do
    it "returns category ids as strings when a rule matches the user's locale" do
      SiteSetting.default_navigation_menu_categories_rules = [
        { "locale" => "fr", "category_ids" => [category_fr.id] },
      ].to_json

      user = Fabricate(:user, locale: "fr")

      expect(described_class.match(user)).to eq([category_fr.id.to_s])
    end

    it "returns nil when no rule matches" do
      SiteSetting.default_navigation_menu_categories_rules = [
        { "locale" => "fr", "category_ids" => [category_fr.id] },
      ].to_json

      user = Fabricate(:user, locale: "en")

      expect(described_class.match(user)).to be_nil
    end

    it "returns nil when the user has no explicit locale set" do
      SiteSetting.default_navigation_menu_categories_rules = [
        { "locale" => "fr", "category_ids" => [category_fr.id] },
      ].to_json

      user = Fabricate(:user, locale: nil)

      expect(described_class.match(user)).to be_nil
    end

    it "returns nil when the rules setting is empty" do
      SiteSetting.default_navigation_menu_categories_rules = "[]"

      user = Fabricate(:user, locale: "fr")

      expect(described_class.match(user)).to be_nil
    end

    it "picks the first matching rule when multiple share a locale" do
      SiteSetting.default_navigation_menu_categories_rules = [
        { "locale" => "fr", "category_ids" => [category_fr.id] },
        { "locale" => "fr", "category_ids" => [category_us.id] },
      ].to_json

      user = Fabricate(:user, locale: "fr")

      expect(described_class.match(user)).to eq([category_fr.id.to_s])
    end
  end
end
