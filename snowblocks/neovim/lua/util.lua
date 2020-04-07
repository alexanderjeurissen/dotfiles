--- NVIM SPECIFIC SHORTCUTS
vim = vim or {}
api = vim.api
fn = vim.fn


-- NOTE: Set an option in Neovim
function nvim_set(option, value)
  if v == true or v == false then
    vim.api.nvim_command('set ' .. k)
  elseif type(v) == 'table' then
    local values = ''
    for k2, v2 in pairs(v) do
      if k2 == 1 then
        values = values .. v2
      else
        values = values .. ',' .. v2
      end
    end
    vim.api.nvim_command('set ' .. k .. '=' .. values)
  else
    vim.api.nvim_command('set ' .. k .. '=' .. v)
  end
end
--VISUAL_MODE = {
--  line = "line"; -- linewise
--  block = "block"; -- characterwise
--  char = "char"; -- blockwise-visual
--}

--file_separator = is_windows and '\\' or '/'
--is_windows = vim.loop.os_uname().version:match("Windows")

--function log(item)
--  print(vim.inspect(item))
--end

----- Check if a file or directory exists in this path
--function exists(file)
--  local ok, err, code = os.rename(file, file)
--  if not ok then
--    if code == 13 then
--      -- Permission denied, but it exists
--      return true
--    end
--  end
--  return ok, err
--end

----- Check if a directory exists in this path
--function isdir(path)
--  -- "/" works on both Unix and Windows
--  return exists(path.."/")
--end


--function getPath(str)
--  local s = str:gsub("%-","")
--  return s:match("(.*[/\\])")
--end

---- Equivalent to `echo vim.inspect(...)`
--function nvim_print(...)
--  if select("#", ...) == 1 then
--    vim.api.nvim_out_write(vim.inspect((...)))
--  else
--    vim.api.nvim_out_write(vim.inspect {...})
--  end
--  vim.api.nvim_out_write("\n")
--end

----- Equivalent to `echo` EX command
--function nvim_echo(...)
--  for i = 1, select("#", ...) do
--    local part = select(i, ...)
--    vim.api.nvim_out_write(tostring(part))
--    -- vim.api.nvim_out_write("\n")
--    vim.api.nvim_out_write(" ")
--  end
--  vim.api.nvim_out_write("\n")
--end

--function nvim_source_current_buffer()
--  loadstring(table.concat(nvim_buf_get_region_lines(nil, 1, -1, VISUAL_MODE.line), '\n'))()
--end

--LUA_MAPPING = {}
--LUA_BUFFER_MAPPING = {}

--local function escape_keymap(key)
--  -- Prepend with a letter so it can be used as a dictionary key
--  return 'k'..key:gsub('.', string.byte)
--end

--local valid_modes = {
--  n = 'n'; v = 'v'; x = 'x'; i = 'i';
--  o = 'o'; t = 't'; c = 'c'; s = 's';
--  -- :map! and :map
--  ['!'] = '!'; [' '] = '';
--}

---- TODO(ashkan) @feature Disable noremap if the rhs starts with <Plug>
--function nvim_apply_mappings(mappings, default_options)
--  -- May or may not be used.
--  local current_bufnr = vim.api.nvim_get_current_buf()
--  for key, options in pairs(mappings) do
--    options = vim.tbl_extend("keep", options, default_options or {})
--    local bufnr = current_bufnr
--    -- TODO allow passing bufnr through options.buffer?
--    -- protect against specifying 0, since it denotes current buffer in api by convention
--    if type(options.buffer) == 'number' and options.buffer ~= 0 then
--      bufnr = options.buffer
--    end
--    local mode, mapping = key:match("^(.)(.+)$")
--    assert(mode, "nvim_apply_mappings: invalid mode specified for keymapping "..key)
--    assert(valid_modes[mode], "nvim_apply_mappings: invalid mode specified for keymapping. mode="..mode)
--    mode = valid_modes[mode]
--    local rhs = options[1]
--    -- Remove this because we're going to pass it straight to nvim_set_keymap
--    options[1] = nil
--    if type(rhs) == 'function' then
--      -- Use a value that won't be misinterpreted below since special keys
--      -- like <CR> can be in key, and escaping those isn't easy.
--      local escaped = escape_keymap(key)
--      local key_mapping
--      if options.dot_repeat then
--        local key_function = rhs
--        rhs = function()
--          key_function()
--          -- -- local repeat_expr = key_mapping
--          -- local repeat_expr = mapping
--          -- repeat_expr = vim.api.nvim_replace_termcodes(repeat_expr, true, true, true)
--          -- nvim.fn["repeat#set"](repeat_expr, nvim.v.count)
--          nvim.fn["repeat#set"](nvim.replace_termcodes(key_mapping, true, true, true), nvim.v.count)
--        end
--        options.dot_repeat = nil
--      end
--      if options.buffer then
--        -- Initialize and establish cleanup
--        if not LUA_BUFFER_MAPPING[bufnr] then
--          LUA_BUFFER_MAPPING[bufnr] = {}
--          -- Clean up our resources.
--          vim.api.nvim_buf_attach(bufnr, false, {
--            on_detach = function()
--              LUA_BUFFER_MAPPING[bufnr] = nil
--            end
--          })
--        end
--        LUA_BUFFER_MAPPING[bufnr][escaped] = rhs
--        -- TODO HACK figure out why <Cmd> doesn't work in visual mode.
--        if mode == "x" or mode == "v" then
--          key_mapping = (":<C-u>lua LUA_BUFFER_MAPPING[%d].%s()<CR>"):format(bufnr, escaped)
--        else
--          key_mapping = ("<Cmd>lua LUA_BUFFER_MAPPING[%d].%s()<CR>"):format(bufnr, escaped)
--        end
--      else
--        LUA_MAPPING[escaped] = rhs
--        -- TODO HACK figure out why <Cmd> doesn't work in visual mode.
--        if mode == "x" or mode == "v" then
--          key_mapping = (":<C-u>lua LUA_MAPPING.%s()<CR>"):format(escaped)
--        else
--          key_mapping = ("<Cmd>lua LUA_MAPPING.%s()<CR>"):format(escaped)
--        end
--      end
--      rhs = key_mapping
--      options.noremap = true
--      options.silent = true
--    end
--    if options.buffer then
--      options.buffer = nil
--      vim.api.nvim_buf_set_keymap(bufnr, mode, mapping, rhs, options)
--    else
--      vim.api.nvim_set_keymap(mode, mapping, rhs, options)
--    end
--  end
--end

