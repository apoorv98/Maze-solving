%% Code for route creation
close all;
clear all;
clc;
% Read image and convert to gray scale
p=imread('maze1.bmp');
r=p(:,:,1);
g=p(:,:,2);
b=p(:,:,3);
c=(r/3)+(b/3)+(g/3);
subplot(1,4,1);
imshow(c);
title('Grayscale');%% Image Processing to find path

% Blurring
h=fspecial('gaussian',3,5);
g=imfilter(c,h,'replicate');
subplot(1,4,2);
imshow(g);
title('Blurred Image');

% Thresholding
m= im2bw(g,graythresh(g));
subplot(1,4,3);
imshow(m);
title('Thresholded Image');


% Skeletalization
s=bwmorph(m,'skel',inf);
subplot(1,4,4);
imshow(s);
title('Skeletonization');


% Pruning
s1=bwmorph(s,'spur',100);
s1=bwmorph(s1,'clean');
figure;
imshow(s1);
title('Image after Pruning');


% Display
b = imoverlay( p, s1, [1 0 0]);
figure;
imshow(b);
title('Image with path');

%% Finding coordinates to send to bot
% close all;
a = padarray(s1,[2 2]);
[r,c] = find(a);

n = min(r);

for i=1:length(r)
    if r(i) == n
       break;
    end
end

x = r(i);
y = c(i);

if length(r)>length(c)
    rc = length(r);
else
    rc = length(c);
end

x1 = zeros(0,rc);
y1 = zeros(0,rc);
f = zeros(0,rc);

x1(1) = x;
y1(1) = y;

k = 0;
o = 1;

for i = 2:rc
    
