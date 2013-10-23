$ ->
  $('.teaser-block-constructor-js').each (i, c) ->
    #new Widgets.TeaserBlockConstructor c
    window.layout = new Teaserlead.Views.TeaserBlockConstructor(el: c)
    layout.render()
  $('.graph-js').each (i, c) ->
    $.getJSON "http://www.highcharts.com/samples/data/jsonp.php?filename=aapl-c.json&callback=?", (data) ->
      $(c).highcharts "StockChart",
        rangeSelector:
          selected: 1

        title:
          text: "Статистика просмотров"

        series: [
          name: "AAPL"
          data: data
          tooltip:
            valueDecimals: 2
        ]
