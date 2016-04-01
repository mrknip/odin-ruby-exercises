require 'json'

module Hangman
  module FileIO
    def jsonify_vars
      obj_hash = {}
      self.instance_variables.each do |var|
        obj_hash[var] = self.instance_variable_get(var)
      end
      p obj_hash
      JSON.dump(obj_hash)
    end

    def objectify_json(string)
      JSON.load(string).each do |var, val|
        self.instance_variable_set var, val
      end
    end

    def shout
      puts "aaaaa"
    end

    def save(name)
      @path = "./data"

      File.open("#{@path}/#{name}.hgm", 'w+') do |file|
        File.write(file, self.jsonify_vars)
      end
    end

    def load(name)
      @path = "./data"
      json_string = File.read("#{@path}/#{name}.hgm") 
      objectify_json(json_string)
    end
  end
end
