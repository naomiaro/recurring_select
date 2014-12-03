//= require recurring_select_dialog
//= require_self

$ = jQuery

$(document).on "click", ".recurring_select_group .edit", ->
  $(this)
    .parents(".recurring_select_group")
    .find(".recurring_select")
    .recurring_select('open')

methods =

  open: ->
    new RecurringSelectDialog(@)

  save: (new_rule) ->
    @.val JSON.stringify(new_rule.hash)
    @.data "rrule-string", new_rule.str
    @.data "rrule-hash", new_rule.hash

    @.parent().find(".summary").html new_rule.str

    @.trigger "recurring_select:save", [new_rule]

  cancel: ->
    @.trigger "recurring_select:cancel"

  methods: ->
    methods

$.fn.recurring_select = (method) ->
  if method of methods
    return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ) );
  else
    $.error( "Method #{method} does not exist on jQuery.recurring_select" );

$.fn.recurring_select.options = {
  first_day_of_week: 0
  monthly: {
    show_week: [true, true, true, true, true, true]
  }
}

$.fn.recurring_select.texts = {
  repeat: "Repeat"
  last_day: "Last Day"
  frequency: "Frequency"
  daily: "Daily"
  weekly: "Weekly"
  monthly: "Monthly"
  yearly: "Yearly"
  every: "Every:"
  days: "day(s)"
  weeks_on: "week(s) on"
  months: "month(s)"
  years: "year(s)"
  week_repeat: "Repeat on:"
  month_repeat: "Repeat by:"
  day_of_month: "Day of month"
  day_of_week: "Day of week"
  cancel: "Cancel"
  ok: "OK"
  summary: "Summary"
  ends: "Ends:"
  days_first_letter: ["S", "M", "T", "W", "T", "F", "S" ]
  order: ["1st", "2nd", "3rd", "4th", "5th", "Last"]
}
