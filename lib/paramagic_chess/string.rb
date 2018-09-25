# frozen_string_literal: true

class String
  def bg_black
    "\e[40m#{self}\e[0m"
  end

  def bg_white
    "\e[47m#{self}\e[0m"
  end

  def white
    "\e[37m#{self}"
  end

  def black
    "\e[30m#{self}"
  end

  def red
    "\e[31m #{self} \e[0m"
  end

  def highlight
    "\e[30;43m#{self}\e[0m"
  end

  def blue
    "\e[35m #{self} \e[0m"
  end
end
