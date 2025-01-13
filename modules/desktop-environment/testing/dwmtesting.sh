rm -rf dwm-6.5
tar -xvf dwm-6.5.tar.gz

cd dwm-6.5

patch < ../../patch.dwm.1.center.diff
patch < ../../patch.dwm.2.switchtotag.diff
patch < ../../patch.dwm.3.config.def.h.diff
