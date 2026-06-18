fx_version 'cerulean'
games { 'rdr3', 'gta5' }

lua54 'yes'

ui_page 'html/index.html'

client_scripts {
    'client.lua'
}

files {
	'html/index.html',
	'html/main.js',
	'html/style.css',
	'html/sound_open.mp3',
	'html/sound_close.mp3',
	'html/sound_submit.mp3',
	'html/logo.png'
}

exports {
	'showDialog',
}
