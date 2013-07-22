function createOptionsForChart(specific, actionable, kind) {
  var options = {
    chart: {
      renderTo: 'stats',
      type: 'column',
      defaultSeriesType: 'column',
      backgroundColor: '#ecf0f1',
      width: 300,
      height: 201,
    },
    tooltip: {
      formatter: function() {
        return this.x + ': ' + this.y
      }
    },
    credits: {
      enabled: false
    },
    title: {
      text: ''
    },
    color: {
      shadow: true,
      borderWidth: 0,
      color: '#0e9896'
    },
    xAxis: {
      categories: ['Specific', 'Actionable', 'Kind']
    },
    yAxis: {
      labels: false,
      title: '',
      gridLineWidth: 0,
      minorGridLineWidth: 0
    },
    series: [{
      data: [specific, actionable, kind],
      color: '#0e9896',
      shadow: true,
      borderWidth: 0,
      showInLegend: false
    }]
  }
  return options;
}

var Score = {
  init: function() {
    $('#new_score').on('ajax:success', this.appendPartial);
  },
  appendPartial: function(e, data) {
    $('#create_score').hide();
    $('#score').append(data.partial);
    Score.createChart(data.specific, data.actionable, data.kind);
  },
  createChart: function(specific, actionable, kind) {
    $('#stats').empty();
    var options = createOptionsForChart(specific, actionable, kind);
    var chart = new Highcharts.Chart(options);
  }
}

$(document).ready(function() {
  Score.init();
});
