class MirthSender
  def self.send(message)
    socket = TCPSocket.new('127.0.0.1', '6661')
    socket.write(message.to_hl7)
    socket.flush
    socket.close
  end
end