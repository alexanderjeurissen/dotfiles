"                      ____  _             _
"  _____ _____ _____  |  _ \| |_   _  __ _(_)_ __  ___   _____ _____ _____
" |_____|_____|_____| | |_) | | | | |/ _` | | '_ \/ __| |_____|_____|_____|
" |_____|_____|_____| |  __/| | |_| | (_| | | | | \__ \ |_____|_____|_____|
"                     |_|   |_|\__,_|\__, |_|_| |_|___/
"                                    |___/

" ------------------------------------------------------------------
" Comment a Plugin group to disable a whole group, comment a runtime
" statement within a group to disable a single plugin
" ------------------------------------------------------------------

" load vim-plug for plugin management
source $HOME/.vim/settings/vimPlug.vim

" set runtime path for easier loading
" the runtime command lookups the file from
" $HOME/.vim/settings/plugins
set runtimepath+=$HOME/.vim/settings/pluginGroups

 runtime AutoCompletion.pluginGroup
 runtime Core.pluginGroup
 runtime CtrlP.pluginGroup
 runtime Editing.pluginGroup
 runtime Indentation.pluginGroup
 runtime Javascript.pluginGroup
 runtime Misc.pluginGroup
 runtime Navigation.pluginGroup
 runtime Ruby.pluginGroup
" runtime Unite.pluginGroup
 runtime VersionControl.pluginGroup
 runtime Web.pluginGroup
 runtime WindowManagers.pluginGroup
 runtime ColorSchemes.pluginGroup

call plug#end()
