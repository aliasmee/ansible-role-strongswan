#!/bin/bash
config_line="{%for line in config_list %}{{line}} {%endfor%}"
cd {{download_dir}}/temp/strongswan-{{strongswan_version}}
./configure $config_line
