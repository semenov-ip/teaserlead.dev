class Widgets.TeaserBlockConstructor

  constructor: (@container, @options) ->
    $(@container).find("#teaser_image").fileupload
      autoupload: false
      previewMaxWidth: 100
      previewMaxHeight: 100
      add: (e, data) =>
        data.context = $('<div/>').appendTo('#files');
        $.each data.files, (index, file) ->
            node = $('<p/>').append($('<span/>').text(file.name))
            console.log file.preview
            if  file.preview
              node.prepend('<br>').prepend(file.preview)
            node.appendTo(data.context)
