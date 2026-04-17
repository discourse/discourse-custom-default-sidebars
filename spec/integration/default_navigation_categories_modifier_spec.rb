# frozen_string_literal: true

describe ":default_navigation_categories modifier" do
  fab!(:default_category, :category)
  fab!(:french_category, :category)

  before do
    enable_current_plugin
    SiteSetting.default_navigation_menu_categories = default_category.id.to_s
    SiteSetting.default_navigation_menu_categories_rules = [
      { "locale" => "fr", "category_ids" => [french_category.id] },
    ].to_json
  end

  it "gives an English-locale user the default categories" do
    user = Fabricate(:user, locale: "en")

    category_ids =
      SidebarSectionLink.where(user: user, linkable_type: "Category").pluck(:linkable_id)

    expect(category_ids).to contain_exactly(default_category.id)
  end

  it "gives a French-locale user the rule's categories instead of the defaults" do
    user = Fabricate(:user, locale: "fr")

    category_ids =
      SidebarSectionLink.where(user: user, linkable_type: "Category").pluck(:linkable_id)

    expect(category_ids).to contain_exactly(french_category.id)
    expect(category_ids).not_to include(default_category.id)
  end

  it "falls back to the defaults when the user has no explicit locale" do
    user = Fabricate(:user, locale: nil)

    category_ids =
      SidebarSectionLink.where(user: user, linkable_type: "Category").pluck(:linkable_id)

    expect(category_ids).to contain_exactly(default_category.id)
  end
end
