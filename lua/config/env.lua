local os_name = vim.loop.os_uname().sysname

if os_name == 'Darwin' then
  vim.env.JAVA_HOME = '/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home'
else
  vim.env.JAVA_HOME = '/usr/lib64/jvm/java-21'
end

