% ||S - PD||^2_F = tr{ (S-PD)^H (S-PD) }
%                = tr{ (S^H - D^H P^H) (S-PD) }
%                = tr{ S^H (S-PD) - D^H P^H (S-PD) }
%                = tr{ S^H S - S^H PD - D^H P^H S + S^H P^H PD }
%                = tr{ S^H S } - tr{ S^H PD} - tr{ D^H P^H S }
%                                            + tr{ S^H P^H PD }
%
% min ||S - PD||^2_F => 0 = d/dP[ tr{.} ]
%
% Take derivative w.r.t. P
%
% 0 = d/dP[ tr{ S^H S } - tr{ S^H PD} - tr{ D^H P^H S }+ tr{ S^H P^H PD } ]
%   = 0 - SD^H - SD^H + PDD^H + PDD^H
%   = -2 SD^H + 2 PDD^H
% SD^H = PDD^H
% P = SD^H (DD^H)^-1
% P = SD^H D^-H D^-1
% P = S D^-1

function [ P ] = min_fro2(S,D)
    %P = S*D'/(D*D');
    P = S/D;
end