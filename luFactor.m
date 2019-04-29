function [L,U,P] = luFactor(A)
%Function determoines the LU factorization of a square matrix that utilizes
%parital pivoting and reverse gauiss elimination
%   [L,U,P]=luFactor(A)
%   L = lower triangular matrix with the coefficents used for elimination
%   U = upper triangular matrix with the remainders of the elimination
%   P = The pivot matrix, the idenity matrix that is manipulated using
%   pivoting
%   A = the matrix that is inputted into the function
%************************************************************************************************************************************************************************************************************************************************************************************
%Created by Samuel Tang on April 1 2019 for the class MECH 105 algorithim
%HW 2
%% Checking if the matrix is square or not
[row,col]=size(A); % takes the size of the rows and the columns of the matrix inputted
if row ~= col
    error('The matrix must be square to perform LU factorization') % tells the user that they inputted a nonsquare matrix and that thier first born will pay the price
end
%% creating L U and P as empty vectors
L = eye(row,col); %creation of the L matrix as an identity matrix
P = eye(row,col); % creation of the Pivot matrix
j=0; %used for indexing variables 
for i=1:col-1
    %% Pivot me Timbers
    [~,index]= max(abs(A(i:col,i))); % finding the row that has the largest coefficent of the specified column which depends on the loop
    temprow1= A(i,:); % creating temporary housing for the row that is being replaced by the new row with larger coefficents
    temprolace= A(index+j,:);% creating a temporary house for the row that is going to replace the uppermost row
    A(i,:)=temprolace; %replacing the uppermost row with the higher coefficent one
    A(index+j,:)=temprow1; % replacing the old place of the new upper with the lower
    %% Altering the Pivot Matrix using the same process above
    tempivot= P(i,:);
    P(i,:)=P(index+j,:);
    P(index+j,:)=tempivot;
    %%  Pivoting the L matrix
    if i>1 % this if statement prevents the l matrix from shifting in the first iteration in which there is no need to pivot and will not function with i=1
        tempL= L(i,1:i-1);
        L(i,1:i-1)=L(index+j,1:i-1);
        L(index+j,1:i-1)=tempL;
    end
    %% The magic cabin for Gauiss Elimination
    for k=i+1:row
        %dividing the coeffients to create L
        L(k,i)= A(k,i)/A(i,i);
        %Multiplying the denomenator of the rows by L to get the elimnator
        Usub= A(i,:)*L(k,i);
        A(k,:)=A(k,:)-Usub; %replacing the row in question with the eliminated version
    end
    %% i-1 becuase thats easier to write than i-1 everytime
    j=j+1;
end
U=A; %replacing u with the modified vector a as it is now the upper trianglar matrix
end
