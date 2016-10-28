# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$( ->
  $(document).on('click', '.fill-time-at-now', (_e) ->
    now = new Date(Date.now())
    now_string = ''.concat(now.getHours(), ':', now.getMinutes())

    input = $(@).parent().children('input[type="time"]').get(0)
    input.value = now_string
  )
)
