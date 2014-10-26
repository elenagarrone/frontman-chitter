class Peep

	include  DataMapper::Resource

	belongs_to :user

	property :id, Serial
	property :message, Text
	property :date, Text, :default => (Time.now.strftime("%H:%M:%S - %d/%m/%Y"))

	validates_length_of :message, :in => (1..200)


end
