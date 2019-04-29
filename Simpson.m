function [I] = Simpson(x,y)
%Simpson, uses the 1/3 simpson rule to create an integral in order to make
%an approimation of this integral.  Also uses trapizodal rule if nessisary
%created by Sam Tang on April 16th 2019, for mech 105
%X row matrix of the indepenent variable
%Y the coressponding valiue of the function at the x value
%I the approximated integral of the simpson and trapezoidal rule
%% Error checking of input
if nargin<2 
    error('an x and y row matrix are required to preform simpsons rule') % displays error if user does not input 2 arrays
elseif length(x)~=length(y)
    error('arrays x and y must be equal in length') % displays error if x and y are not of the same length
elseif isequal(diff(x),circshift(diff(x),1))==0 % compares the spacing of x to that of the spacing of x that is shifted circularlly by one
    error('x must be equally spaced')
else
end
%% Checking if trap rule is needed
if floor(length(x)/2)==length(x)/2
    needtrap=1; % if the floor of the length of x divided y 2 doesnt equal the unfloored version the array must have odd number of components
    warning('Trapezoidal rule will be used for the last interval')
else
    needtrap=0;
end
%% Preforming the 1/3 simpsons rule
if needtrap==0
    %% Simpsions rule without trapezoidal rule for the last interval
    for i=1:length(x)/2
        j=[1 2 3];
        j=j+2*(i-1);
        simsum(i)=1/6*(x(j(3))-x(j(1)))*(y(j(1))+4*y(j(2))+y(j(3)));
    end
else
    %% one iteration of trapezoidal rule is needed to be used
    for i=1:floor(length(x)/2)-1
        j=[1 2 3];
        j=j+2*(i-1);
        simsum(i)=1/6*(x(j(3))-x(j(1)))*(y(j(1))+4*y(j(2))+y(j(3)));
    end
    simsum(i+1)= (x(length(x))-x(length(x)-1))*(y(length(y))+y(length(y)-1))/2;
end
I= sum(simsum);
end

