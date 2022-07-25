var ctx = document.getElementById('mychart');
var myChart = new Chart(ctx, {
  type: 'line',
  data: {
    labels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
    datasets: [{
      label: 'Red',
      data: [20, 35, 40, 30, 45, 35, 40],
      borderColor: '#f88',
    }, {
      label: 'Green',
      data: [20, 15, 30, 25, 30, 40, 35],
      borderColor: '#484',
    }, {
      label: 'Blue',
      data: [30, 25, 10, 5, 25, 30, 20],
      borderColor: '#48f',
    }],
  },
  options: {
    y: {
      min: 0,
      max: 60,
    },
  },
});