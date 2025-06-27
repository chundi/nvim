local os_name = vim.loop.os_uname().sysname

local ver = 21
vim.env.JAVA_VERSION = ver

if os_name == 'Darwin' then
  vim.env.JAVA_HOME = '/Library/Java/JavaVirtualMachines/temurin-' .. ver ..'.jdk/Contents/Home'
else
  vim.env.JAVA_HOME = '/usr/lib64/jvm/java-' .. ver
end

