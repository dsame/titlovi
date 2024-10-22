#!/bin/bash
video="$1"
t1="$2"
t2="$3"
out="$4"

ffmpeg -i "$video" -i "$t1" -i "$t2" -map 0 -map 1 -map 2 -vcodec copy -acodec copy -c:s:0 mov_text -c:s:1 mov_text -metadata:s:s:0 language=SR -metadata:s:s:0 handler_name=Srpski_Cyr -metadata:s:s:0 title=Српски -metadata:s:s:1 language=SR_LAT -metadata:s:s:1 handler_name=Srpski_Lat -metadata:s:s:1 title=Srpski $"out"
