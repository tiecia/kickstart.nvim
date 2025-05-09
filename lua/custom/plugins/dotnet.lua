return {
  {

    -- {
    --   'iabdelkareem/csharp.nvim',
    --   dependencies = {
    --     'williamboman/mason.nvim', -- Required, automatically installs omnisharp
    --     'mfussenegger/nvim-dap',
    --     'Tastyep/structlog.nvim', -- Optional, but highly recommended for debugging
    --   },
    --   config = function()
    --     require('mason').setup() -- Mason setup must run before csharp, only if you want to use omnisharp
    --     require('csharp').setup()
    --   end,
    -- },

    -- lazy.nvim
    -- {
    --   'GustavEikaas/easy-dotnet.nvim',
    --   dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    --   config = function()
    --     require('easy-dotnet').setup {
    --       mappings = {
    --         run = { lhs = '<leader>dr', desc = 'Run test easy-dotnet' },
    --       },
    --     }
    --   end,
    -- },

    'seblyng/roslyn.nvim',
    ft = { 'cs', 'razor' },
    dependencies = {
      -- Mason with the registey github:Crashdummyy/mason-registry should be listed as a dependency, but that seems to override other mason configurations.
      'tris203/rzls.nvim',
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('rzls').setup {}
      end,
    },
    opts = {
      -- your configuration comes here; leave empty for default settings_split_by_newline
    },
    config = function()
      require('roslyn').setup {
        args = {
          '--stdio',
          '--logLevel=Information',
          '--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path()),
          '--razorSourceGenerator='
            .. vim.fs.joinpath(vim.fn.stdpath 'data' --[[@as string]], 'mason', 'packages', 'roslyn', 'libexec', 'Microsoft.CodeAnalysis.Razor.Compiler.dll'),
          '--razorDesignTimePath=' .. vim.fs.joinpath(
            vim.fn.stdpath 'data' --[[@as string]],
            'mason',
            'packages',
            'rzls',
            'libexec',
            'Targets',
            'Microsoft.NET.Sdk.Razor.DesignTime.targets'
          ),
        },
        config = {
          --[[ the rest of your roslyn config ]]
          settings = {
            ['csharp|inlay_hints'] = {
              csharp_enable_inlay_hints_for_implicit_object_creation = true,
              csharp_enable_inlay_hints_for_implicit_variable_types = true,

              csharp_enable_inlay_hints_for_lambda_parameter_types = true,
              csharp_enable_inlay_hints_for_types = true,
              dotnet_enable_inlay_hints_for_indexer_parameters = true,
              dotnet_enable_inlay_hints_for_literal_parameters = true,
              dotnet_enable_inlay_hints_for_object_creation_parameters = true,
              dotnet_enable_inlay_hints_for_other_parameters = true,
              dotnet_enable_inlay_hints_for_parameters = true,
              dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
            },
            ['csharp|code_lens'] = {
              dotnet_enable_references_code_lens = true,
            },
          },
          handlers = require 'rzls.roslyn_handlers',
        },
      }
    end,
    init = function()
      vim.filetype.add {
        extension = {
          razor = 'razor',
          cshtml = 'razor',
        },
      }
    end,
  },
}
