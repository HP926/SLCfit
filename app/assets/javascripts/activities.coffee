$(document).ready ->

  $("#log-activities-button").click ->
    $('#activities-table tbody .activity-row').each ->
      $tableRow = $(@)
      activityId = $tableRow.data().activityId
      activityDate = $tableRow.find('.date').val()
      activityDuration = $tableRow.find('.duration').val()
      activityDescription = $tableRow.find('.description').val()
      $.ajax "/update_activity",
        type: 'PUT'
        data:
          id: activityId
          date: activityDate
          duration: activityDuration
          description: activityDescription
        success: (data) ->
          console.log data
        error: (data) ->
          console.log data
    $('#myModal').modal('hide')
    $.ajax '/activity_display',
      type: 'GET'
      data:
        week_id: $('.week-id:first').val()
      success: (data) ->
        $("#activity_display").html(data)

  $('#myModal').on 'shown.bs.modal', ->
    $activitiesTableBody = $('#activities-table tbody')
    $activitiesTableBody.empty()
    $(".activity-check:checked").each ->
      $.ajax '/activity_tr',
        type: 'GET'
        data:
          id: $(@).data().activityId
        success: (data) ->
          $activitiesTableBody.append(data)
