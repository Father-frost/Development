                    HP LaserJet 5L Softfont Installation
                   =======================================

The HP LaserJet 5L Cyrillic Softfonts diskette contains the following files:

* SETUPDL5.EXE - Installation program.
* DL5.EXE      - The download utility.
* DEFAULT.PJL  - PJL file used by download utility.
* README.TXT   - This file.
* README.EXE   - Readme file viewer.

And the following scaleable DOS font files (CP-866):

* CUR00CPO.SFS - Cyrillic Courier Regular.
* CUB00CPO.SFS - Cyrillic Courier Bold.
* CUI00CPO.SFS - Cyrillic Courier Italic.
* CUJ00CPO.SFS - Cyrillic Courier Bold Italic.


 HARD DISK INSTALLATION
========================
  The SETUPDL5 program prompts you for the hard disk name ("C" by default)
  and the directory name ("LJ5DL" by default) where to install the files.

  SETUPDL5 copies all necessary files to specified directory.

 LOADING THE FONTS
===================
  In order to download the fonts to your HP LaserJet 5L, run DL5.EXE either
  from the floppy disk or from the installation directory ("C:\LJ5DL" by
  default).

   SYNTAX: DL5 [LPTx] [/A]

    LPTx   Where x is the parallel port number to be used.
           (LPT1 by default)

    /A     Download ALL fonts.
           Warning: When using this option printer memory shortage may occur.
           (by default, ONLY Courier Regular will be loaded)

  DL5 loads the fonts into the printer and selects CP-866 Courier 12 point
  10 CPI Regular as default font (symbol set 3R).

  The default font and symbol set are required mainly for "direct" printing
  where no printer drivers are used (such as "Print Screen").

  The fonts stay resident as long as the printer is powered.
  They are assigned the following ID numbers:

      Courier Regular     - 27001
      Courier Bold        - 27002
      Courier Italic      - 27003
      Courier Bold Italic - 27004

                                   *   *   *
                                     *   *
                                       *
