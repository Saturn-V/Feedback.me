//= require Chart

$(function() {
  var ctx = document.getElementById("myChart");
  var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: ["Oct", "Nov", "Dec", "Jan", "Feb", "March"],
      datasets: [{
        label: 'Instructor Performance',
        data: [0, 2, 4, 2, 3, 1, 5, 2, 3, 3, 4, 5],
        backgroundColor: [
          'rgba(80, 227, 194, 0.2)',
          'rgba(80, 227, 194, 0.2)',
          'rgba(80, 227, 194, 0.2)',
          'rgba(80, 227, 194, 0.2)',
          'rgba(80, 227, 194, 0.2)',
          'rgba(80, 227, 194, 0.2)'
        ],
        borderColor: [
          'rgba(80, 227, 194, 1)',
          'rgba(80, 227, 194, 1)',
          'rgba(80, 227, 194, 1)',
          'rgba(80, 227, 194, 1)',
          'rgba(80, 227, 194, 1)',
          'rgba(80, 227, 194, 1)'
        ],
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero:true
          }
        }]
      }
    }
  });
});
