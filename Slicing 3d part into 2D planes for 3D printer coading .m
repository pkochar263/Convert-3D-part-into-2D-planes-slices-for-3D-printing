clc
clear all
close all
T=xlsread('triangle_data');
N=size(T);
N1=N(1,1);% TO GET NO OF TRIANGLES

I = ['Total no of input triangles are ',num2str(N1)];
disp(I);
disp('Enter SLICE HEIGHT ');
     Z_GIVEN=input('  ');
%PLANE OF DESIRED SLICE HEIGHT

A=0;B=0;C=1;D=Z_GIVEN;

[x y] = meshgrid(-1:0.1:1); % Generate x and y data
z = 1/C*(A*x + B*y + D); % Solve for z data
surf(x,y,z) %Plot the surface
hold on

syms p1 p2 p3 p4 p5 p6 p7 p8 p9

for i=1:N1
X1=T(i,1);Y1=T(i,2);Z1=T(i,3);
X2=T(i,4);Y2=T(i,5);Z2=T(i,6);
X3=T(i,7);Y3=T(i,8);Z3=T(i,9);
X=[X1,X2,X3,X1];Y=[Y1,Y2,Y3,Y1];Z=[Z1,Z2,Z3,Z1];
%TO CREATE TRIANGLE FROM TRIANGLE DATA
L=line(X,Y,Z);
hold on
end
hold on
COUN=0;%HOW MANY TRIANGLES ARE CUTTING PLANE 
for i=1:N1
    X1=T(i,1);Y1=T(i,2);Z1=T(i,3);
X2=T(i,4);Y2=T(i,5);Z2=T(i,6);
X3=T(i,7);Y3=T(i,8);Z3=T(i,9);
X=[X1,X2,X3,X1];Y=[Y1,Y2,Y3,Y1];Z=[Z1,Z2,Z3,Z1];
if (min(Z) <= Z_GIVEN)  && (max(Z)>=Z_GIVEN)
   COUN=COUN+1;
end
end
   TRI_CUT = ['Total TRIANGLE CUTTING THE PLANE ARE ',num2str(COUN)];
disp(TRI_CUT);
%CREATING ZEROS FOR PATCH
AA=zeros(COUN,1);BB=zeros(COUN,1);CC=zeros(COUN,1);
DD=zeros(COUN,1);EE=zeros(COUN,1);FF=zeros(COUN,1);
GG=zeros(COUN,1);HH=zeros(COUN,1);II=zeros(COUN,1);
%FOR LOOP TO KNOW THE POINTS
for i=1:N1
    X1=T(i,1);Y1=T(i,2);Z1=T(i,3);
    X2=T(i,4);Y2=T(i,5);Z2=T(i,6);
    X3=T(i,7);Y3=T(i,8);Z3=T(i,9);
    %LINE Z1& Z2
if (min(Z1,Z2) <= Z_GIVEN)  && (max(Z1,Z2)>=Z_GIVEN)
 
    equ1=(p1-X1)/(X2-X1) == (p2-Y1)/(Y2-Y1);
    equ2= p3 == Z_GIVEN;
    equ3=(p3-Z1)/(Z2-Z1)==(p1-X1)/(X2-X1);
    soln=solve([equ1,equ2,equ3],[p1,p2,p3]);
   plot3(soln.p1,soln.p2,soln.p3,'*k');
   hold on
   AAA(i,1)=soln.p1;
   BBB(i,1)=soln.p2;
   CCC(i,1)=soln.p3;

  AA(i,1)=AA(i,1)+AAA(i,1);
    BB(i,1)=BB(i,1)+BBB(i,1);
     CC(i,1)=CC(i,1)+CCC(i,1);
%   view(3);patch(AA,BB,CC,'g');

   hold on
   %LINE Z2& Z3
 elseif (min(Z2,Z3) <= Z_GIVEN)  && (max(Z2,Z3)>=Z_GIVEN)
   equ4=(p4-X2)/(X3-X2) == (p5-Y2)/(Y3-Y2);
    equ5=p6 == Z_GIVEN;
    equ6=(p6-Z2)/(Z3-Z2)==(p4-X2)/(X3-X2);
    soln=solve([equ4,equ5,equ6],[p4,p5,p6]);
   plot3(soln.p4,soln.p5,soln.p6,'*m');
   hold on
   
  DDD(i,1)=soln.p4;
   EEE(i,1)=soln.p5;
   FFF(i,1)=soln.p6;

  DD(i,1)= DD(i,1)+DDD(i,1);
    EE(i,1)= EE(i,1)+EEE(i,1);
     FF(i,1)= FF(i,1)+FFF(i,1);
%  view(3);patch(DD,EE,FF,'g');
   hold on
   
   %FOR LINE Z3 & Z1 
 elseif (min(Z3,Z1) <= Z_GIVEN)  && (max(Z3,Z1)>=Z_GIVEN)
     equ7=(p7-X3)/(X1-X3) == (p8-Y3)/(Y1-Y3);
    equ8= p9 == Z_GIVEN;
    equ9=(p9-Z3)/(Z1-Z3)==(p7-X3)/(X1-X3);
    soln=solve([equ7,equ8,equ9],[p7,p8,p9]);
   plot3(soln.p7,soln.p8,soln.p9,'*r');
   hold on
   
  GGG(i,1)=soln.p7;
   HHH(i,1)=soln.p8;
   III(i,1)=soln.p9;

  GG(i,1)=GG(i,1)+GGG(i,1);
    HH(i,1)=HH(i,1)+HHH(i,1);
     II(i,1)=II(i,1)+III(i,1);
%    view(3);patch(GG,HH,II,'g');
   hold on
   
else
     i;
     NONCUT = ['NTH PLANE IS NOT INTERSECTING WHERE N IS ',num2str(i)];
     disp(NONCUT);
 end
 
end
rotate3d on
xlabel('x');ylabel('y');zlabel('z');

title({'Slicing 3D file into 2D slices';'ME_ 17_ AMTECH_ 11008_ PRASHANT KOCHAR'})