--function nvim_create_augroups(definitions)
--  for group_name, definition in pairs(definitions) do
--    vim.api.nvim_command('augroup '..group_name)
--    vim.api.nvim_command('autocmd!')
--    for _, def in ipairs(definition) do
--      -- if type(def) == 'table' and type(def[#def]) == 'function' then
--      -- 	def[#def] = lua_callback(def[#def])
--      -- end
--      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
--      vim.api.nvim_command(command)
--    end
--    vim.api.nvim_command('augroup END')
--  end
--end

-----
---- Things Lua should've had
-----

--function string.startswith(s, n)
--  return s:sub(1, #n) == n
--end

--function string.endswith(self, str)
--  return self:sub(-#str) == str
--end

-----
---- SPAWN UTILS
-----

--local function clean_handles()
--  local n = 1
--  while n <= #HANDLES do
--    if HANDLES[n]:is_closing() then
--      table.remove(HANDLES, n)
--    else
--      n = n + 1
--    end
--  end
--end

--HANDLES = {}

--function spawn(cmd, params, onexit)
--  local handle, pid
--  handle, pid = vim.loop.spawn(cmd, params, function(code, signal)
--    if type(onexit) == 'function' then onexit(code, signal) end
--    handle:close()
--    clean_handles()
--  end)
--  table.insert(HANDLES, handle)
--  return handle, pid
--end

----- MISC UTILS

---- capturs stdout as a string
--function os.capture(cmd, raw)
--  local f = assert(io.popen(cmd, 'r'))
--  local s = assert(f:read('*a'))
--  f:close()
--  if raw then return s end
--  s = string.gsub(s, '^%s+', '')
--  s = string.gsub(s, '%s+$', '')
--  s = string.gsub(s, '[\n\r]+', ' ')
--  return s
--end


---- return name of git branch
--function gitBranch()
--  if is_windows then
--    return os.capture("git rev-parse --abbrev-ref HEAD 2> NUL | tr -d '\n'")
--  else
--    return os.capture("git rev-parse --abbrev-ref HEAD 2> /dev/null | tr -d '\n'")
--  end
--end

---- returns short status of changes
--function gitStat()
--  if is_windows then
--    return os.capture("git diff --shortstat 2> NUL | tr -d '\n'")
--  else
--    return os.capture("git diff --shortstat 2> /dev/null | tr -d '\n'")
--  end
--end

-- set options
function setOptions(options)
  for k, v in pairs(options) do
    if v == true or v == false then
      vim.api.nvim_command('set ' .. k)
    elseif type(v) == 'table' then
      local values = ''
      for k2, v2 in pairs(v) do
        if k2 == 1 then
          values = values .. v2
        else
          values = values .. ',' .. v2
        end
      end
      vim.api.nvim_command('set ' .. k .. '=' .. values)
    else
      vim.api.nvim_command('set ' .. k .. '=' .. v)
    end
  end
end

-- function map_cmd(cmd_string, buflocal)
--   return { ("<Cmd>%s<CR>"):format(cmd_string), noremap = true; buffer = buflocal;}
-- end

-- function map_call(cmd_string, buflocal)
--   return { ("%s<CR>"):format(cmd_string), noremap = true; buffer = buflocal;}
-- end

-- function map_no_cr(cmd_string, buflocal)
--   return { (":%s"):format(cmd_string), noremap = true; buffer = buflocal;}
-- end

-- function readout(bufhandle)
--   return function(err, data)
--     if err then
--       api.nvim_put({api.nvim_replace_termcodes(err, true, true, true)}, "l", true, true)
--     end
--     if data then
--       api.nvim_put({api.nvim_replace_termcodes(data, true, true, true)}, "l", true, true)
--     end
--   end
-- end
