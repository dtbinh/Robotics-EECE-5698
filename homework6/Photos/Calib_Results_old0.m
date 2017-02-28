% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1928.724728734551945 ; 1931.178215827060740 ];

%-- Principal point:
cc = [ 1015.917073323450836 ; 607.338671677090588 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.147278197387264 ; -0.347443475109174 ; -0.001127923822744 ; 0.002728153868414 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 6.003391929674799 ; 5.809338264935099 ];

%-- Principal point uncertainty:
cc_error = [ 10.239986652186836 ; 6.978283174834889 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.021490956174749 ; 0.140073125271509 ; 0.001673131687290 ; 0.002441226452338 ; 0.000000000000000 ];

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
omc_1 = [ -1.822874e+00 ; -1.823517e+00 ; 6.194172e-01 ];
Tc_1  = [ -9.156449e+01 ; -7.018293e+01 ; 4.056656e+02 ];
omc_error_1 = [ 4.331788e-03 ; 3.699627e-03 ; 6.332382e-03 ];
Tc_error_1  = [ 2.164498e+00 ; 1.476183e+00 ; 1.102119e+00 ];

%-- Image #2:
omc_2 = [ -1.602476e+00 ; -1.879015e+00 ; 1.369917e-01 ];
Tc_2  = [ -7.403224e+01 ; -8.001771e+01 ; 4.058809e+02 ];
omc_error_2 = [ 3.342250e-03 ; 4.613369e-03 ; 6.230681e-03 ];
Tc_error_2  = [ 2.160846e+00 ; 1.470489e+00 ; 1.197515e+00 ];

%-- Image #3:
omc_3 = [ 1.814728e+00 ; 2.067363e+00 ; -1.249108e+00 ];
Tc_3  = [ -8.407661e+01 ; -7.162624e+01 ; 4.242693e+02 ];
omc_error_3 = [ 2.746096e-03 ; 4.847297e-03 ; 7.244032e-03 ];
Tc_error_3  = [ 2.277279e+00 ; 1.551870e+00 ; 1.088169e+00 ];

%-- Image #4:
omc_4 = [ 2.195202e+00 ; 2.183412e+00 ; -5.123809e-02 ];
Tc_4  = [ -9.696123e+01 ; -7.410636e+01 ; 3.336091e+02 ];
omc_error_4 = [ 4.272554e-03 ; 4.732935e-03 ; 9.809238e-03 ];
Tc_error_4  = [ 1.791173e+00 ; 1.220733e+00 ; 1.179847e+00 ];

%-- Image #5:
omc_5 = [ -1.872995e+00 ; -1.915942e+00 ; -5.960425e-01 ];
Tc_5  = [ -9.358088e+01 ; -4.459914e+01 ; 2.662850e+02 ];
omc_error_5 = [ 2.721316e-03 ; 4.359808e-03 ; 6.920870e-03 ];
Tc_error_5  = [ 1.426650e+00 ; 9.880749e-01 ; 1.013033e+00 ];

%-- Image #6:
omc_6 = [ 1.870118e+00 ; 1.846104e+00 ; -5.265222e-01 ];
Tc_6  = [ -1.017929e+02 ; -8.193824e+01 ; 3.600979e+02 ];
omc_error_6 = [ 2.686212e-03 ; 4.597067e-03 ; 6.870660e-03 ];
Tc_error_6  = [ 1.934467e+00 ; 1.318477e+00 ; 1.142888e+00 ];

%-- Image #7:
omc_7 = [ 1.838494e+00 ; 1.825405e+00 ; 2.132604e-01 ];
Tc_7  = [ -5.384886e+01 ; -7.836113e+01 ; 3.286885e+02 ];
omc_error_7 = [ 3.679967e-03 ; 4.240765e-03 ; 6.661660e-03 ];
Tc_error_7  = [ 1.760577e+00 ; 1.187207e+00 ; 1.130152e+00 ];

%-- Image #8:
omc_8 = [ 1.787726e+00 ; 1.799221e+00 ; 7.067251e-01 ];
Tc_8  = [ -4.940049e+01 ; -6.558835e+01 ; 3.252155e+02 ];
omc_error_8 = [ 4.433520e-03 ; 3.951219e-03 ; 6.155130e-03 ];
Tc_error_8  = [ 1.745521e+00 ; 1.180574e+00 ; 1.203571e+00 ];

