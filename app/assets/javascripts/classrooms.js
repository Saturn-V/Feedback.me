//= require jquery.turbolinks
//= require Chart

Chart.defaults.global.maintainAspectRatio = false;
Chart.defaults.global.legend.display = false;

$(function() {
  var ctxA = document.getElementById("selfChart");
  var ctxB = document.getElementById("classChart");
  var selfChart = new Chart(ctxA, {
    type: 'line',
    data: {
      labels: gon.chart_month_names,
      datasets: [{
        fill: false,
        label: 'Instructor Performance',
        data: gon.chart_inst_compiled,
        backgroundColor: 'rgba(80, 227, 194, 0.2)',
        borderColor: 'rgba(80, 227, 194, 1)',
        borderWidth: 3
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


function openChart(evt, chartName) {
  // Declare all variables
  var i, tabcontent, tablinks, arrows;

  // Get all elements with class="tabcontent" and hide them
  tabcontent = document.getElementsByClassName("tab-content");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Get all elements with class="tablinks" and remove the class "active"
  tablinks = document.getElementsByClassName("tab-link");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }

  // Get all elements with class="arrow-right" and hide them
  arrows = document.getElementsByClassName("arrow-right");
  for (i = 0; i < arrows.length; i++) {
    arrows[i].style.display = "none";
  }

  // Show the current tab, and add an "active" class to the link that opened the tab
  document.getElementById(chartName).style.display = "block";
  evt.currentTarget.className += " active";
  evt.currentTarget.children[0].style.display = "block";
}

document.getElementById("defaultChart").click();
