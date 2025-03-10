fx_version 'cerulean'
game 'gta5'

author 'JP Scripts'
description 'Pawnshop Script for QBCore'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_script 'client.lua'
server_script 'server.lua'
dependencies { 'qb-core', 'ox_target' }

lua54 'yes'