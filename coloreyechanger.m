img=imread('ojos5.jpg');
figure(); imshow(img);
%Imagen a LAB para separar color
imLAB=rgb2lab(img);
L=imLAB(:,:,1);
A=imLAB(:,:,2);
B=imLAB(:,:,3);

color=0;
%Seleccionar el color a separar  
if color==0
    prompt = 'Que tipo de rango quieres ';
    color = input(prompt);
end

switch color
    %muestra = figurascool.png
    case 1
        Lmin = 0 ; Lmax=100;
        Amin = -20 ; Amax=20;
        Bmin = 70 ; Bmax=100;
    %ojos.jpg
    case 2
        Lmin = 0 ; Lmax=100;
        Amin = 40 ; Amax=60;
        Bmin = -0.1 ; Bmax=0.1;
   %ojos2.jpg
    case 3
        Lmin = 0 ; Lmax=100;
        Amin = 40 ; Amax=60;
Bmin = -0.1 ; Bmax=0.1;
%ojos3.jpg
case 4
Lmin = 0 ; Lmax=100;
Amin = 40 ; Amax=60;
Bmin = -0.1 ; Bmax=0.1;
%ojos4.jpg
case 5
Lmin = 0 ; Lmax=100;
Amin = 40 ; Amax=60;
Bmin = -0.1 ; Bmax=0.1;
end

%Separacion de color con los rangos ya establecidos
mask=((L>=Lmin)&(L<=Lmax));
maskSV=((A>=Amin)&(A<=Amax))|((B>=Bmin)&(B<=Bmax))& mask;
maskSV2=((A>=Amin)&(A<=Amax))&((B>=Bmin)&(B<=Bmax))&mask;
maskSV=maskSV-maskSV2;
mask3CH=cat(3,maskSV,maskSV,maskSV);
colorfilt=img;
colorfilt(mask3CH==0)=0;
figure(); imshow(colorfilt,[]); title('Color requerido separado');
colorfilt_gray=rgb2gray(colorfilt); %convertir a niveles de gris
figure(); imshow(colorfilt_gray, []);
switch color
case 1
mask_final=(colorfilt_gray>200) & (colorfilt_gray<250); %aislar pixeles en un rango
case 2
mask_final=(colorfilt_gray>50) & (colorfilt_gray<90);
case 3
mask_final=(colorfilt_gray>0) ;
case 4
mask_final=(colorfilt_gray>40) & (colorfilt_gray<100);
case 5
mask_final=(colorfilt_gray>0) ;
end
mask_final=bwmorph(mask_final, 'Majority', 9); %eliminar pixeles aislados
mask_final=imdilate(mask_final, strel('sphere',2)); %dilatacion
figure(); imshow(mask_final, [])
mask_final_3d=repmat(mask_final, [1 1 3]); %crear mascara de 3 bandas
result=double(img).*(1-mask_final_3d); %multiplicar por el negativo de la mascara
figure(); imshow(uint8(result), [])
