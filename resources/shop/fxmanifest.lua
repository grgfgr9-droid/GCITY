
fx_version 'adamant'

game 'gta5'
author "ZIZOU"
lua54 'yes'

shared_script {
    "@ZiZou/zizouconfig.lua"
}

client_script 'client/main.lua'
server_script {
    '@ZiZou/citizenfx/mysql/server/MySQL.lua',

    'server/main.lua',
}

files {
    'dist/index.html',
    'dist/src.css',
    'dist/scripts.js',
    'dist/assets/*.png'
}

ui_page 'dist/index.html'

shared_script 'shared/config.lua'

exports {
    'OpenShop'
}