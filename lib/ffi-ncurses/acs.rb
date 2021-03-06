# -*- coding: utf-8 -*-
require 'ffi-ncurses/ord_shim'

module FFI
  module NCurses
    module ACS
      def maybe_const_set(name, value)
        if !const_defined?(name)
          const_set name, value
        end
      end

      def define_acs(name, char)
        maybe_const_set name, acs_map[char[0].ord]
      end

      # We have to define these dynamically as =acs_map= is not initialized until =init_scr= has been called
      def define_acs_constants
        #          Name           Default Description
        # -------------------------------------------
        define_acs :ACS_ULCORNER, 'l'   # upper left corner
        define_acs :ACS_LLCORNER, 'm'   # lower left corner
        define_acs :ACS_URCORNER ,'k'   # upper right corner
        define_acs :ACS_LRCORNER ,'j'   # lower right corner
        define_acs :ACS_LTEE     ,'t'   # tee pointing right
        define_acs :ACS_RTEE     ,'u'   # tee pointing left
        define_acs :ACS_BTEE     ,'v'   # tee pointing up
        define_acs :ACS_TTEE     ,'w'   # tee pointing down
        define_acs :ACS_HLINE    ,'q'   # horizontal line
        define_acs :ACS_VLINE    ,'x'   # vertical line
        define_acs :ACS_PLUS     ,'n'   # large plus or crossover
        define_acs :ACS_S1       ,'o'   # scan line 1
        define_acs :ACS_S9       ,'s'   # scan line 9
        define_acs :ACS_DIAMOND  ,'`'   # diamond
        define_acs :ACS_CKBOARD  ,'a'   # checker board (stipple)
        define_acs :ACS_DEGREE   ,'f'   # degree symbol
        define_acs :ACS_PLMINUS  ,'g'   # plus/minus
        define_acs :ACS_BULLET   ,'~'   # bullet
        # Teletype 5410v1 symbols begin here
        define_acs :ACS_LARROW   ,','   # arrow pointing left
        define_acs :ACS_RARROW   ,'+'   # arrow pointing right
        define_acs :ACS_DARROW   ,'.'   # arrow pointing down
        define_acs :ACS_UARROW   ,'-'   # arrow pointing up
        define_acs :ACS_BOARD    ,'h'   # board of squares
        define_acs :ACS_LANTERN  ,'i'   # lantern symbol
        define_acs :ACS_BLOCK    ,'0'   # solid square block

        # These aren't documented, but a lot of System Vs have them anyway
        # (you can spot pprryyzz{{||}} in a lot of AT&T terminfo strings).
        # The ACS_names may not match AT&T's, our source didn't know them.

        define_acs :ACS_S3       ,'p'   # scan line 3
        define_acs :ACS_S7       ,'r'   # scan line 7 - SOH: seems to be same as ACS_HLINE
        define_acs :ACS_LEQUAL   ,'y'   # less/equal
        define_acs :ACS_GEQUAL   ,'z'   # greater/equal
        define_acs :ACS_PI       ,'{'   # Pi
        define_acs :ACS_NEQUAL   ,'|'   # not equal
        define_acs :ACS_STERLING ,'}'   # UK pound sign

        # Line drawing ACS names are of the form ACS_trbl, where t is the top, r
        # is the right, b is the bottom, and l is the left.  t, r, b, and l might
        # be B (blank), S (single), D (double), or T (thick).  The subset defined
        # here only uses B and S.
        #
        # See the WACS_x_trbl constants below for the full set.

        maybe_const_set :ACS_BSSB, ACS_ULCORNER
        maybe_const_set :ACS_SSBB, ACS_LLCORNER
        maybe_const_set :ACS_BBSS, ACS_URCORNER
        maybe_const_set :ACS_SBBS, ACS_LRCORNER
        maybe_const_set :ACS_SBSS, ACS_RTEE
        maybe_const_set :ACS_SSSB, ACS_LTEE
        maybe_const_set :ACS_SSBS, ACS_BTEE
        maybe_const_set :ACS_BSSS, ACS_TTEE
        maybe_const_set :ACS_BSBS, ACS_HLINE
        maybe_const_set :ACS_SBSB, ACS_VLINE
        maybe_const_set :ACS_SSSS, ACS_PLUS
      end
    end
    include ACS

    # Wide character versions. These are Unicode definitions so
    # don't need to be defined dynamically.
    #
    # From http://invisible-island.net/ncurses/man/curs_add_wch.3x.html
    #
    # Name            Unicode    Default   Description
    # ----------------------------------------------------------------
    WACS_BLOCK      = 0x25ae  #  #         solid square block
    WACS_BOARD      = 0x2592  #  #         board of squares
    WACS_BTEE       = 0x2534  #  +         bottom tee
    WACS_BULLET     = 0x00b7  #  o         bullet
    WACS_CKBOARD    = 0x2592  #  :         checker board (stipple)
    WACS_DARROW     = 0x2193  #  v         arrow pointing down
    WACS_DEGREE     = 0x00b0  #  '         degree symbol
    WACS_DIAMOND    = 0x25c6  #  +         diamond
    WACS_GEQUAL     = 0x2265  #  >         greater-than-or-equal-to
    WACS_HLINE      = 0x2500  #  -         horizontal line
    WACS_LANTERN    = 0x2603  #  #         lantern symbol
    WACS_LARROW     = 0x2190  #  <         arrow pointing left
    WACS_LEQUAL     = 0x2264  #  <         less-than-or-equal-to
    WACS_LLCORNER   = 0x2514  #  +         lower left-hand corner
    WACS_LRCORNER   = 0x2518  #  +         lower right-hand corner
    WACS_LTEE       = 0x2524  #  +         left tee
    WACS_NEQUAL     = 0x2260  #  !         not-equal
    WACS_PI         = 0x03c0  #  *         greek pi
    WACS_PLMINUS    = 0x00b1  #  #         plus/minus
    WACS_PLUS       = 0x253c  #  +         plus
    WACS_RARROW     = 0x2192  #  >         arrow pointing right
    WACS_RTEE       = 0x251c  #  +         right tee
    WACS_S1         = 0x23ba  #  -         scan line 1
    WACS_S3         = 0x23bb  #  -         scan line 3
    WACS_S7         = 0x23bc  #  -         scan line 7
    WACS_S9         = 0x23bd  #  _         scan line 9
    WACS_STERLING   = 0x00a3  #  f         pound-sterling symbol
    WACS_TTEE       = 0x252c  #  +         top tee
    WACS_UARROW     = 0x2191  #  ^         arrow pointing up
    WACS_ULCORNER   = 0x250c  #  +         upper left-hand corner
    WACS_URCORNER   = 0x2510  #  +         upper right-hand corner
    WACS_VLINE      = 0x2502  #  |         vertical line

    # The wide-character configuration of ncurses also defines symbols
    # for thick- and double-lines:

    # Name            Unicode    Default   Description
    # ---------------------------------------------------------------------
    WACS_T_ULCORNER = 0x250f  #  +         thick upper left corner
    WACS_T_LLCORNER = 0x2517  #  +         thick lower left corner
    WACS_T_URCORNER = 0x2513  #  +         thick upper right corner
    WACS_T_LRCORNER = 0x251b  #  +         thick lower right corner
    WACS_T_LTEE     = 0x252b  #  +         thick tee pointing right
    WACS_T_RTEE     = 0x2523  #  +         thick tee pointing left
    WACS_T_BTEE     = 0x253b  #  +         thick tee pointing up
    WACS_T_TTEE     = 0x2533  #  +         thick tee pointing down
    WACS_T_HLINE    = 0x2501  #  -         thick horizontal line
    WACS_T_VLINE    = 0x2503  #  |         thick vertical line
    WACS_T_PLUS     = 0x254b  #  +         thick large plus or crossover
    WACS_D_ULCORNER = 0x2554  #  +         double upper left corner
    WACS_D_LLCORNER = 0x255a  #  +         double lower left corner
    WACS_D_URCORNER = 0x2557  #  +         double upper right corner
    WACS_D_LRCORNER = 0x255d  #  +         double lower right corner
    WACS_D_RTEE     = 0x2563  #  +         double tee pointing left
    WACS_D_LTEE     = 0x2560  #  +         double tee pointing right
    WACS_D_BTEE     = 0x2569  #  +         double tee pointing up
    WACS_D_TTEE     = 0x2566  #  +         double tee pointing down
    WACS_D_HLINE    = 0x2550  #  -         double horizontal line
    WACS_D_VLINE    = 0x2551  #  |         double vertical line
    WACS_D_PLUS     = 0x256c  #  +         double large plus or crossover
  end
end
