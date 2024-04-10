local home = os.getenv('HOME')
local root_markers = {'gradlew', 'mvnw', '.git'}
local root_dir = require('jdtls.setup').find_root(root_markers)
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local config = {
  flags = {
    debounce_text_changes = 80,
  },
  root_dir = function()
    return require('jdtls.setup').find_root(root_markers)
  end,
  settings = {
    java = {
      format = {
        settings = {
          -- Use Google Java style guidelines for formatting
          -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
          -- and place it in the ~/.local/share/eclipse directory
          url = "/home/yly/.config/nvim/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },  -- Use fernflower to decompile library code
      -- Specify any completion options
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*", "sun.*",
        },
      },
      -- Specify any options for organizing imports
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        },
      },
      -- How code generation should act
      codeGeneration = {
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
    }
  },
  cmd = {
    "/usr/lib/jvm/java-17-openjdk/bin/java",
    "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms4g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    --增加lombok插件支持，getter setter good bye
    "-javaagent:/home/yly/.config/nvim/lombok.jar",
    "-jar",
    "/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar",
    "-configuration",
    "/home/yly/.local/jdtls-config",
    '-data', workspace_folder
  },
  init_options = {
    bundles = {
      vim.fn.glob("/home/yly/.config/nvim/java-debug-0.50.0/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1)
    },
  }
}
require('jdtls').start_or_attach(config)
return config
