class Teaserlead.Views.TeaserBlockVertical extends Backbone.Marionette.ItemView
  template: JST["backbone/templates/teaser_block_vertical"]

  onRender: ->
    console.log 'render', @model


