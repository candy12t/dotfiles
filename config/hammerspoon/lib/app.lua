local function hideOrActiveApp(appName)
  return function ()
    local app = hs.application.get(appName)
    if app:isHidden() then
      app:activate()
    else
      app:hide()
    end
  end
end

return {
  hideOrActiveApp = hideOrActiveApp,
}
