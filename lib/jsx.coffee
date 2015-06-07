jsx_bin_path = '/node_modules/jsx/bin/jsx'
child_process = require 'child_process'

module.exports =
  activate: (state) ->
    atom.commands.add 'atom-workspace', 'jsx:run': => @run()
  run: ->
    editor = atom.workspace.getActiveTextEditor()
    lang_jsx_path = atom.packages.resolvePackagePath('language-jsx')
    jsx_bin = lang_jsx_path + jsx_bin_path
    node_path = @getNodePath() || @getExecPath()
    uri = atom.workspace.getActivePaneItem().buffer.file.path
    command = require('util').format '%s %s --run %s', node_path, jsx_bin, uri
    options = {
      'cwd' : lang_jsx_path
    }
    child_process.exec(command, options, (error, stdout, stderr) ->
        console.error(error) if error
        console.error(stderr) if stderr
        console.log(stdout) if stdout
    )
    atom.openDevTools()
  getExecPath: ->
    'ATOM_SHELL_INTERNAL_RUN_AS_NODE=1 '#{process.execPath}''
  getNodePath: ->
    atom.config.get('language-jsx.nodepath')
