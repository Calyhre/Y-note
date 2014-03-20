#= require jquery
#= require jquery_nested_form
#= require_tree ./vendor
#= require_tree .
#= require_self

Array::first ?= (n) ->
  if n? then @[0...(Math.max 0, n)] else @[0]

Array::last ?= (n) ->
  if n? then @[(Math.max @length - n, 0)...] else @[@length - 1]

Array::compact ?= ->
  (elem for elem in this when elem? && elem > 0)

jQuery ->

  addResponseToQcm = (qcm) ->
    console.log qcm

  $('.devoir textarea').autosize()
  $('pre code').keydown (e)->
    if e.keyCode == 9
      e.preventDefault()
      document.execCommand('indent',true,null)
  hljs.configure({tabReplace: '    '})
  $('pre code').each (i, e) ->
    hljs.highlightBlock(e)

  $('.page').on 'click', '.settings-toggle', ->
    $('.modal.settings').removeClass 'shown'
    $(this).parents('.controls').parent().find('> .settings').addClass 'shown'

  $('.page').on 'click', '.modal-overlay', ->
    $(this).parent().find('> .settings').removeClass 'shown'

  $('.devoir.new .question .qcm label input').on 'keyup', ->
    qcm = $(this).parents('.qcm')
    list = qcm.find('li')
    last = list.last().find('input[type="text"]')[0]

    if last && last.value.length > 0
      list.last().find('input[type="checkbox"]').prop('disabled', false)
    else
      list.last().find('input[type="checkbox"]').prop('disabled', true)
      list.last().find('input[type="checkbox"]').prop('checked', false)

  $('.average .pie-chart canvas').each (i) ->
    canvas = this
    context = canvas.getContext '2d'
    x = canvas.width / 2
    y = canvas.height / 2

    avg      = ( this.dataset.avg / this.dataset.avgMax * 2 * Math.PI )      - ( Math.PI / 2 )
    classAvg = ( this.dataset.classAvg / this.dataset.avgMax * 2 * Math.PI ) - ( Math.PI / 2 )
    classMin = ( this.dataset.classMin / this.dataset.avgMax * 2 * Math.PI ) - ( Math.PI / 2 )
    classMax = ( this.dataset.classMax / this.dataset.avgMax * 2 * Math.PI ) - ( Math.PI / 2 )

    grades = [ avg, classAvg, classMin, classMax].compact().sort().reverse()

    gradesColors = ['#5D6D7F', '#a1adba', '#cdd4db']

    i = 1

    for grade in grades
      do (grade) ->
        console.log grade
        context.beginPath()
        context.arc x, y, x - (i * 10), -Math.PI/2, grade, false
        context.lineWidth = 15
        context.strokeStyle = gradesColors[i-1]
        context.stroke()

        i++

  $('.average .line-chart.eleve canvas').each (i) ->
    canvas = this
    context = canvas.getContext '2d'

    options =
      scaleSteps: 1

    data =
      labels: ["Octobre", "Novermbre", "Décembre", "Janvier", "Février"]
      datasets: [
        fillColor: "#5D6D7F"
        strokeColor: "#FFF"
        pointColor: "#5D6D7F"
        pointStrokeColor: "#fff"
        data: [13.6, 14.2, 13.1, 12.7, 13.4]
      ,
        fillColor: "#a1adba"
        strokeColor: "#FFF"
        pointColor: "#a1adba"
        pointStrokeColor: "#fff"
        data: [13.1, 12.6, 12.3, 12.7, 12.5]
      ]

    chart = new Chart(context).Line data

  $('.average .line-chart.workers canvas').each (i) ->
    canvas = this
    context = canvas.getContext '2d'

    options =
      scaleSteps: 1

    data =
      labels: ["Octobre", "Novermbre", "Décembre", "Janvier", "Février"]
      datasets: [
        fillColor: "#5D6D7F"
        strokeColor: "#FFF"
        pointColor: "#5D6D7F"
        pointStrokeColor: "#fff"
        data: [13.6, 14.2, 13.1, 12.7, 13.4]
      ,
        fillColor: "#a1adba"
        strokeColor: "#FFF"
        pointColor: "#a1adba"
        pointStrokeColor: "#fff"
        data: [12, 14, 11, 11, 14]
      ]

    chart = new Chart(context).Line data

  $('.average .line-chart.classe canvas').each (i) ->
    canvas = this
    context = canvas.getContext '2d'

    options =
      scaleSteps: 1

    data =
      labels: ["Octobre", "Novermbre", "Décembre", "Janvier", "Février"]
      datasets: [
        fillColor: "#5D6D7F"
        strokeColor: "#FFF"
        pointColor: "#5D6D7F"
        pointStrokeColor: "#fff"
        data: [15, 15.4, 14.9, 15.3, 15.72]
      ,
        fillColor: "#a1adba"
        strokeColor: "#FFF"
        pointColor: "#a1adba"
        pointStrokeColor: "#fff"
        data: [13.1, 12.6, 12.3, 12.7, 12.84]
      ,
        fillColor: "#cdd4db"
        strokeColor: "#FFF"
        pointColor: "#cdd4db"
        pointStrokeColor: "#fff"
        data: [8.5, 8.9, 9, 7.8, 8.62]
      ]

    chart = new Chart(context).Line data

  $('select').fancySelect()
  # if $( window ).width() > 1024
  #   $('#sidebar').addClass 'open'
