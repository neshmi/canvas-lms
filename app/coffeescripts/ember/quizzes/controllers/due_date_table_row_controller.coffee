define [
  'ember'
  'jquery'
  'i18n!text_helper'
  'jquery.instructure_date_and_time'
], ({ObjectController, computed}, $, I18n) ->

  DueDateTableRowController = ObjectController.extend
    alwaysAvailable: computed.equal 'hasLockDateRange', false

    hasLockDateRange: computed.and 'lock_at', 'unlock_at'

    friendlyLockAt: (->
      return '' unless lockAt = @get 'lock_at'
      $.friendlyDatetime $.parseFromISO(lockAt).datetime
    ).property 'lock_at'

    friendlyUnlockAt: (->
      return '' unless unlockAt = @get 'unlock_at'
      $.friendlyDatetime $.parseFromISO(unlockAt).datetime
    ).property 'unlock_at'

    friendlyDateRangeString: (->
      I18n.t 'time.ranges.different_days',
        "%{start_date_and_time} to %{end_date_and_time}",
        start_date_and_time: @get('friendlyUnlockAt')
        end_date_and_time: @get('friendlyLockAt')
    ).property 'hasLockDateRange'
