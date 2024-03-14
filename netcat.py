import socket
import sys

encoding = 'utf-8'

def netcat(hostname, port, content):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((hostname, port))
    content = bytes(str(content).encode('utf-8'))
    s.sendall(content)
    #s.shutdown(socket.SHUT_WR)
    while 1:
        data = s.recv(1024)
        if len(data) == 0:
            break
        #data = repr(data)
        #data = str(data, encoding=encoding)
        print(data)
    print('Connection closed.')
    s.close()

print('netcat iniciado')
hostname = sys.argv[1]
port = int(sys.argv[2])
content = sys.argv[3]

#netcat('localhost', 59090, 'abc123')
netcat(hostname, port, content + '\n')