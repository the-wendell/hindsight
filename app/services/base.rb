module Services
  class Base
    def self.call(*args)
      new(*args).yield_self(&:call)
    end
  end
end