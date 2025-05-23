# vim: foldmethod=marker:sw=2:foldlevel=10:ft=ruby

begin
  require 'pastel'
rescue LoadError => err
  # Handle the case where the gem is not found
  puts "Gem 'pastel' not found! #{err}"
end

Pry.config.correct_indent = false if ENV['INSIDE_EMACS']

# NOTE: Add awesome print as a wrapper for all print operations {{{
begin
  require 'awesome_print'
  AwesomePrint.pry!
rescue LoadError => err
  puts Pastel.new.black("LoadError: no awesome_print :(")
end
# }}}

# NOTE: Use neovim as default editor
Pry.editor = 'nvim'

# NOTE: pry byebug aliases {{{
Pry.commands.alias_command('c', 'continue') if Pry::Commands["continue"]
Pry.commands.alias_command('s', 'step') if Pry::Commands["step"]
Pry.commands.alias_command('n', 'next') if Pry::Commands["next"]
Pry.commands.alias_command 'e', 'exit'
# }}}

# NOTE: better colors {{{
Pry.color = true
Pry.config.color = true
Pry.config.theme = "solarized"
Pry.config.ls.separator = "\n" # new lines between methods
Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black
# }}}

# NOTE: make clear clear the actual parent terminal {{{
Pry::Commands.command /^clear$/, "clear console" do
  system('clear')
end

Pry::Commands.command /^clear!$/, "clear console including tmux scrollback buffer" do
  system('clear!')
end
# }}}

# NOTE: prompt {{{
def _pry_indent(string, count, char = ' ')
  string.gsub(/([^\n]*)(\n|$)/) do |match|
    last_iteration = ($1 == "" && $2 == "")
    line = ""
    line << (char * count) unless last_iteration
    line << $1
    line << $2
    line
  end
end

def _pry_prompt(context, nesting, pry_instance, prompt_color = Pastel.new.bold.bright_blue.detach)
  prompt_char = prompt_color.('')
  prompt_name = Pastel.new.bold.bright_yellow(pry_instance.config.prompt_name)
  prompt_context = Pastel.new.bold.bright_cyan(Pry.view_clip(context))
  prompt_separator = Pastel.new.bright_green(':')

  # NOTE: indent printed output so it lines up with nesting
  # fallback to regular colorPrinter
  pry_instance.config.print = proc do |output, value|
    next Pry::ColorPrinter.pp(value) unless defined?(value.ai)
    output.puts(_pry_indent(value.ai, nesting*2+1)) if defined?(value.ai)
  end

  _pry_indent(" #{prompt_char} #{prompt_name}#{prompt_separator}#{prompt_context} ", nesting*2)
end

_prompts = [
  proc { |context, nesting, pry_instance, sep| _pry_prompt(context, nesting, pry_instance) },
  proc { |context, nesting, pry_instance, sep| _pry_prompt(context, nesting, pry_instance, Pastel.new.bold.bright_green.detach) }
]

# NOTE: we have a newer pry version that supports
# Prompt.new
if defined?(Pry::Prompt.new)
  Pry.config.prompt = Pry::Prompt.new( :snappy, 'a cleaner pry prompt', _prompts)
else
  Pry.config.prompt = _prompts
end
