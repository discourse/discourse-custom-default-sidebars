import { apiInitializer } from "discourse/lib/api";
import I18n from "discourse-i18n";
import matchLocaleRule from "../lib/match-locale-rule";

export default apiInitializer((api) => {
  const siteSettings = api.container.lookup("service:site-settings");
  api.registerValueTransformer(
    "sidebar-anonymous-default-categories",
    ({ value }) => {
      if (!siteSettings.discourse_custom_default_sidebars_enabled) {
        return value;
      }
      if (!siteSettings.apply_rules_to_anonymous_users) {
        return value;
      }

      const override = matchLocaleRule(
        siteSettings.default_navigation_menu_categories_rules,
        I18n.locale
      );

      return override ?? value;
    }
  );
});
