class CommandNotDefinedError < StandardError
  def message
    "command not defined"
  end
end
