fx_version 'cerulean'
game 'gta5'

author 'guapp0'
description 'A simple script to manage player wipes'
version '1.0.0'

shared_script 'config.lua'
server_script {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

dependency 'oxmysql'
