% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1929.581638215992598 ; 1932.524079232552822 ];

%-- Principal point:
cc = [ 1012.742712296037098 ; 604.922301541326419 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.140512695549310 ; -0.337001125104906 ; -0.001818422683847 ; 0.002057092257720 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 4.115066163041044 ; 3.984557351926008 ];

%-- Principal point uncertainty:
cc_error = [ 7.051747637926113 ; 4.789687673246902 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.014686393368777 ; 0.095817376581661 ; 0.001134838071209 ; 0.001662644590584 ; 0.000000000000000 ];

%-- Image size:
nx = 2048;
ny = 1152;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 17;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -1.822847e+00 ; -1.822653e+00 ; 6.218187e-01 ];
Tc_1  = [ -9.091163e+01 ; -6.967008e+01 ; 4.060174e+02 ];
omc_error_1 = [ 2.978927e-03 ; 2.552466e-03 ; 4.335753e-03 ];
Tc_error_1  = [ 1.490944e+00 ; 1.012952e+00 ; 7.563995e-01 ];

%-- Image #2:
omc_2 = [ -1.602731e+00 ; -1.877999e+00 ; 1.390481e-01 ];
Tc_2  = [ -7.337113e+01 ; -7.950031e+01 ; 4.061869e+02 ];
omc_error_2 = [ 2.294024e-03 ; 3.182625e-03 ; 4.274025e-03 ];
Tc_error_2  = [ 1.488426e+00 ; 1.009245e+00 ; 8.209265e-01 ];

%-- Image #3:
omc_3 = [ 1.813173e+00 ; 2.066721e+00 ; -1.252125e+00 ];
Tc_3  = [ -8.337382e+01 ; -7.107371e+01 ; 4.245451e+02 ];
omc_error_3 = [ 1.888518e-03 ; 3.326315e-03 ; 4.969377e-03 ];
Tc_error_3  = [ 1.567847e+00 ; 1.064471e+00 ; 7.475360e-01 ];

%-- Image #4:
omc_4 = [ 2.195087e+00 ; 2.183442e+00 ; -5.413860e-02 ];
Tc_4  = [ -9.640783e+01 ; -7.368123e+01 ; 3.338727e+02 ];
omc_error_4 = [ 2.931881e-03 ; 3.244208e-03 ; 6.731117e-03 ];
Tc_error_4  = [ 1.233914e+00 ; 8.375530e-01 ; 8.097332e-01 ];

%-- Image #5:
omc_5 = [ -1.873382e+00 ; -1.915428e+00 ; -5.937880e-01 ];
Tc_5  = [ -9.313948e+01 ; -4.423998e+01 ; 2.664576e+02 ];
omc_error_5 = [ 1.861746e-03 ; 2.998941e-03 ; 4.778298e-03 ];
Tc_error_5  = [ 9.821994e-01 ; 6.775151e-01 ; 6.966494e-01 ];

%-- Image #6:
omc_6 = [ 1.869145e+00 ; 1.846206e+00 ; -5.294624e-01 ];
Tc_6  = [ -1.012003e+02 ; -8.146539e+01 ; 3.603883e+02 ];
omc_error_6 = [ 1.845763e-03 ; 3.153989e-03 ; 4.710588e-03 ];
Tc_error_6  = [ 1.332401e+00 ; 9.045376e-01 ; 7.838980e-01 ];

%-- Image #7:
omc_7 = [ 1.838355e+00 ; 1.826419e+00 ; 2.100965e-01 ];
Tc_7  = [ -5.331411e+01 ; -7.794868e+01 ; 3.290454e+02 ];
omc_error_7 = [ 2.524362e-03 ; 2.907432e-03 ; 4.591633e-03 ];
Tc_error_7  = [ 1.212894e+00 ; 8.150623e-01 ; 7.754805e-01 ];

%-- Image #8:
omc_8 = [ 1.788077e+00 ; 1.800492e+00 ; 7.040437e-01 ];
Tc_8  = [ -4.887260e+01 ; -6.518038e+01 ; 3.255593e+02 ];
omc_error_8 = [ 3.043704e-03 ; 2.711243e-03 ; 4.247239e-03 ];
Tc_error_8  = [ 1.202229e+00 ; 8.102559e-01 ; 8.266222e-01 ];

