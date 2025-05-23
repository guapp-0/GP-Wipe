fx_version 'cerulean'
game 'gta5'

author 'guapp0'
description 'A simple script to manage player wipes'
version '1.0.0'


server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@ox_lib/init.lua',
    'server.lua',
    'exports.lua'
}

dependencies {
    'oxmysql',
    'ox_lib',
    'es_extended'
}
