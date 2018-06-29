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
    "\e[31m #{self} "
  end

  def blue
    "\e[34m #{self} "
  end
end