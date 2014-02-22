require "rulers/version"
require "rulers/array"
require "rulers/routing"
require "rulers/util"
require "rulers/dependencies"

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404,
          {'Content-Type' => 'text/html'}, []]
      elsif env['PATH_INFO'] == "/"
        env['PATH_INFO'] = "/quotes/a_quote"
      end 

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      begin 
        text = controller.send(act)
      rescue 
        text = "There was an error."
      end 
      [200, {'Content-Type' => 'text/html'},
          [text]]
    end
  end 

  class Controller 
    def initialize(env)
      @env = env
    end 

    def env
      @env
    end 
  end 
end
