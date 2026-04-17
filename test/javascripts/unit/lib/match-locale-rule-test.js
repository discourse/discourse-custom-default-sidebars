import { module, test } from "qunit";
import matchLocaleRule from "discourse/plugins/discourse-custom-default-sidebars/discourse/lib/match-locale-rule";

module(
  "Discourse Custom Default Sidebars | Unit | lib | match-locale-rule",
  function () {
    test("returns the rule's category ids when a locale matches", function (assert) {
      const rules = JSON.stringify([
        { locale: "fr", category_ids: [10, 20] },
        { locale: "en", category_ids: [1] },
      ]);

      assert.deepEqual(matchLocaleRule(rules, "fr"), [10, 20]);
    });

    test("accepts an already-parsed array", function (assert) {
      const rules = [{ locale: "fr", category_ids: [10, 20] }];

      assert.deepEqual(matchLocaleRule(rules, "fr"), [10, 20]);
    });

    test("returns null when no rule matches the locale", function (assert) {
      const rules = JSON.stringify([{ locale: "fr", category_ids: [10] }]);

      assert.strictEqual(matchLocaleRule(rules, "en"), null);
    });

    test("returns null when the rules setting is empty or blank", function (assert) {
      assert.strictEqual(matchLocaleRule("", "fr"), null);
      assert.strictEqual(matchLocaleRule(null, "fr"), null);
      assert.strictEqual(matchLocaleRule(undefined, "fr"), null);
      assert.strictEqual(matchLocaleRule("[]", "fr"), null);
    });

    test("returns null when the locale is blank", function (assert) {
      const rules = JSON.stringify([{ locale: "fr", category_ids: [10] }]);

      assert.strictEqual(matchLocaleRule(rules, ""), null);
      assert.strictEqual(matchLocaleRule(rules, null), null);
      assert.strictEqual(matchLocaleRule(rules, undefined), null);
    });

    test("returns null when the matched rule has no category_ids", function (assert) {
      const rules = JSON.stringify([{ locale: "fr", category_ids: [] }]);

      assert.strictEqual(matchLocaleRule(rules, "fr"), null);
    });

    test("picks the first rule when multiple match the same locale", function (assert) {
      const rules = JSON.stringify([
        { locale: "fr", category_ids: [10] },
        { locale: "fr", category_ids: [99] },
      ]);

      assert.deepEqual(matchLocaleRule(rules, "fr"), [10]);
    });

    test("returns null when the rules payload is invalid JSON", function (assert) {
      assert.strictEqual(matchLocaleRule("{not valid", "fr"), null);
    });
  }
);
