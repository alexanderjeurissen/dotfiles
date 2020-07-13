# Defined in - @ line 1
function structuresql --wraps='g difftool develop -- db/structure.sql && g diff develop -- db/structure.sql' --description 'alias structuresql=g difftool develop -- db/structure.sql && g diff develop -- db/structure.sql'
  g difftool develop -- db/structure.sql && g diff develop -- db/structure.sql $argv;
end
