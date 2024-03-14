'''
Este script desliga todos os hosts xen/xcp-ng da seguinte forma:
Primeiro, identifica a vm Xo e o host onde ela reside.
Dispara o comando emergencyShutdown para todos os hosts, exceto no host onde reside a vm Xo.
Por último, dispara o emergencyShutdown para o host onde reside a vm Xo.
'''

import requests
import json
import os
import subprocess

base_url = 'http://xo'
token = '75Ur7llxUoNwUbhJEkUZXble3Haak8B4azBF6rZlOEs'

headers = {
    'Cookie': f'homeItemsPerPage=500; token={token}',
    'authenticationToken': token
}

# identificar em qual host reside a vm Xo
url = f'{base_url}/rest/v0/vms'
vms = json.loads(requests.request("GET", url, headers=headers).text)
print('vms:')
xo_vm_id = ''
for vm_id in vms:
    url = f'{base_url}{vm_id}'
    vm = json.loads(requests.request("GET", url, headers=headers).text)
    vm_name_label = vm['name_label']
    #print(vm_id + ' ' + vm_name_label)
    if vm_name_label == 'Xo':
        xo_vm_id = vm_id
        xo_affinity_host = '/rest/v0/hosts/' + vm['affinityHost']
#print(f'{len(vms)} vms')
print('Xo vm id: ' + xo_vm_id)
print('Xo vm affinity host: ' + xo_affinity_host)

# listar hosts
url = f'{base_url}/rest/v0/hosts'
hosts = json.loads(requests.request("GET", url, headers=headers).text)
print('hosts:')
print(*hosts, sep='\n')

# mover o host da vm Xo para o final da lista
hosts.remove(xo_affinity_host)
hosts.append(xo_affinity_host)
print('Reordered hosts:')
print(*hosts, sep='\n')

# autenticar no xo-cli
os.system(f'xo-cli --register --token {token} http://xo')

# disparar o comando emergencyShutdown para cada host
for host in hosts:
    # manter somenhte o id do host
    host = host.replace('/rest/v0/hosts/', '')
    # desligar host
    print(f'desligar host {host}')
    if host == '369eb766-2aa2-40b2-a8f7-ba6dfbdd4ce3':
        os.system(f'xo-cli host.emergencyShutdownHost host={host}')
    else:
        print('pular, teste')