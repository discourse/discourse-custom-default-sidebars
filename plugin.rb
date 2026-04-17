# frozen_string_literal: true

# name: discourse-custom-default-sidebars
# about: TODO
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

after_initialize do
  # Code which should run after Rails has finished booting
end
