3. Using UDP SOCKETS, write a client-server program to make the
client sending two numbers and an operator, and server
responding with the result. Display the result and appropriate
messages for invalid inputs at the client side.


## UDP-Server
import socket
localIP = &quot;127.0.0.1&quot;

localPort = 20002
bufferSize = 1024
UDPServerSocket = socket.socket(family=socket.
UDPServerSocket.bind((localIP, localPort))
print(&quot;UDP server up and listening...&quot;)
while(True):
bytesAddressPair = UDPServerSocket.recvfrom(
expression = bytesAddressPair[0].decode()
client_address = bytesAddressPair[1]
if expression:
result=eval(expression)
else:
result = &#39;Invalid expression.&#39;
print(&quot;Equation from client&quot;, client_address, &quot;:&quot;, expression)
print(&quot;Result to client:&quot;, result)
UDPServerSocket.sendto(str(
UDPServerSocket.close()

###UDP-Client
import socket
expr = input(&quot;Enter an expression:&quot;)
bytesToSend = str.encode(expr)
serverAddressPort = (&quot;127.0.0.1&quot;, 20001)
bufferSize = 1024
UDPClientSocket = socket.socket(family=socket.AF_INET,
type=socket.SOCK_DGRAM)

UDPClientSocket.sendto(bytesToSend, serverAddressPort)
msgFromServer = UDPClientSocket.recvfrom(bufferSize)
print(expr, &quot;=&quot;, msgFromServer[0].decode())
