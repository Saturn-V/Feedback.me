//= require jquery.turbolinks
//= require Chart

$(function() {
  var ctxA = document.getElementById("selfChart");
  var ctxB = document.getElementById("classChart");
  var selfChart = new Chart(ctxA, {
    type: 'line',
    data: {
      labels: gon.chart_month_names,
      datasets: [{
        label: 'Instructor Performance',
        data: [2, 3, 1, 5, 2, 3],
        backgroundColor: 'rgba(80, 227, 194, 0.2)',
        borderColor: 'rgba(80, 227, 194, 1)',
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero:true
          },
          gridLines: {
            display: false
          }
        }],
        xAxes: [{
          gridLines: {
            display: false
          }
        }]
      }
    }
  });

  var classChart = new Chart(ctxB, {
    type: 'doughnut',
    data: {
      labels: [
          "Too Fast",
          "Too Slow",
          "A wee bit too fast",
          "A wee bit too slow",
          "Just Right!"
      ],
      datasets: [{
          data: [ 8, 10, 4, 7, 13 ],
          backgroundColor: [
              "#FFCE56",
              "#36A2EB",
              "#4BC0C0",
              "#FF6384",
              "#BF90D4"
          ]
          // label: 'Student Performance' // for legend
      }]
  },
    options: {}
  });
});
