# take gorgeous visionmedia's css utilities
parse = require 'css-parse'
stringify = require 'css-stringify'

module.exports = (css, split) ->
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
		mediaRules.push
			type: "media"
			media: media
			rules: rules

	# output
	if not split
		stringify parsed
	# or send array
	else
		[rootRules].concat mediaRules
		
