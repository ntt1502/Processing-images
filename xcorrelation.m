close all;
I = imread('or.jpg');
J = imread('frame.jpg');
K = imread('2a.jpg');


correlOr = normxcorr2(J,I);
[sizeX, sizeY] = size(correlOr);
[sizeXs, sizeYs] = size(J);

for i = 1:sizeX
    for j=1:sizeY
        if correlOr(i,j) < 0
            correlOr(i,j) = 0;
        end
    end
end
imwrite(correlOr,'bigdot.jpg');

h = fspecial('log',18);
correlOr1 = imfilter(correlOr,h);
correlOr1 = im2bw(correlOr1,0.25);
% [idx C] = kmeans(correlOr,512);
figure;imshow(correlOr);
figure;imshow(correlOr1);
imwrite(correlOr1,'dot.jpg');

% [M,N]=size(correlOr1);
% [X,Y]=ndgrid(1:M,1:N);
 
% n = max(max(correlOr1));
% for k=1:n
 
%   idx=correlOr1==k;
% 
%  cx(k)=mean(X(idx)); %The k-th centroid X coord
%  cy(k)=mean(Y(idx)); %The k-th centroid Y coord
% 
% end
% 
% pks = imregionalmax(correlOr,26);
% 
% CC = bwconncomp(pks);
% for i = 1:CC.NumObjects,
%   index = CC.PixelIdxList{i};
%   if (numel(index) > 1),
%     pks(index) = false;
%   end
% end
% 
% figure;imshow(pks);

[L,num] = bwlabel(correlOr1);
A = zeros(sizeX,sizeY);

% for k = 1:num
%     for i = 1:sizeX
%         for j = 1:sizeY
%            if correlOr1(i,j) == k
%                A(i,j,k) = 1;
%            end
%         end
%     end
% end
% 
% avg_Gx = zeros(1,num);
% avg_Gy = zeros(1,num);
% for k = 1:num
%     G_x = 0;
%     G_y = 0;
%     counter = 0;
%     for i = 1:sizeX
%         for j = 1:sizeY
%             if A(i,j,k) == 1;
%             G_x = G_x + i;
%             G_y = G_y + j;
%             counter = counter + 1;
%             end
%         end
%     end
%     avg_Gx(k) = uint16(G_x/counter);
%     avg_Gy(k) = uint16(G_y/counter);    
% end
Coor = [];
for k = 1:num
    G_x = 0;
    G_y = 0;
    counter = 0;
    for i = 1:sizeX
        for j = 1:sizeY
           if L(i,j) == k
               G_x = G_x + i;
               G_y = G_y + j;
               counter = counter + 1;
               l = uint16(G_x/counter);
               m = uint16(G_y/counter);
           end
        end
    end
    Coor = [Coor; [l,m]];
    A(l,m) = 1;
end
figure;
imshow(A);
imwrite(A,'center.jpg')
Coor = sortrows(Coor,1);

lengthCoor = length(Coor);
for i=1:lengthCoor
    if K(Coor(i,1)-sizeXs/2,Coor(i,2)-sizeYs/2,3) > 127
        Coor(i,3) = 3;
    elseif K(Coor(i,1)-sizeXs/2,Coor(i,2)-sizeYs/2,1) > 127 && K(Coor(i,1)-sizeXs/2,Coor(i,2)-sizeYs/2,2) > 127
        Coor(i,3) = 4;
    elseif K(Coor(i,1)-sizeXs/2,Coor(i,2)-sizeYs/2,1) > 127
        Coor(i,3) = 1;
    else Coor(i,3) = 2;
    end
end
        
%     K(Coor(i,1)-sizeXs/2,Coor(i,2)-sizeYs/2,:)=0;
% end

figure;
imshow(K);
imwrite(K,'center_dot.jpg');


