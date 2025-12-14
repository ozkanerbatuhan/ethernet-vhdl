library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package pkg_layer4 is
    constant IN_DIM    : integer := 16;
    constant OUT_DIM   : integer := 3;

    type matrix_3x16 is array(0 to 2) of array(0 to 15) of real;
    type vector_3 is array(0 to 2) of real;

    constant W4 : matrix_3x16 := (
        (to_fixed(-0.06314088, 16, 33), to_fixed(0.26972899, 16, 33), to_fixed(0.01683130, 16, 33), to_fixed(0.12986001, 16, 33), to_fixed(0.16176046, 16, 33), to_fixed(-0.46962327, 16, 33), to_fixed(-0.26436627, 16, 33), to_fixed(-0.30638441, 16, 33), to_fixed(0.17854132, 16, 33), to_fixed(0.14472696, 16, 33), to_fixed(0.11304652, 16, 33), to_fixed(0.03309791, 16, 33), to_fixed(-0.53335714, 16, 33), to_fixed(0.32639644, 16, 33), to_fixed(-0.21297541, 16, 33), to_fixed(0.05912658, 16, 33)),
        (to_fixed(-0.25139087, 16, 33), to_fixed(-0.25475276, 16, 33), to_fixed(0.32031700, 16, 33), to_fixed(-0.10498283, 16, 33), to_fixed(-0.31274247, 16, 33), to_fixed(-0.24263589, 16, 33), to_fixed(0.17249084, 16, 33), to_fixed(0.26705384, 16, 33), to_fixed(0.18815246, 16, 33), to_fixed(0.20194824, 16, 33), to_fixed(0.20190209, 16, 33), to_fixed(-0.32625660, 16, 33), to_fixed(-0.06273563, 16, 33), to_fixed(-0.06916679, 16, 33), to_fixed(-0.32860705, 16, 33), to_fixed(-0.41055846, 16, 33)),
        (to_fixed(-0.01073972, 16, 33), to_fixed(-0.03126822, 16, 33), to_fixed(-0.21818894, 16, 33), to_fixed(-0.38788897, 16, 33), to_fixed(0.16086891, 16, 33), to_fixed(0.67007238, 16, 33), to_fixed(-0.09674855, 16, 33), to_fixed(0.09107592, 16, 33), to_fixed(-0.24656847, 16, 33), to_fixed(-0.44283190, 16, 33), to_fixed(-0.41196892, 16, 33), to_fixed(0.20135812, 16, 33), to_fixed(0.29085353, 16, 33), to_fixed(-0.03179072, 16, 33), to_fixed(0.28669626, 16, 33), to_fixed(0.04555441, 16, 33))
    );

    constant b4 : vector_3 := (
        to_fixed(0.25293881, 16, 33),
        to_fixed(0.01001456, 16, 33),
        to_fixed(-0.07127640, 16, 33)
    );

end package pkg_layer4;
