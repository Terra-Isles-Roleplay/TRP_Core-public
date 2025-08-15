fx_version 'cerulean'
game 'gta5'

name "TRPCore"
description "TRPCore"
author "Tristian R. / TRP Dev Team"
version "2.0.3-beta"

lua54 'on'

Dependencies {
	'ox_lib'
}

shared_scripts{
	'@ox_li/init.lua',
	'@TRP_lib/init.lua',
	'main.lua',
	'**/shared.lua',
	'modules/**/shared/*.lua',
	'**/**/shared.lua'
}

client_scripts{
	'**/client.lua',
	'**/**/client.lua',
	'**/c_main.lua',
	'**/c_config.lua',
	'modules/**/clients/*.lua',
}
server_scripts{
	'**/server.lua',
	'**/**/server.lua',
	'server.lua',
	'**/s_main.lua',
	'modules/**/server/*.lua',
	'**/s_config.lua'
}

files {
	'html/index.html',
	'html/style.css',
	'html/script.js',
}

ui_page 'html/index.html'
