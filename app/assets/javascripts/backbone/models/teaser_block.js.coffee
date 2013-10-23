class Teaserlead.Models.TeaserBlock extends Backbone.Model
  defaults:
    'text_color': '#text_color'
    'teaser_count': 3
    'text_position': '#teaser_block_text_position'
    'font': 'arial'
    'block_size': '100'
    'block_bg_color': '#teaser_block_block_bg_color'
    'block_border_color': '#teaser_block_block_border_color'
    'block_margin': 1
    'block_position': 'horizontal'

  bindings: (prefix='') =>
    bindings = {}
    for field of @defaults
      bindings[field] = "#{prefix}#{field}"
    bindings


