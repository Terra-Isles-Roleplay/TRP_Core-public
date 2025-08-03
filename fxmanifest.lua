fx_version 'cerulean'
game 'gta5'

name "TRPCore"
description "TRPCore"
author "Tristian R. / TRP Dev Team"
version "2.0.2-beta"

lua54 'on'

shared_scripts{
	'@ox_lib/init.lua',
	'@TRP_lib/init.lua',
	'main.lua',
	'**/shared.lua',
	'**/**/shared.lua'
}

client_scripts{
	'**/client.lua',
	'**/**/client.lua',
	'**/c_main.lua',
	'**/c_config.lua',
}
server_scripts{
	'**/server.lua',
	'**/**/server.lua',
	'server.lua',
	'**/s_main.lua',
	'**/s_config.lua'
}

files {
	'html/index.html',
	'html/style.css',
	'html/script.js',
}

ui_page 'html/index.html'