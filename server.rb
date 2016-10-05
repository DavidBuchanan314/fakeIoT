require "socket"

server = TCPServer.new("0.0.0.0", 23)

loop do
	Thread.start(server.accept) do |client|
		_, _, _, ip = client.peeraddr
		puts "Connect:\t#{ip}"
		client.puts "Welcome to a vulnerable IoT device!" 
		client.write "\nLogin: "
		user = client.gets.chomp
		client.write "Password: "
		pass = client.gets.chomp
		puts "Login:\t\t#{user}:#{pass}@#{ip}"
		client.puts
		loop do
			client.write("# ")
			cmd = client.gets.chomp
			puts "#{ip}:\t#{cmd}"
			client.puts "sh: #{cmd.split.first}: command not found"
		end
	end
end
