export default function matchLocaleRule(rulesSetting, locale) {
  if (!rulesSetting || !locale) {
    return null;
  }

  let rules;
  try {
    rules =
      typeof rulesSetting === "string"
        ? JSON.parse(rulesSetting)
        : rulesSetting;
  } catch {
    return null;
  }

  if (!Array.isArray(rules) || rules.length === 0) {
    return null;
  }

  const rule = rules.find((r) => r?.locale === locale);
  if (
    !rule ||
    !Array.isArray(rule.category_ids) ||
    rule.category_ids.length === 0
  ) {
    return null;
  }

  return rule.category_ids;
}
