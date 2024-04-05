local util = require 'blender.util'
local ui = require 'blender.ui'
local manager = require 'blender.manager'

local M = {}

M.show_launcher = function()
  local running_task = manager.get_running_task()
  if running_task then
    ui.manage_task {
      message = 'A task is already running',
      task = running_task,
    }
    return
  end
  ui.select_profile(function(profile)
    local task = profile:launch()
    if not task then
      return
    end
    ui.manage_task {
      task = task,
    }
  end)
end

M.show_task_manager = function()
  if not manager.task then
    util.notify('No Blender task', 'INFO')
    return
  end
  ui.manage_task {
    task = manager.task,
    on_select = function()
      -- TODO: Implement
    end,
  }
end

M.reload_addon = function()
  local running_task = manager.get_running_task()
  if running_task then
    util.notify('No running blender task', 'INFO')
    return
  end
end

return M
