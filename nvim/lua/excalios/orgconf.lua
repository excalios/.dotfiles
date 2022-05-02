return {
  org_agenda_files = {'~/Documents/orgs/**/*'},
  org_default_notes_file = '~/Documents/orgs/refile.org',
  notifications = {
    enabled = false,
    cron_enabled = true,
    repeater_reminder_time = {0, 1, 5},
    deadline_warning_reminder_time = {0, 1, 5, 15, 30, 60},
    reminder_time = 10,
    deadline_reminder = true,
    scheduled_reminder = true,
    notifier = function(tasks)
      local result = {}
      for _, task in ipairs(tasks) do
        require('orgmode.utils').concat(result, {
          string.format('# %s (%s)', task.category, task.humanized_duration),
          string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title),
          string.format('%s: <%s>', task.type, task.time:to_string())
        })
      end

      if not vim.tbl_isempty(result) then
        require('orgmode.notifications.notification_popup'):new({ content = result })
      end
    end,
    cron_notifier = function(tasks)
      for _, task in ipairs(tasks) do
        local title = string.format('%s (%s)', task.category, task.humanized_duration)
        local subtitle = string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title)
        local date = string.format('%s: %s', task.type, task.time:to_string())

        if vim.fn.executable("notify-send") == 1 then
            vim.loop.spawn("notify-send", { args = { string.format("%s", title), string.format("%s\n%s", subtitle, date), "-u", "critical" }})
        end
      end
    end
  },
}
