$ ->
  if $("#graph").length > 0
    palette = new Rickshaw.Color.Palette()
    graph = new Rickshaw.Graph
      element: document.querySelector("#graph")
      width: 580
      height: 250
      renderer: 'bar'
      series: [
        {
          data: JSON.parse($('#buy_graph_data').text())
          color: palette.color()
        }
        #{
          #data: JSON.parse($('#sell_graph_data').text())
          #color: palette.color()
        #}
      ]

    x_axis = new Rickshaw.Graph.Axis.Time( { graph: graph } )

    scale = d3.scale.linear().domain([200, 1000])
    y_axis = new Rickshaw.Graph.Axis.Y.Scaled(
      graph: graph
      orientation: 'left'
      tickFormat: Rickshaw.Fixtures.Number.formatKMBT
      element: document.getElementById('y_axis')
      scale: scale
    )
    graph.render()
