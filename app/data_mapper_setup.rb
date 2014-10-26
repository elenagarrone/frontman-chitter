env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/chitter_#{env}")

require_relative 'models/peep'
require_relative 'models/user'

DataMapper.finalize