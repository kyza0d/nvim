  ## File Structure
  
<pre style="line-height: 1.37; font-weight: bold">
  │ lua/                 Core Directory
  │
  ├─┬─ plugin /            Where all of the plugin configuration lives :h plugin-configuration
  │ ├─┬─ lsp-config /      Where LSP configuration lives               :h plugin-configuration
  │ │ │  handlers.lua      LSP
  │ │ │  servers.lua
  │ │ └  settings.lua
  │ │  vim-wiki.lua
  │ └  whichkey.lua
  │
  ├─┬─ statusline /
  │ │  components.lua
  │ └  init.lua
  │
  ├─┬─ utils /
  │ │  empty.lua
  │ │  fn_match.lua
  │ │  get_buf_info.lua
  │ └  layout.lua
  │
  │ autocmds.lua
  │ globals.lua
  │ keymaps.lua
  │ options.lua
  └ winbar.lua
</pre>
