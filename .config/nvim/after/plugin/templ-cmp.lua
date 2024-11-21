local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

require("luasnip").add_snippets("templ", {
	s("form-control", {
		t({ '<div class="form-control">', "\t" }),
		t({ '<label class="label">', "\t\t" }),

		t('<span class="label-text">'),
		i(1),
		t({ "</span>", "\t" }),

		t({ "</label>", "" }),
		t({ "</div>" }),
		i(0),
	}),
})
