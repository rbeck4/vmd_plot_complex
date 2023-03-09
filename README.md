Includes two scripts `plot_orbitals.tcl` and `plot_orbitals_real.tcl`.

The `plot_orbitals.tcl` will plot complex orbitals given in the .cube files
defined in 'file_root' with the extension 'file_ext' (lines 6/7).  The MOs
plotted will be in the range from 'mo_init' to 'mo_final' (lines 10/11) using
the Tachyon renderer.  Output is as a .bmp file.

Expected .cube files are the 'mag' and 'arg' .cube files from the plot.py
script on urania, and if doing 'plot_orbitals_real.tcl' then the real portions
are expected to be present as well.
