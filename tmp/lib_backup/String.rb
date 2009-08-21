class String
  
  #############################
  #       O R _ E L S E       #
  #############################  
  # Return an alternate string if blank.
  def or_else(alternate)
    if (blank?)
      return alternate
    else
      return self
    end
  end
end