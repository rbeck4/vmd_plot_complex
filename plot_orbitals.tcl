#Script to render mos automatically
#
set res 1440
set isoval 0.008
set path "./cubs/"
set file_root "FilePrefix_mo_"
set file_ext ".cube"
puts $path$file_root$file_ext
# index of first and last mo to analyze, step default : 1
set mo_init 392
set mo_final 392
set step 1
render options POV3 povray +W%w +H%h -I%s -O%s.png +D +X -J +A0.01 +UA +FN
color Display Background white
display depthcue off
display rendermode GLSL
display projection orthographic
display resize $res $res
axes location Off
color change rgb 2 0.3499999940395355 0.3499999940395355 0.3499999940395355
color change rgb 9 0.821 0.493 0.493
color change rgb 15 0.534 0.534 0.801
color change rgb 31 0.945 0.294 0.025
color Element C gray
color Element H white
color Element Cr cyan
color Element I purple
color Element He cyan2
color Element Ne cyan2
color Element Ar cyan2
color Element Kr cyan2
color Element Xe cyan2
color Element P orange
color Element In pink
color Element Ag iceblue
color Element Cu orange2
color Element Yb cyan2

material change mirror Opaque 0.15
material change outline Opaque 4.000000
material change outlinewidth Opaque 0.5
material change ambient Glossy 0.1
material change diffuse Glossy 0.600000
material change opacity Glossy 0.75
material change shininess Glossy 1.0

material change ambient AOChalky 0.100000
material change diffuse AOChalky 0.750000
material change specular AOChalky 0.200000
material change shininess AOChalky 0.530000
material change mirror AOChalky 0.000000
material change opacity AOChalky 0.60
material change outline AOChalky 0.000000
material change outlinewidth AOChalky 0.000000
material change transmode AOChalky 0.000000

light 3 on

#Colorscale:
color scale method CET_C6
color scale midpoint 0.50
color scale min 0.06
color scale max 1.00

for {set i $mo_init} {$i < [expr $mo_final + 1]} {incr i $step} {
    display resetview
    foreach j {"a" "b"} {
        mol new  ${path}${file_root}${i}.cubetwoc_mag${j}${file_ext}
        set mid [molinfo top]
        mol addfile ${path}${file_root}${i}.cubetwoc_arg${j}${file_ext} type {cube} first 0 last -1 step 1 waitfor 1 volsets {0 } $mid
        mol modstyle 0 $mid Isosurface $isoval 0 0 0
        mol modcolor 0 $mid Volume 1
        mol modmaterial 0 $mid AOChalky
        mol addrep top
        mol modstyle 1 $mid  Isosurface -$isoval 0 0 0
        mol modcolor 1 $mid Volume 1
        mol modmaterial 1 $mid AOChalky
        #Colorscale:
        #mol scale max $mid 0 -3.14 3.14
        #mol scale max $mid 1 -3.14 3.14
        
        mol addrep top
        mol modstyle 2 $mid CPK 0.8 0.3 22.0 22.0
        mol modcolor 2 $mid element
        mol addrep top
        mol modstyle 3 $mid DynamicBonds 3.6 0.2 24
        mol modcolor 3 $mid element
        #mol modmaterial 3 $mid Transparent
        scale by 0.5
        rotate x by 20
    }
    #Translate:
    mol fix [expr $mid - 1]
    translate by 1.5 0. 0.
    mol free [expr $mid - 1]
    translate by -0.75 0. 0.

    #Color bar?
    ColorScaleBar::color_scale_bar

    #render POV3 /tmp/render.pov "povray" +W${res} +H${res} -I"/tmp/render.pov" -O"pic_mo${i}.png" +D +X +A0.01 -J +FN +UA
    render Tachyon /tmp/render.tach tachyon -numthreads 16 -res $res $res -aasamples 20 /tmp/render.tach -format BMP -o ${path}/${file_root}_${i}.bmp
    mol delete [expr $mid - 1]
    mol delete $mid
    
    #Remove Color bar
    ColorScaleBar::delete_color_scale_bar
    }
quit
