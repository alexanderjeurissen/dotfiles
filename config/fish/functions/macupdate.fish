# Defined in - @ line 1
function mac_update --wraps='softwareupdate -i -a --verbose' --description 'alias mac_update=softwareupdate -i -a --verbose'
  softwareupdate -i -a --verbose
end
