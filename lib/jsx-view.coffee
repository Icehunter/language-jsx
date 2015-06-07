{View} = require 'atom'

module.exports =
class JsxView extends View
  @content: ->
    @div class: 'jsx overlay from-top', =>
      @div 'The JSX package is Alive! It\'s ALIVE!', class: 'message'

  initialize: (serializeState) ->
    atom.commands.add 'atom-workspace', 'jsx:run': => @run()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  run: ->
    console.log 'JSX run called!!'
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
