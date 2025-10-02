return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "main",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "github/copilot.vim" },
	},
	opts = {
		debug = true,
		system = "Ты полезный помощник. Объясняй все на русском языке.",
		show_folds = false,
		question_icon = "?",
		answer_icon = "A",
		prompts = {
			Explain = "Объясни этот код.",
			Refactor = "Рефакторинг этого кода.",
			Tests = "Напиши тесты для этого кода.",
			Docs = "Напиши документацию для этого кода.",
			Review = "Проверь этот код на наличие ошибок и предложи улучшения.",
		},
	},
	config = function(_, opts)
		local chat = require("CopilotChat")
		chat.setup(opts)

		local function call_action(name)
			local mapping = chat.config.mappings[name]
			if not mapping or type(mapping.callback) ~= "function" then
				vim.notify("Copilot Chat: действие '" .. name .. "' недоступно", vim.log.levels.WARN)
				return
			end
			if not chat.chat or not chat.chat:visible() then
				vim.notify("Сначала открой окно Copilot Chat", vim.log.levels.INFO)
				return
			end
			mapping.callback(chat.get_source())
		end

		local mappings = {
			{ modes = "n", lhs = "<leader>co", rhs = function()
				chat.open()
			end, desc = "Copilot Chat: открыть окно" },
			{ modes = "n", lhs = "<leader>ct", rhs = function()
				chat.toggle()
			end, desc = "Copilot Chat: переключить окно" },
			{ modes = "n", lhs = "<leader>cc", rhs = function()
				chat.close()
			end, desc = "Copilot Chat: закрыть окно" },
			{ modes = "n", lhs = "<leader>cs", rhs = function()
				chat.stop()
			end, desc = "Copilot Chat: остановить вывод" },
			{ modes = "n", lhs = "<leader>cr", rhs = function()
				chat.reset()
			end, desc = "Copilot Chat: сбросить сессию" },
			{ modes = "n", lhs = "<leader>cp", rhs = function()
				chat.select_prompt()
			end, desc = "Copilot Chat: выбрать промпт" },
			{ modes = "n", lhs = "<leader>cm", rhs = function()
				chat.select_model()
			end, desc = "Copilot Chat: выбрать модель" },
			{ modes = "n", lhs = "<leader>cD", rhs = function()
				call_action("show_diff")
			end, desc = "Copilot Chat: показать diff" },
			{ modes = "n", lhs = "<leader>cA", rhs = function()
				call_action("accept_diff")
			end, desc = "Copilot Chat: применить diff" },
			{ modes = "n", lhs = "<leader>cJ", rhs = function()
				call_action("jump_to_diff")
			end, desc = "Copilot Chat: перейти к diff" },
			{ modes = "n", lhs = "<leader>cY", rhs = function()
				call_action("yank_diff")
			end, desc = "Copilot Chat: скопировать diff" },
			{ modes = "n", lhs = "<leader>cQ", rhs = function()
				call_action("quickfix_diffs")
			end, desc = "Copilot Chat: diff в quickfix" },
			{ modes = "n", lhs = "<leader>cL", rhs = function()
				call_action("quickfix_answers")
			end, desc = "Copilot Chat: ответы в quickfix" },
			{ modes = "n", lhs = "<leader>cI", rhs = function()
				call_action("show_info")
			end, desc = "Copilot Chat: информация" },
			{ modes = "n", lhs = "<leader>cH", rhs = function()
				call_action("show_help")
			end, desc = "Copilot Chat: справка" },
		}

		for _, map in ipairs(mappings) do
			vim.keymap.set(map.modes, map.lhs, map.rhs, { desc = map.desc, silent = true })
		end

		local ok, wk = pcall(require, "which-key")
		if ok and wk.add then
			wk.add({
				{ "<leader>c", group = "Copilot Chat", mode = "n" },
				{ "<leader>co", desc = "Открыть окно", mode = "n" },
				{ "<leader>ct", desc = "Переключить окно", mode = "n" },
				{ "<leader>cc", desc = "Закрыть окно", mode = "n" },
				{ "<leader>cs", desc = "Остановить вывод", mode = "n" },
				{ "<leader>cr", desc = "Сбросить сессию", mode = "n" },
				{ "<leader>cp", desc = "Выбрать промпт", mode = "n" },
				{ "<leader>cm", desc = "Выбрать модель", mode = "n" },
				{ "<leader>cD", desc = "Показать diff", mode = "n" },
				{ "<leader>cA", desc = "Применить diff", mode = "n" },
				{ "<leader>cJ", desc = "Перейти к diff", mode = "n" },
				{ "<leader>cY", desc = "Скопировать diff", mode = "n" },
				{ "<leader>cQ", desc = "Diff в quickfix", mode = "n" },
				{ "<leader>cL", desc = "Ответы в quickfix", mode = "n" },
				{ "<leader>cI", desc = "Информация", mode = "n" },
				{ "<leader>cH", desc = "Справка", mode = "n" },
			})
		elseif ok then
			wk.register({
				c = {
					name = "Copilot Chat",
					o = "Открыть окно",
					t = "Переключить окно",
					c = "Закрыть окно",
					s = "Остановить вывод",
					r = "Сбросить сессию",
					p = "Выбрать промпт",
					m = "Выбрать модель",
					D = "Показать diff",
					A = "Применить diff",
					J = "Перейти к diff",
					Y = "Скопировать diff",
					Q = "Diff в quickfix",
					L = "Ответы в quickfix",
					I = "Информация",
					H = "Справка",
				},
			}, { prefix = "<leader>" })
		end
	end,
}
