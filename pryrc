#Please either merge these functions in with your existing ~/.pryrc file
#or place this file in ~/.pryrc.

#Alert the user when pry is started via desktop notifications.
def desktop_notify(title="Pry",message)
  if RUBY_PLATFORM =~ /linux/
    system "notify-send '#{title}' '#{message}' --icon=dialog-information --expire-time 600000"
  elsif RUBY_PLATFORM =~ /darwin/
    #The %Q replaces double-quoted strings with an alternate character
    #here, we use the pipe character.
    notification = %Q|osascript -e 'display notification "#{message}" with title "#{title}"'|
    system notification
  end
end

notify_hook = Pry::Hooks.new.add_hook(:before_session, :notify) do
  desktop_notify("Pry started.")
end

notify_hook.exec_hook(:before_session)

#Specify the editor to use when runing 'edit' in pry:
Pry.config.editor = 'vim'
