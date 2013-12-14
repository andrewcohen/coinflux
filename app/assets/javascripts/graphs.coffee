$ ->
  graph = new Rickshaw.Graph
    element: document.querySelector("#graph")
    width: 580
    height: 250
    series: [
      {
        data: JSON.parse($('#buy_graph_data').text())
        color: 'steelblue'
      },
      {
        data: JSON.parse($('#sell_graph_data').text())
        color: 'orange'
      }
    ]

  graph.render()
