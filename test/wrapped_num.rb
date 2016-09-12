require 'delegate'

class WrappedNum < DelegateClass(Fixnum)
  def mod3
    __getobj__ % 3
  end
end
