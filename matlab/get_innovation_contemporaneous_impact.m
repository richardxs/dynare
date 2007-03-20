function F = get_innovation_contemporaneous_impact('type')
% The approximated reduced form model is 
% 
%   Y^*_t = Z Y_t                   [Measure]
%   Y_t   = A*Y_{t-1} + B*E_t       [State]
%
% where Z is an p*m selection matrix (p<=m), Y^* is the p*1 vector of
% observable endogenous variables, Y is an m*1 vector of endogeneous
% variables, A is an m*m matrix, B is an m*r matrix (r<=m) and E an r*1 
% vector of structural innovations.   
% 
% The contemporaneous is return impact (on the observables) of an innovation is      
% given by F = Z*B. Matrix F is returned by this function.      
%
% INPUTS 
%   o type = "mode","mean"
%  
% OUTPUTS 
%   o F (F is also saved in a file)
%
%
% ALGORITHM
%   None.       
%
% SPECIAL REQUIREMENTS
%   This function need to be run after the estimation of a model.
%  
%  
% part of DYNARE, copyright S. Adjemian, M. Juillard (2006)
% Gnu Public License.
global oo_ M_ bayestopt_

if nargin == 0
    type = 'mode';
end

get_posterior_parameters(type);

Atheta(oo_.dr.order_var,M_.exo_names_orig_ord) = oo_.dr.ghu*sqrt(M_.Sigma_e);
F = Atheta(bayestopt_.mfys,:);

save([M_.fname '_InnovImpact',F]);