local augend = require("dial.augend")

-- stylua: ignore
require("dial.config").augends:register_group({
  default = {
    augend.constant.alias.bool,    -- boolean value (true <-> false)
    augend.date.alias["%Y/%m/%d"], -- date (2021/01/01 <-> 2021/01/02)
    augend.integer.alias.decimal,  -- decimal number (1 <-> 2)
    augend.integer.alias.hex,      -- hexadecimal number (0x1 <-> 0x2)
    augend.constant.alias.alpha,   -- alphabet (a <-> b)
    augend.semver.alias.semver,     -- semver (0.0.1 <-> 0.0.2)
    augend.constant.alias.Alpha,   -- alphabet (A <-> B)
  },
})

keymap("n", "<C-a>", require("dial.map").inc_normal())
keymap("n", "<C-x>", require("dial.map").dec_normal())

keymap("v", "<C-a>", require("dial.map").inc_visual())
keymap("v", "<C-x>", require("dial.map").dec_visual())

keymap("v", "g<C-a>", require("dial.map").inc_gvisual())
keymap("v", "g<C-x>", require("dial.map").dec_gvisual())
