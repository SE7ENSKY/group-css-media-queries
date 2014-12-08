(function() {
  var parse, stringify;

  parse = require('css-parse');

  stringify = require('css-stringify');

  module.exports = function(css) {
    var match, media, mediaRules, medias, parsed, rootRules, rule, rules, valueMQ, _i, _len, _ref;
    parsed = parse(css);
    medias = {};
    rootRules = [];
    _ref = parsed.stylesheet.rules;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      rule = _ref[_i];
      if (rule.type === 'media') {
        if (!medias[rule.media]) {
          medias[rule.media] = [];
        }
        medias[rule.media] = medias[rule.media].concat(rule.rules);
      } else {
        rootRules.push(rule);
      }
    }
    mediaRules = [];
    for (media in medias) {
      rules = medias[media];
      match = media.match(/\(min-width: ([0-9]*)px\)/);
      if (match && match[1]) {
        valueMQ = match[1];
      }
      mediaRules.push({
        type: "media",
        media: media,
        rules: rules,
        mqValue: valueMQ
      });
    }
    mediaRules.sort(function(a, b) {
      if (a.mqValue && b.mqValue) {
        return a.mqValue - b.mqValue;
      } else {
        return 0;
      }
    });
    parsed.stylesheet.rules = rootRules.concat(mediaRules);
    return stringify(parsed);
  };

}).call(this);
