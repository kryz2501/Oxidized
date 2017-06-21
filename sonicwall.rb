# Sonicwall #
# Firmware >=6.2
# by CE Copied from edgeswitch.rb

  comment '!'

  prompt /.*@.*>/

  cmd 'show current-config' do |cfg|
    cfg.each_line.to_a[2..-2].reject { |line| line.match /system-uptime.*/ or line.match /system-time.*/ }.join
  end

  cfg :telnet do
    username /User(name)?:\s?/
    password /^Password:\s?/
  end

  cfg :ssh do
    post_login do
      cmd 'no cli pager session'
    end
    pre_logout 'exit'
  end

end
