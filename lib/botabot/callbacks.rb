# TODO: MUC-specific callbacks
module BotaBot
  class Callbacks
    def self.load
      Dir["#{BotaBot.root}/callbacks/*.rb"].each do |plugin|
        Kernel.load(plugin)
      end
    end
    
    def self.[](name, block)
      @callbacks ||= Hash.new
      return @callbacks["on_#{name}".to_sym]
    end
    
    def self.[]=(name, block)
      @callbacks ||= Hash.new
      @callbacks["on_#{name}".to_sym] = block
    end
    
    def self.each(&block)
      @callbacks.each do |method, proc|
        block.call(method, proc)
      end
    end
  end
end