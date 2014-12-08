# take gorgeous visionmedia's css utilities
parse = require 'css-parse'
stringify = require 'css-stringify'

module.exports = (css) ->
	# parse it
	parsed = parse css

	# extract and group medias and root rules
	medias = {}
	rootRules = []
	for rule in parsed.stylesheet.rules
		if rule.type is 'media'
			medias[rule.media] = [] if not medias[rule.media]
			medias[rule.media] = medias[rule.media].concat rule.rules
		else
			rootRules.push rule

	# generate media rules
	mediaRules = []
	for media, rules of medias
		# get possible min-width value, for later sorting
		match = media.match(/\(min-width: ([0-9]*)px\)/)
		valueMQ = match[1] if (match and match[1])

		mediaRules.push
			type: "media"
			media: media
			rules: rules
			mqValue: valueMQ

	# sort Media Rules array by min-width
	mediaRules.sort (a, b) -> (
		if a.mqValue and b.mqValue # only if there's min-width on both MQs
			a.mqValue - b.mqValue
		else # if there's no min-width on these MQs
			0 # don't sort — leave as equal
	)

	# modify parsed AST
	parsed.stylesheet.rules = rootRules.concat mediaRules

	# output
	stringify parsed
