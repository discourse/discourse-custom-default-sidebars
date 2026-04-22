# frozen_string_literal: true

describe "Default navigation categories rules" do
  fab!(:default_category) { Fabricate(:category, name: "General") }
  fab!(:french_category) { Fabricate(:category, name: "Francophone") }

  let(:sidebar) { PageObjects::Components::NavigationMenu::Sidebar.new }

  before do
    enable_current_plugin
    SiteSetting.navigation_menu = "sidebar"
    SiteSetting.default_navigation_menu_categories = default_category.id.to_s
    SiteSetting.default_navigation_menu_categories_rules = [
      { "locale" => "fr", "category_ids" => [french_category.id] },
    ].to_json
  end

  it "shows the default category in the sidebar for a user without a matching locale rule" do
    user = Fabricate(:user, locale: "en")
    sign_in(user)

    visit("/latest")

    expect(sidebar).to have_section_link(default_category.name)
    expect(sidebar).to have_no_section_link(french_category.name)
  end

  it "shows the rule's category in the sidebar for a user whose locale matches a rule" do
    user = Fabricate(:user, locale: "fr")
    sign_in(user)

    visit("/latest")

    expect(sidebar).to have_section_link(french_category.name)
    expect(sidebar).to have_no_section_link(default_category.name)
  end
end
