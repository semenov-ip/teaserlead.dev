class Teaserlead.Views.TeaserBlockConstructor extends Backbone.Marionette.Layout
  template: '#teaser-block-constructor-template'

  regions:
    preview: '.block-preview'

  modelEvents:
    'change': 'render_preview'

  initialize: =>
    @model = new Teaserlead.Models.TeaserBlock
    @modelBinder =new Backbone.ModelBinder
    @bindings = @model.bindings('#teaser_block_')
    super()

  onRender: ->
    $('.colorpicker').minicolors 
      theme: 'bootstrap'
      hide: (hex, _) ->
        $(@).trigger 'change'
    @modelBinder.bind @model, @el, @bindings
    @render_preview()

  onClose: ->
    @modelBinder.unbind()

  render_preview: () =>
    console.log 'model:', @model
    block = new Teaserlead.Views.TeaserBlockVertical(model: @model)
    @preview.show(block)

