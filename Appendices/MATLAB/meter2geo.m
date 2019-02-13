function [hk2, dh, h0] = meter2geo(meter4, meter5)
%METER2GEO Utilizes provided Table 2 Data to read out the value of the 2nd
%throat height and parameters for the variable diffuser height function ( dh/dx & h0) 

global NoZ2

hk2=0; dh=0; h0=0;

for i = 1:length(NoZ2.data.meter4)
    if NoZ2.data.meter4(i)==meter4 && NoZ2.data.meter5(i)==meter5
        hk2=NoZ2.data.hk2(i);
        dh=NoZ2.data.dh(i);
        h0=NoZ2.data.h0(i);
    end
end

if hk2==0 && dh==0 && h0==0
    disp('WARNING: No Valid Entry was Found in Look-up Table')
end