switch (o)
    case 1  % down
    if    a(x+1,y) == 1 %straight
          x1(i) = x+1;
          y1(i) = y;
          a(x+1,y) = 0;
          x = x+1;
          o=1;
          k = k + 1;
          f(k) = 1;
    else if a(x+1,y+1) == 1 %s-left
            x1(i) = x+1;
            y1(i) = y+1;
            a(x+1,y+1) = 0 ;
            x = x+1;
            y = y+1;
            o=2;
            k = k + 1;
            f(k) = 2;
    else if a(x+1,y-1) == 1 %s-right
             x1(i) = x+1;
             y1(i) = y-1;
             a(x+1,y-1) = 0;
             x = x+1;
             y = y-1;
             o=3;
             k = k + 1;
             f(k) = 3;
        else if a(x,y+1) ==  1  %left
                x1(i) = x;
                y1(i) = y+1;a(x,y+1) =  0;
                y = y+1;
                o=4;   
                
        else if a(x,y-1) ==  1  %right
                x1(i) = x;
                y1(i) = y-1;a(x,y-1) =  0;
                y = y-1;
                o=5;
                k = k + 1;
                f(k) = 5;
            end
            end
        end
        end
    end
                
                case 2 % s-left
    if    a(x+1,y+1) == 1 %straight
          x1(i) = x+1;
          y1(i) = y+1;a(x+1,y+1) =  0;
          x = x+1;
          y = y+1;
          o=2;
          k = k + 1;
          f(k) = 1;
          
    else if a(x,y+1) == 1 %s-left
            x1(i) = x;
            y1(i) = y+1;a(x,y+1) = 0;
            y = y+1;
            o =4;
            k = k + 1;
            f(k) = 2;
    
    else if a(x+1,y) == 1 %s-right
             x1(i) = x+1;
             y1(i) = y;a(x+1,y) = 0;
             x = x+1;
             o=1;
             k = k + 1;
             f(k) = 3;
             
        else if a(x-1,y+1) ==  1  %left
                x1(i) = x-1;
                y1(i) = y+1;a(x-1,y+1) =  0;
                x = x-1;
                y = y+1;
                o=6;
                k = k + 1;
                f(k) = 4;
                
        else if a(x+1,y-1) ==  1  %right
                x1(i) = x+1;
                y1(i) = y-1;a(x+1,y-1) =  0;
                x = x+1;
                y = y-1;
                o=3;
                k = k + 1;
                f(k) = 5;
            end
            end
        end
        end
    end
                
    case 3 %s-right
   
    if    a(x+1,y-1) == 1 %straight
          x1(i) = x+1;
          y1(i) = y-1;a(x+1,y-1) = 0;
          x = x+1;
          y = y-1;
          o=3;
          k = k + 1;
          f(k) = 1;
          
    else if a(x+1,y) == 1 %s-left
            x1(i) = x+1;
            y1(i) = y;a(x+1,y) = 0;
            x = x+1;
            o =1;
            k = k + 1;
            f(k) = 2;
    
    else if a(x,y-1) == 1 %s-right
             x1(i) = x;
             y1(i) = y-1; a(x,y-1) = 0;
             y = y-1;
             o=5;
             k = k + 1;
             f(k) = 3;
             
        else if a(x+1,y+1) ==  1  %left
                x1(i) = x+1;
                y1(i) = y+1;a(x+1,y+1) =0;
                x = x+1;
                y = y+1;
                o=4; 
                k = k + 1;
                f(k) = 4;
                
        else if a(x-1,y-1) ==  1  %right
                x1(i) = x-1;
                y1(i) = y-1;a(x-1,y-1) =0;
                x = x-1;
                y = y-1;
                o=7;
                k = k + 1;
                f(k) = 5;
            end
            end
        end
        end
    end
    
    case 4
    %left
    if    a(x,y+1) == 1 %straight
          x1(i) = x;
          y1(i) = y+1;a(x,y+1) =0;
          y = y+1;
          o=4;
          k = k + 1;
          f(k) = 1;
          
    else if a(x-1,y+1) == 1 %s-left
            x1(i) = x-1;
            y1(i) = y+1;a(x-1,y+1) =0;
            x = x-1;
            y = y+1;
            o =6;
            k = k + 1;
            f(k) = 2;
    
    else if a(x+1,y+1) == 1 %s-right
             x1(i) = x+1;
             y1(i) = y+1;a(x+1,y+1) =0;
             x = x+1;
             y = y+1;
             o=2;
             k = k + 1;
             f(k) = 3;
          
        else if a(x-1,y) ==  1  %left
                x1(i) = x-1;
                y1(i) = y;a(x-1,y) =0;
                x = x-1;
                o=8; 
                k = k + 1;
                f(k) = 4;
                
        else if a(x+1,y) ==  1  %right
                x1(i) = x+1;
                y1(i) = y;a(x+1,y) =0;
                x = x+1;
                o=1;
                k = k + 1;
                f(k) = 5;
            end
            end
        end
        end
    end
    
    case 5 % right
    if    a(x,y-1) == 1 %straight
          x1(i) = x;
          y1(i) = y-1;a(x,y-1) =0;
          y = y-1;
          o=5;
          k = k + 1;
          f(k) = 1;
          
    else if a(x+1,y-1) == 1 %s-left
            x1(i) = x+1;
            y1(i) = y-1;a(x+1,y-1) =0;
            x = x+1;
            y = y-1;
            o =3;
            k = k + 1;
            f(k) = 2;
    
    else if a(x-1,y-1) == 1 %s-right
             x1(i) = x-1;
             y1(i) = y-1;a(x-1,y-1) =0;
             x = x-1;
             y = y-1;
             o=7;
             k = k + 1;
             f(k) = 3;
             
        else if a(x+1,y) ==  1  %left
                x1(i) = x+1;
                y1(i) = y;a(x+1,y) =0;
                x = x+1;
                o=1;   
                k = k + 1;
                f(k) = 4;
        else if a(x-1,y) ==  1  %right
                x1(i) = x-1;
                y1(i) = y;a(x-1,y) =0;
                x = x-1;
                o=8;
                k = k + 1;
                f(k) = 5;
            end
            end
        end
        end
    end
    
    
    case 6
        if    a(x-1,y+1) == 1 %straight
          x1(i) = x-1;
          y1(i) = y+1;a(x-1,y+1) =0;
          x = x-1;
          y = y+1;
          o=6;
          k = k + 1;
          f(k) = 1;
    else if a(x-1,y) == 1 %s-left
            x1(i) = x-1;
            y1(i) = y;a(x-1,y) =0;
            x = x-1;
            o =8;
            k = k + 1;
            f(k) = 2;
    
    else if a(x,y+1) == 1 %s-right
             x1(i) = x;
             y1(i) = y+1;a(x,y+1) =0;
             y = y+1;
             o=4;
             k = k + 1;
             f(k) = 3;
          
        else if a(x-1,y-1) ==  1  %left
                x1(i) = x-1;
                y1(i) = y-1;a(x-1,y-1) =0;
                x = x-1;
                y = y-1;
                o=7;   
                k = k + 1;
                f(k) = 4;
          
        else if a(x+1,y+1) ==  1  %right
                x1(i) = x+1;
                y1(i) = y+1;a(x+1,y+1) =0;
                x = x+1;
                y = y+1;
                o=2;
                k = k + 1;
                f(k) = 5;
            end
            end
        end
        end
        end
    
    case 7
        if    a(x-1,y-1) == 1 %straight
          x1(i) = x-1;
          y1(i) = y-1;a(x-1,y-1) =0;
          x = x-1;
          y = y-1;
          o=7;
          k = k + 1;
          f(k) = 1;
    else if a(x,y-1) == 1 %s-left
            x1(i) = x;
            y1(i) = y-1;a(x,y-1) =0;
            y = y-1;
            o =5;
            k = k + 1;
            f(k) = 2;
    
    else if a(x-1,y) == 1 %s-right
             x1(i) = x-1;
             y1(i) = y;a(x-1,y) =0;
             x = x-1;
             o=8;
             k = k + 1;
             f(k) = 3;
             
        else if a(x+1,y-1) ==  1  %left
                x1(i) = x+1;
                y1(i) = y-1;a(x+1,y-1) =0;
                x = x+1;
                y = y-1;
                o=3;   
                k = k + 1;
                f(k) = 4;
          
        else if a(x-1,y+1) ==  1  %right
                x1(i) = x-1;
                y1(i) = y+1;a(x-1,y+1) =0;
                x = x-1;
                y = y+1;
                o=6;
                k = k + 1;
                f(k) = 5;
            end
            end
        end
        end
        end
    
    case 8
        if    a(x-1,y) == 1 %straight
          x1(i) = x-1;
          y1(i) = y;a(x-1,y) =0;
          x = x-1;
          o=8;
          k = k + 1;
          f(k) = 1;
          
    else if a(x-1,y-1) == 1 %s-left
            x1(i) = x-1;
            y1(i) = y-1;a(x-1,y-1) =0;
            x = x-1;
            y = y-1;
            o =7;
            k = k + 1;
            f(k) = 2;
    
    else if a(x-1,y+1) == 1 %s-right
             x1(i) = x-1;
             y1(i) = y+1;a(x-1,y+1) =0;
             x = x-1;
             y = y+1;
             o=6;
             k = k + 1;
             f(k) = 3;
        else if a(x,y-1) ==  1  %left
                x1(i) = x;
                y1(i) = y-1;a(x,y-1) =0;
                y = y-1;
                o=5;   
                k = k + 1;
                f(k) = 4;
          
        else if a(x,y+1) ==  1  %right
                x1(i) = x;
                y1(i) = y+1;a(x,y+1) =0;
                y = y+1;
                o=4;
                k = k + 1;
                f(k) = 5;
             end
            end
          end
        end
        end
