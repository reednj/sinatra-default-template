require 'sequel'
require_relative '../config/app.config'

DB = Sequel.connect DB_CONFIG

# this will check the db is still connected every hour or so, and connect it
# without an exception if it has timed out. If this isn't here, every so often
# clients will get 'mysql server went away errors'
DB.extension(:connection_validator)

# these warnings are useful, but they print with a full stack trace, which makes 
# stderr very hard to read. Better to get rid of them altogether
Sequel::Deprecation.output = nil

class Sequel::Model
	def to_json(args)
		self.values.to_json(args)
	end
end

class User < Sequel::Model

	dataset_module do
		def exist?(id)
			!self[id].nil?
		end
	end

end

DB.disconnect