%-- Image #9:
omc_9 = [ 1.788889e+00 ; 1.965795e+00 ; 1.260358e+00 ];
Tc_9  = [ -3.435813e+01 ; -4.537821e+01 ; 3.054238e+02 ];
omc_error_9 = [ 3.886618e-03 ; 2.391101e-03 ; 4.199257e-03 ];
Tc_error_9  = [ 1.125569e+00 ; 7.626861e-01 ; 8.162973e-01 ];

%-- Image #10:
omc_10 = [ 1.437818e+00 ; 1.712332e+00 ; 3.360613e-01 ];
Tc_10  = [ -4.236825e+01 ; -8.813732e+01 ; 3.707807e+02 ];
omc_error_10 = [ 2.441078e-03 ; 3.190556e-03 ; 3.637031e-03 ];
Tc_error_10  = [ 1.364466e+00 ; 9.193750e-01 ; 8.846972e-01 ];

%-- Image #11:
omc_11 = [ 1.642800e+00 ; 1.759427e+00 ; 7.129254e-02 ];
Tc_11  = [ -6.682563e+01 ; -8.374091e+01 ; 3.721622e+02 ];
omc_error_11 = [ 2.258989e-03 ; 3.126192e-03 ; 4.153725e-03 ];
Tc_error_11  = [ 1.370130e+00 ; 9.245957e-01 ; 8.640578e-01 ];

%-- Image #12:
omc_12 = [ -2.017096e+00 ; -2.136200e+00 ; -1.088852e+00 ];
Tc_12  = [ -4.876632e+01 ; -4.357186e+01 ; 2.683452e+02 ];
omc_error_12 = [ 1.682139e-03 ; 3.204029e-03 ; 5.355486e-03 ];
Tc_error_12  = [ 9.901306e-01 ; 6.719077e-01 ; 7.017870e-01 ];

%-- Image #13:
omc_13 = [ -1.738583e+00 ; -1.891368e+00 ; -1.058019e-01 ];
Tc_13  = [ -1.137600e+02 ; -7.066300e+01 ; 3.738928e+02 ];
omc_error_13 = [ 2.262688e-03 ; 3.048774e-03 ; 4.722884e-03 ];
Tc_error_13  = [ 1.375229e+00 ; 9.429758e-01 ; 8.779949e-01 ];

%-- Image #14:
omc_14 = [ -2.019900e+00 ; -2.047165e+00 ; 3.217264e-01 ];
Tc_14  = [ -1.084007e+02 ; -6.803224e+01 ; 4.102581e+02 ];
omc_error_14 = [ 3.089775e-03 ; 2.911967e-03 ; 5.742957e-03 ];
Tc_error_14  = [ 1.505597e+00 ; 1.027718e+00 ; 8.751086e-01 ];

%-- Image #15:
omc_15 = [ 2.054648e+00 ; 2.003804e+00 ; 3.447122e-01 ];
Tc_15  = [ -9.290403e+01 ; -6.681432e+01 ; 3.143183e+02 ];
omc_error_15 = [ 2.868293e-03 ; 2.874478e-03 ; 5.462580e-03 ];
Tc_error_15  = [ 1.173049e+00 ; 7.947922e-01 ; 7.928252e-01 ];

%-- Image #16:
omc_16 = [ 1.864406e+00 ; 1.855062e+00 ; -6.691698e-01 ];
Tc_16  = [ -9.235547e+01 ; -7.520569e+01 ; 3.387134e+02 ];
omc_error_16 = [ 1.793738e-03 ; 3.078319e-03 ; 4.681012e-03 ];
Tc_error_16  = [ 1.254355e+00 ; 8.470045e-01 ; 6.968889e-01 ];

%-- Image #17:
omc_17 = [ -1.772350e+00 ; -1.764046e+00 ; -6.428407e-01 ];
Tc_17  = [ -8.954312e+01 ; -2.423980e+01 ; 2.501715e+02 ];
omc_error_17 = [ 1.808612e-03 ; 3.117296e-03 ; 4.395973e-03 ];
Tc_error_17  = [ 9.167156e-01 ; 6.315970e-01 ; 6.394303e-01 ];

