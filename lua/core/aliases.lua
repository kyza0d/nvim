function abbreviate_or_noop(input, output)
	if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == input then
		return output
	else
		return input
	end
end

local function alias_command(input, output)
	vim.api.nvim_command(string.format("cabbrev <expr> %s v:lua.abbreviate_or_noop('%s', '%s')", input, input, output))
end

alias_command("w", "silent w")
alias_command("f", "Telescope find_files")
alias_command("c", "Telescope colorscheme")
alias_command("t", "Telescope")