end
if mod(i,2)==0
    imshow(a);
end
end
% close all;
 

x2 = x1';
y2 = y1';
figure;
plot(y2,-x2);

%%  Matlab to Arduino

filename = 'testdata.xlsx';
% A = [12.7, 5.02, -98, 63.9, 0, -.2, 56];
xlswrite(filename,f);

% #include<swarm.h>
 a = arduino('COM3');
lm1 = 5;
lm2 = 4;
rm1 = 7;
rm2 = 6;

% Motor speed(100);

%    put your setup code here, to run once:
  a.pinMode(lm1,'OUTPUT');
  a.pinMode(lm2,'OUTPUT');
  a.pinMode(rm1,'OUTPUT');
  a.pinMode(rm2,'OUTPUT');
  a.pinMode(13,'OUTPUT');
  a.digitalWrite(13,1);
  
%   speed.set();
  
%    put your main code here, to run repeatedly:
%   f = [1 2 3 4 5];
  for i=1:length(f)
    if (f(i) == 1)
%    Forward
  a.digitalWrite(lm1,1);
  a.digitalWrite(lm2,0);
  a.digitalWrite(rm1,1);
  a.digitalWrite(rm2,0);
%   delay(250);
   pause(0.5);
    else if (f(i) == 2) 
%    Soft Left
  a.digitalWrite(lm1,1);
  a.digitalWrite(lm2,1);
  a.digitalWrite(rm1,1);
  a.digitalWrite(rm2,0);
%   delay(250);
  pause(0.5);
  
  else if (f(i) == 3) 
%    Soft Right
  a.digitalWrite(lm1,1);
  a.digitalWrite(lm2,0);
  a.digitalWrite(rm1,1);
  a.digitalWrite(rm2,1);
%   delay(250);
  pause(0.5);
 
  else if (f(i) == 4)
%    Left
  a.digitalWrite(lm1,0);
  a.digitalWrite(lm2,1);
  a.digitalWrite(rm1,1);
  a.digitalWrite(rm2,0);
%   delay(250);
 pause(0.5);
      
  
  else if (f(i) == 5) 
%    Right
  a.digitalWrite(lm1,1);
  a.digitalWrite(lm2,0);
  a.digitalWrite(rm1,0);
  a.digitalWrite(rm2,1);
 pause(0.5);
% delay(250);
      end
      end
      end
        end
     end
  end
% Stop
  a.digitalWrite(lm1,0);
  a.digitalWrite(lm2,0);
  a.digitalWrite(rm1,0);
  a.digitalWrite(rm2,0);