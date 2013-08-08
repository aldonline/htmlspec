
cached = null

module.exports.tags = -> cached ?= do build_tags

###
We will add more and more properties as we need them.
Like valid attributes, events, lifecycle considerations, etc
###
class Tag
  constructor: ( @opts ) ->
  name: -> @opts.name
  obsolete: -> @opts.obsolete?
  self_closing: -> @opts.self_closing?

build_tags = ->

  m = {}

  # Valid HTML 5 elements requiring a closing tag.
  regular = 'a abbr address article aside audio b bdi bdo blockquote body button
 canvas caption cite code colgroup datalist dd del details dfn div dl dt em
 fieldset figcaption figure footer form h1 h2 h3 h4 h5 h6 head header hgroup
 html i iframe ins kbd label legend li map mark menu meter nav noscript object
 ol optgroup option output p pre progress q rp rt ruby s samp script section
 select small span strong style sub summary sup table tbody td textarea tfoot
 th thead time title tr u ul var video'

  # Valid self-closing HTML 5 elements.
  self_closing = 'area base br col command embed hr img input keygen link meta param
 source track wbr'

  obsolete = 'applet acronym bgsound dir frameset noframes isindex listing
 nextid noembed plaintext rb strike xmp big blink center font marquee multicol
 nobr spacer tt'

  obsolete_self_closing = 'basefont frame'

  m[k.trim()] = new Tag( name: k ) for k in regular.split ' '
  m[k.trim()] = new Tag( name: k, self_closing: yes ) for k in self_closing.split ' '
  m[k.trim()] = new Tag( name:k, obsolete: yes ) for k in obsolete.split ' '
  m[k.trim()] = new Tag( name:k, obsolete: yes, self_closing: yes) for k in obsolete_self_closing.split ' '

  m