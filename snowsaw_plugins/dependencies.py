import os
import subprocess
import snowsaw


class Dependencies(snowsaw.Plugin):
    """
    plugin to install dependencies for the current snowblock
    """
    _directive = "dependencies"
    _executable = os.environ.get("SHELL")

    def can_handle(self, directive):
        return directive == self._directive

    def handle(self, directive, data):
        if directive != self._directive:
            raise ValueError("Plugin \"Dependency\" cannot handle the directive \"{}\"".format(directive))
        return self._process_dependencies(data)

    def _check_dependency(self, dependency):
        with open(os.devnull, "w") as devnull:
            stdin = stdout = stderr = devnull

            check = None
            package_type = None
            name = dependency["name"]
            cmd = dependency["cmd"]

            if "brew cask" in cmd:
                check = "if brew cask ls --versions {} > /dev/null; then return 0; else return -1; fi".format(name)
                package_type = "brew cask"
            elif "brew" in cmd:
                check = "if brew ls --versions {} > /dev/null; then return 0; else return -1; fi".format(name)
                package_type = "Homebrew"
            elif "gem" in cmd:
                check = "gem list -i \"^{}$\"".format(name)
                package_type = "Ruby gem"
            elif "pip2" in cmd:
                check = "if pip2 show {} 1>/dev/null; then return 0; else return -1; fi".format(name)
                package_type = "python2"
            elif "pip3" in cmd:
                check = "if pip3 show {} 1>/dev/null; then return 0; else return -1; fi".format(name)
                package_type = "python3"
            elif "yarn global add" in cmd:
                check = "if yarn global list | egrep -oh {} > /dev/null; then return 0; else return -1; fi".format(name)
                package_type = "Yarn"
            elif "xcode-select" in cmd:
                check = "if type xcode-select >&- && xpath=$( xcode-select --print-path ) && test -d \"${xpath}\" && test -x \"${xpath}\"; then return 0; else return -1; fi"
                package_type = "Xcode developer tools"
            else:
                return False # We can't check it assume we need to install dependency

            dependency_check = subprocess.call(check, shell=True, stdin=stdin, stdout=stdin, stderr=stdout, cwd=self._context.snowblock_dir(), executable=self._executable)

        if dependency_check != 0:
            self._log.error("{} dependency '{}' missing, installing..".format(package_type, name))
            return False
        else:
            self._log.lowinfo("{} dependency '{}' already installed.".format(package_type, name))
            return True

    def _process_dependencies(self, data):
        """
        Processes specified dependencies.

        :param data: The dependencies to process
        :return: True if the commands have been processed successfully, False otherwise
        """
        success = True
        defaults = self._context.defaults().get("dependency", {})
        with open(os.devnull, "w") as devnull:
            for item in data:
                stdin = stdout = stderr = devnull
                if isinstance(item, dict):
                    name = item["name"]
                    cmd = item.get("cmd", "")
                    if item.get("stdin", defaults.get("stdin", False)) is True:
                        stdin = None
                    if item.get("stdout", defaults.get("stdout", False)) is True:
                        stdout = None
                    if item.get("stderr", defaults.get("stderr", False)) is True:
                        stderr = None
                else:
                    raise ValueError("data should be a dictionary { name:, cmd: }")

                dependency_check = self._check_dependency(item)

                if dependency_check != True:
                    ret = subprocess.call(cmd, shell=True, stdin=stdin, stdout=stdout, stderr=stderr, cwd=self._context.snowblock_dir(), executable=self._executable)

                    if ret != 0:
                        success = False
                        self._log.warning("Command [{}] failed".format(cmd))

        if success:
            self._log.info("=> All dependencies have been installed")
        else:
            self._log.error("Some dependencies could not be installed")
        return success
