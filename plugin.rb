# frozen_string_literal: true

# name: discourse-custom-default-sidebars
# about: Override default_navigation_menu_categories per user via rules
# meta_topic_id: TODO
# version: 0.0.1
# authors: Discourse
# url: TODO
# required_version: 2.7.0

enabled_site_setting :discourse_custom_default_sidebars_enabled

module ::DiscourseCustomDefaultSidebars
  PLUGIN_NAME = "discourse-custom-default-sidebars"
end

require_relative "lib/discourse_custom_default_sidebars/engine"
require_relative "lib/discourse_custom_default_sidebars/rules"

after_initialize do
  register_modifier(:default_navigation_categories) do |default_categories, opts|
    user = opts.is_a?(Hash) ? opts[:user] : opts
    custom = ::DiscourseCustomDefaultSidebars::Rules.match(user)
    custom || default_categories
  end
end
