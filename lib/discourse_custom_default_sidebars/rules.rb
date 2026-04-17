# frozen_string_literal: true

module DiscourseCustomDefaultSidebars
  class Rules
    def self.match(user)
      return nil if user.blank?

      rules = parsed_rules
      return nil if rules.blank?

      locale = user.locale.presence
      return nil if locale.blank?

      rule = rules.find { |r| r["locale"].to_s == locale }
      return nil if rule.nil?

      category_ids = Array(rule["category_ids"])
      return nil if category_ids.empty?

      category_ids.map(&:to_s)
    end

    def self.parsed_rules
      raw = SiteSetting.default_navigation_menu_categories_rules
      return raw if raw.is_a?(Array)
      return [] if raw.blank?

      JSON.parse(raw)
    rescue JSON::ParserError
      []
    end
  end
end
