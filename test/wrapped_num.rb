require 'delegate'

class WrappedNum < DelegateClass(Fixnum)
  def mod3
    __getobj__ % 3
  end

  def x5
    (__getobj__ % 5).zero? ? :true : :false
  end
end
