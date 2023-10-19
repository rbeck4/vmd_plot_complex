#Script to render mos automatically
#
set res 2160
set isoval 0.015
set file_root NTOs/rasci_18312s.casscf_sa50_50s_ref.tzvpall.ybi6.opt_d3d_54.gdv_j14p.14542309.nto_i8_mo331_f13575_mo332
#Arriving/Leaving:
package require colorscalebar

color Display Background white
display depthcue off
display rendermode GLSL
display projection orthographic
display resize $res $res
axes location Off

color change rgb 2 0.3499999940395355 0.3499999940395355 0.3499999940395355
color change rgb 5 0.677 0.564 0.622
color change rgb 17 0.970 0.860 0.210
color change rgb 18 0.900 0.611 0.000

color Element Ar cyan2
color Element Ag green3
color Element Au yellow3
color Element Br red3
color Element C gray
color Element Cl lime
color Element Cr iceblue
color Element Cs violet2
color Element Cu orange2
color Element Er iceblue
color Element H white
color Element He cyan2
#color Element He violet2
color Element I purple
color Element In tan
color Element Kr cyan2
color Element N blue
color Element Na orange3
color Element Ne cyan2
color Element O red
color Element P orange
color Element Pb silver
color Element Si mauve
color Element Xe cyan2
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

material change ambient Diffuse 0.16
material change diffuse Diffuse 0.76
material change specular Diffuse 0.29
material change shininess Diffuse 0.63
material change mirror Diffuse 0.00
material change opacity Diffuse 1.0
material change outline Diffuse 1.180000
material change outlinewidth Diffuse 0.000000
material change transmode Diffuse 0.000000

material change ambient GlassBubble 0.17
material change diffuse GlassBubble 1.00
material change specular GlassBubble 0.58
material change shininess GlassBubble 0.91
material change mirror GlassBubble 0.00
material change opacity GlassBubble 0.45
material change outline GlassBubble 0.720000
material change outlinewidth GlassBubble 0.000000
material change transmode GlassBubble 0.000000

material change ambient Translucent 0.05
material change diffuse Translucent 0.80
material change specular Translucent 0.00
material change shininess Translucent 0.74
material change mirror Translucent 0.00
material change opacity Translucent 0.70
material change outline Translucent 1.700000
material change outlinewidth Translucent 0.000000
material change transmode Translucent 0.000000

light 3 on

#Colorscale:
color scale method CET_C2
color scale midpoint 0.50
color scale min 0.06
color scale max 1.00

display resetview

set bondLen 3.6
if {[string first "cl" $file_root] >= 0} {
  set bondLen 2.9
}
if {[string first "br" $file_root] >= 0} {
  set bondLen 3.3
}

foreach j {2} {

  #A+B surface
  mol new  ${file_root}_splitMagab_${j}.cube
  set mid [molinfo top]
  mol addfile ${file_root}_splitArgab_${j}.cube type {cube} first 0 last -1 step 1 waitfor 1 volsets {0 } $mid
  mol modstyle 0 $mid Isosurface $isoval 0 0 0
  mol modcolor 0 $mid Volume 1
  mol scaleminmax 0 $mid -3.14 3.14
  mol modmaterial 0 $mid Translucent
  mol addrep top
  mol modstyle 1 $mid  Isosurface -$isoval 0 0 0
  mol modcolor 1 $mid Volume 1
  mol modmaterial 1 $mid Translucent
  mol addrep top
  mol modstyle 2 $mid CPK 0.8 0.3 22.0 22.0
  mol modcolor 2 $mid element
  mol addrep top
  mol modstyle 3 $mid DynamicBonds $bondLen 0.2 24
  mol modcolor 3 $mid element
  
  #Separate A and B
  foreach i {"a" "b"} {
      
      
      #Colorscale:
      #mol scale max $mid 0 -3.14 3.14
      #mol scale max $mid 1 -3.14 3.14
      
      mol new  ${file_root}_splitMag${i}_${j}.cube
      set mid [molinfo top]
      mol addfile ${file_root}_splitArg${i}_${j}.cube type {cube} first 0 last -1 step 1 waitfor 1 volsets {0 } $mid
      mol modstyle 0 $mid Isosurface $isoval 0 0 0
      #mol modcolor 0 $mid ColorID 6
      mol modcolor 0 $mid Volume 1
      mol scaleminmax 0 $mid -3.14 3.14
      mol modmaterial 0 $mid GlassBubble
      mol addrep top
      mol modstyle 1 $mid  Isosurface -$isoval 0 0 0
      mol modcolor 1 $mid ColorID 6
      mol modmaterial 1 $mid GlassBubble
      mol addrep top
      mol modstyle 2 $mid CPK 0.8 0.3 22.0 22.0
      mol modcolor 2 $mid element
      mol addrep top
      mol modstyle 3 $mid DynamicBonds $bondLen 0.2 24
      mol modcolor 3 $mid element
      
      #REAL ISO:
      mol addfile ${file_root}_splitR${i}_${j}.cube type {cube} first 0 last -1 step 1 waitfor 1 volsets {0 } $mid
      mol addrep top
      mol modstyle 4 $mid Isosurface 0.025 2 0 0
      #mol modstyle 4 $mid Isosurface 0.025 1 0 0
      mol modcolor 4 $mid ColorID 1
      mol modmaterial 4 $mid Diffuse
      mol addrep top
      mol modstyle 5 $mid  Isosurface -0.025 2 0 0
      #mol modstyle 5 $mid  Isosurface -0.025 1 0 0
      mol modcolor 5 $mid ColorID 0
      mol modmaterial 5 $mid Diffuse
      
      scale by 0.50
      rotate x by 100
      rotate y by 30
      rotate z by 5
  }
  
  #Set color scale range:

  #Color bar?
  ColorScaleBar::color_scale_bar 1.00 0.15 0.2 0 -3.14 3.14 4

  
  #Translate:
  mol fix [expr $mid]
  mol fix [expr $mid - 1]
  translate by 0.05 1.50 0.
  mol free [expr $mid]
  mol free [expr $mid - 1]
  translate by 0.00 -0.75 0.
  
  mol fix [expr $mid - 1]
  mol fix [expr $mid - 2]
  translate by 1.5 0. 0.
  mol free [expr $mid - 1]
  translate by -0.75 0. 0.
  mol free [expr $mid - 2]
  
  
  #move color bar
  mol fix [expr $mid]
  mol fix [expr $mid - 1]
  mol fix [expr $mid - 2]
  mol free [expr $mid + 1]
  translate by -1.05 1.00 0.
  
  render Tachyon /tmp/render.tach tachyon -res $res $res -aasamples 5 /tmp/render.tach -format BMP -o ${file_root}_${j}_real.bmp
  mol delete [expr $mid - 2]
  mol delete [expr $mid - 1]
  mol delete $mid
  
  #Remove Color bar
  ColorScaleBar::delete_color_scale_bar

}
quit
