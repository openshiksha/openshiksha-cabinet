# hwcentral-cabinet
This repository acts as a cabinet for the HWCentral web project where all the meta data files are stored

NOTE:

Run the following commands when exposing this repository through nginx (with webDAV extension) ->

sudo find /path/to/hwcentral-cabinet/ -type d -exec chmod 777 {} +
sudo find /path/to/hwcentral-cabinet/ -type f -exec chmod 666 {} +
