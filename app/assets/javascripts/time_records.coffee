# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

stretchTimeFormat = (timeNum) ->
  if timeNum.toString().length == 1
    "0#{timeNum}"
  else
    "#{timeNum}"

$( ->
  $(document).on('click', '.fill-time-at-now', (_e) ->
    now = new Date(Date.now())
    now_string = ''.concat(
      stretchTimeFormat(now.getHours()),
      ':',
      stretchTimeFormat(now.getMinutes()),
      ':',
      stretchTimeFormat(now.getSeconds())
    )

    input = $(@).parent().children('input[type="time"]').get(0)
    input.value = now_string
  )
)
