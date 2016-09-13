require 'delegate'

class WrappedNum < DelegateClass(Fixnum)

  attr_reader :mod3_exe, :x5_exe

  def mod3
    @mod3_exe = (@mod3_exe ? @mod3_exe + 1 : 1)
    __getobj__ % 3
  end

  def x5
    @x5_exe = (@x5_exe ? @x5_exe + 1 : 1)
    (__getobj__ % 5).zero? ? :true : :false
  end
end