%-- Image #9:
omc_9 = [ 1.787832e+00 ; 1.964394e+00 ; 1.262763e+00 ];
Tc_9  = [ -3.486061e+01 ; -4.576963e+01 ; 3.051672e+02 ];
omc_error_9 = [ 5.649799e-03 ; 3.477806e-03 ; 6.091522e-03 ];
Tc_error_9  = [ 1.634601e+00 ; 1.111617e+00 ; 1.188606e+00 ];

%-- Image #10:
omc_10 = [ 1.438075e+00 ; 1.711085e+00 ; 3.384907e-01 ];
Tc_10  = [ -4.297035e+01 ; -8.860342e+01 ; 3.704120e+02 ];
omc_error_10 = [ 3.557797e-03 ; 4.648435e-03 ; 5.278789e-03 ];
Tc_error_10  = [ 1.981044e+00 ; 1.339131e+00 ; 1.289435e+00 ];

%-- Image #11:
omc_11 = [ 1.643255e+00 ; 1.758535e+00 ; 7.407476e-02 ];
Tc_11  = [ -6.742849e+01 ; -8.421431e+01 ; 3.717999e+02 ];
omc_error_11 = [ 3.292148e-03 ; 4.558221e-03 ; 6.035754e-03 ];
Tc_error_11  = [ 1.988908e+00 ; 1.346846e+00 ; 1.259749e+00 ];

%-- Image #12:
omc_12 = [ -2.017638e+00 ; -2.137114e+00 ; -1.090240e+00 ];
Tc_12  = [ -4.925475e+01 ; -4.397715e+01 ; 2.681631e+02 ];
omc_error_12 = [ 2.452250e-03 ; 4.667095e-03 ; 7.758557e-03 ];
Tc_error_12  = [ 1.438449e+00 ; 9.797203e-01 ; 1.020730e+00 ];

%-- Image #13:
omc_13 = [ -1.738156e+00 ; -1.892119e+00 ; -1.076742e-01 ];
Tc_13  = [ -1.143597e+02 ; -7.115190e+01 ; 3.735810e+02 ];
omc_error_13 = [ 3.301839e-03 ; 4.421813e-03 ; 6.872344e-03 ];
Tc_error_13  = [ 1.996100e+00 ; 1.374278e+00 ; 1.279682e+00 ];

%-- Image #14:
omc_14 = [ -2.019669e+00 ; -2.047434e+00 ; 3.194654e-01 ];
Tc_14  = [ -1.090539e+02 ; -6.855363e+01 ; 4.099084e+02 ];
omc_error_14 = [ 4.492919e-03 ; 4.224028e-03 ; 8.391290e-03 ];
Tc_error_14  = [ 2.185711e+00 ; 1.497802e+00 ; 1.275109e+00 ];

%-- Image #15:
omc_15 = [ 2.054607e+00 ; 2.003358e+00 ; 3.475570e-01 ];
Tc_15  = [ -9.343399e+01 ; -6.722114e+01 ; 3.140703e+02 ];
omc_error_15 = [ 4.183197e-03 ; 4.198598e-03 ; 7.921711e-03 ];
Tc_error_15  = [ 1.703574e+00 ; 1.158734e+00 ; 1.153918e+00 ];

%-- Image #16:
omc_16 = [ 1.865497e+00 ; 1.855042e+00 ; -6.661379e-01 ];
Tc_16  = [ -9.291827e+01 ; -7.565443e+01 ; 3.384592e+02 ];
omc_error_16 = [ 2.608961e-03 ; 4.486742e-03 ; 6.830050e-03 ];
Tc_error_16  = [ 1.821479e+00 ; 1.234724e+00 ; 1.015777e+00 ];

%-- Image #17:
omc_17 = [ -1.771700e+00 ; -1.764648e+00 ; -6.452532e-01 ];
Tc_17  = [ -8.995281e+01 ; -2.456761e+01 ; 2.500193e+02 ];
omc_error_17 = [ 2.643157e-03 ; 4.531605e-03 ; 6.369087e-03 ];
Tc_error_17  = [ 1.331253e+00 ; 9.210580e-01 ; 9.295963e-01 ];

