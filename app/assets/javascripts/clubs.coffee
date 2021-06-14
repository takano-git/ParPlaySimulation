# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.draw_graph = -> 
    ctx = document.getElementById("myChart").getContext('2d')
    barNum = 6
    labels = new Array(barNum)
    bgColors = new Array(barNum)
    bdColors = new Array(barNum)
    for i in [0...barNum]
      labels[i] = 'data' + i
      bgColors[i] = 'rgba(75, 192, 192, 0.2)'
      bdColors[i] = 'rgba(75, 192, 192, 1)'
    myChart = new Chart(ctx, {
      type: 'line',
      data: {
        datasets: [{
          label: 'ゴルフクラブの重さと長さの推移表',
          data: gon.linedata, # 
          backgroundColor: bgColors,
          borderColor: bdColors,
          # borderWidth: 1
        }],
        labels: gon.labeldata,
      },
      options: {
        responsive: true,
        scales: {
          xAxes: [{
            ticks: {
              reverse: true, # x軸を反転
              beginAtZero:true
            }
          }]
        }
      }
    })