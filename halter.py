#!/usr/bin/env python3

import socketserver
import sys
import os
import json
import requests
import logging
from vielog import get_viemar_logger

PORT = 59090
ALLOWED_SOURCES = ["127.0.0.1", "10.0.1.7", "10.0.1.13"]
VERSION = "2024.03.19.01"
SECRET = "abc123"

log = get_viemar_logger("log", "halter", logging.DEBUG, logging.INFO)


class ServerHandler(socketserver.StreamRequestHandler):
    def handle(self):
        try:
            self.write_print(
                f"Servidor Halter Versao {VERSION} - Pronto para receber uma linha"
            )
            self.write_print(f"Conexao recebida de {self.client_address[0]}")

            if self.client_address[0] not in ALLOWED_SOURCES:
                self.write_print("Cliente nao permitido")
                return

            line = self.read()
            self.write_print(f"Linha recebida: {line}")

            msg = "Linha aceita. Executar halt"
            if line != SECRET:
                self.write_print("Linha rejeitada")
                return

            self.write_print(msg)
            self.halt()
            self.write_print("Halt disparado")
        except Exception as e:
            self.write_print(e)

    def read(self):
        return self.rfile.readline().decode("utf-8").strip()

    def write(self, text):
        self.wfile.write(f"{text}\r\n".encode("utf-8"))

    def write_print(self, msg):
        # print(msg)
        log.info(msg)
        self.write(msg)

    def halt(self):
        if sys.platform.startswith(
            "linux"
        ):  # could be "linux", "linux2", "linux3", ...
            f = open("/etc/issue", "r")
            line = f.readline()
            f.close()
            if "Debian" in line:
                self.write_print("Sistema Operacional: debian xen orchestra")
                # cmd = 'sleep 5 && shutdown -h now'
                self.xo_emergency_shutdown()
            else:
                self.write_print("Sistema Operacional: linux")
                self.execute_command("sleep 5 && shutdown -h now")
        elif sys.platform == "darwin":
            self.write_print("Sistema Operacional: mac os")
        elif sys.platform.startswith("freebsd"):
            self.write_print("Sistema Operacional: freebsd (truenas ou pfsense)")
            self.execute_command("sleep 5 && yes | shutdown -p now")
        elif os.name == "nt":
            self.write_print("Sistema Operacional: windows")
            self.execute_command("shutdown /s /t 5")
        else:
            self.write_print(
                f"Sistema operacional não programado: {sys.platform} {os.name}"
            )

        # print(f'Sistema operacional: {os_name}')

        # if cmd != '':
        #     print(f'Executando comando: {cmd}')
        #     os.system(cmd)
        # else:
        #     print('Sem comando para executar (sistema operacional não previsto)')

    def execute_command(self, cmd):
        self.write_print(f"Executando comando: {cmd}")
        os.system(cmd)

    def xo_emergency_shutdown(self):
        """
        Esta função desliga todos os hosts xen/xcp-ng, deixando por último o host onde reside a vm Xo
        """

        base_url = "http://xo"
        token = "75Ur7llxUoNwUbhJEkUZXble3Haak8B4azBF6rZlOEs"

        headers = {
            "Cookie": f"homeItemsPerPage=500; token={token}",
            "authenticationToken": token,
        }

        # identificar em qual host reside a vm Xo
        url = f"{base_url}/rest/v0/vms"
        vms = json.loads(requests.request("GET", url, headers=headers).text)
        self.write_print("vms:")
        xo_vm_id = ""
        for vm_id in vms:
            url = f"{base_url}{vm_id}"
            vm = json.loads(requests.request("GET", url, headers=headers).text)
            vm_name_label = vm["name_label"]
            # print(vm_id + ' ' + vm_name_label)
            if vm_name_label == "Xo":
                xo_vm_id = vm_id
                xo_affinity_host = "/rest/v0/hosts/" + vm["affinityHost"]
        # print(f'{len(vms)} vms')
        self.write_print("Xo vm id: " + xo_vm_id)
        self.write_print("Xo vm affinity host: " + xo_affinity_host)

        # listar hosts
        url = f"{base_url}/rest/v0/hosts"
        hosts = json.loads(requests.request("GET", url, headers=headers).text)
        self.write_print("hosts:")
        # print(*hosts, sep='\n')
        self.write_print("\n".join(hosts))

        # mover o host da vm Xo para o final da lista
        hosts.remove(xo_affinity_host)
        hosts.append(xo_affinity_host)
        self.write_print("Reordered hosts:")
        # print(*hosts, sep='\n')
        self.write_print("\n".join(hosts))

        # autenticar no xo-cli
        os.system(f"xo-cli --register --token {token} http://xo")

        # disparar o comando emergencyShutdown para cada host
        for host in hosts:
            # manter somenhte o id do host
            host = host.replace("/rest/v0/hosts/", "")
            # desligar host
            self.write_print(f"desligar host {host}")
            if host == "369eb766-2aa2-40b2-a8f7-ba6dfbdd4ce3":
                os.system(f"xo-cli host.emergencyShutdownHost host={host}")
            else:
                self.write_print("pular, teste")


class ThreadedTCPServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    pass


def main():
    with ThreadedTCPServer(("", PORT), ServerHandler) as server:
        print(f"Servidor escutando na porta TCP {PORT}")
        server.serve_forever()


if __name__ == "__main__":
    main()
