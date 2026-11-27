fx_version 'cerulean'
game 'gta5'

author 'Pure Studio'
description 'Pure Vending Machine adds player-owned vending machines to FiveM. Owners buy machines, set prices, hire staff and earn from every sale, while stock is ordered from a supplier and delivered by hand with a cart. Admins place and manage every machine from an in-game panel.'

scriptname 'p_vendingmachine'
version '1.0.1'

dependencies {
    'ox_lib',
    'oxmysql',
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/utils.lua',
    'shared/main.lua',
    'frameworks/main.lua',
    'modules/main.lua',
    'modules/inventory/main.lua',
}

client_scripts {
    'frameworks/**/cl-main.lua',
    'modules/**/cl-main.lua',
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'frameworks/**/sv-main.lua',
    'modules/**/sv-main.lua',
    'server/queries.lua',
    'server/sv-*.lua',
}

files {
    'config/*.lua',
    'web/dist/*.*',
    'web/dist/**/*.*',
    'locales/*.json',
}

ui_page 'web/dist/index.html'

lua54 'yes'
use_experimental_fxv2_oal 'yes'
data_file 'DLC_ITYP_REQUEST' 'stream/hype_cargo_box.ytyp'
