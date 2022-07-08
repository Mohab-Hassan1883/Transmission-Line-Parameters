clear;
clc;
prompt = {'conductor resistivity(Ohm):','conductor length(km):','conductor diameter(cm):'};
data = inputdlg(prompt,'Enter asked parameters',[1 90]);
resistivity=str2num(data{1});
l=str2num(data{2});
l=l*1000;
D=str2num(data{3});
r=D/2;
r=r/100;
gmr=0.7788*r;
A=pi*(r^2);
Rdc=(resistivity*l)/A;
R=1.1*Rdc;
str={'select system type','Single selection'};
s={'symmetrical','unsymmetrical'};
system=listdlg('PromptString',str,'ListString',s,'SelectionMode','single');

if system==1
   prompt = {'Distance(m):'};
   data = inputdlg(prompt,'Enter the distance btween every two phases',[1 90]); 
   Deq=str2num(data{1});
   
   Lph=2*(10^-7)*log(Deq/gmr);
   L=Lph*l;
   Cph=(2*pi*8.85*(10^-12))/log(Deq/r);
   C=Cph*l;
else
    prompt = {'Distance(m){enter them in the form of matrix [x1 x2 ..]}:'};
   data = inputdlg(prompt,'Enter the distances btween every two phases',[1 90]); 
   eq=str2num(data{1});
   Deq=eq(1)*eq(2);
   n=length(eq);
   for i=3:n
      Deq=Deq*eq(i);
   end
   Deq=nthroot(Deq,n);
   
   Lph=2*(10^-7)*log(Deq/gmr);
   L=Lph*l;
   Cph=(2*pi*8.85*(10^-12))/log(Deq/r);
   C=Cph*l;
   
    
    
    
end
msgbox(sprintf('Resistance per phase = %f\nInductance per phase = %f\nCapacitance per phase = %f',R,L,C));
