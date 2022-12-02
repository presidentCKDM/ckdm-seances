$(document).on 'ready page:load', ->

  $("input.invitation-switch").change (e) ->
    $(this).parent().submit()

  $("input.invitation-switch").bootstrapSwitch
    onText: "Oui"
    offText: "Non"
    offColor: "danger"
    size: "small"

  $("input.invitation-switch-unanswered").bootstrapSwitch('offColor', 'default').bootstrapSwitch('labelText', 'Oui')

  $("input.invitation-switch").on "switchChange.bootstrapSwitch", (event, state) ->
    $(this).parent().submit()
