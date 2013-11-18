module Gringotts
  
  class Config
    
    cattr_reader :enabled, :twilio, :delivery, :ignore_paths
 
    def self.loaded?
      return (@@loaded == true)
    end
    
    def self.load(raw_yaml)
      begin
        yaml = YAML.load(raw_yaml)[Rails.env]
      rescue Exception => e
        raise "Unable to load YAML [#{e.message}]"
      end
      
      @@enabled = parse(yaml, "enabled")
      @@twilio  = parse(yaml, "twilio", false)
      @@delivery = parse(yaml, "delivery", false)
      @@ignore_paths = parse(yaml, "ignore_paths", false)
      @@loaded = true
    end
    
    def self.parse(yaml, node, required = true)
      value = yaml[node.to_s]
      raise "Missing required value for [#{node}] in config/gringotts.yml" if required && value.nil?
      return value
    end
    
  end
  
end