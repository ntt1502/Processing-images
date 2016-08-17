close all;
[sizeX, sizeY] = size(correlOr);
[sizeXs, sizeYs] = size(J);
sizeXs = sizeXs*3/4;
emptyImg = zeros(sizeX, sizeY,3);

for i=1:lengthCoor
    temp = Coor(i,:);
    row_coor = temp(1); 
    column_coor = temp(2);
    color = temp(3);
    if color == 3;      
        emptyImg(row_coor-sizeXs/2:row_coor+sizeXs/2,column_coor-sizeXs/2:column_coor+sizeXs/2,3) = 1; 
    elseif color == 2; 
        emptyImg(row_coor-sizeXs/2:row_coor+sizeXs/2,column_coor-sizeXs/2:column_coor+sizeXs/2,2) = 1; 
    elseif color == 1;
        emptyImg(row_coor-sizeXs/2:row_coor+sizeXs/2,column_coor-sizeXs/2:column_coor+sizeXs/2,1) = 1; 
    elseif color == 4;
        emptyImg(row_coor-sizeXs/2:row_coor+sizeXs/2,column_coor-sizeXs/2:column_coor+sizeXs/2,1) = 1; 
        emptyImg(row_coor-sizeXs/2:row_coor+sizeXs/2,column_coor-sizeXs/2:column_coor+sizeXs/2,2) = 1; 
    end
end

imshow(emptyImg);
imwrite(emptyImg,'emptyImg.jpg');

Coor1 = [Coor zeros(lengthCoor, 5)];
coor_ea = zeros(5,2);
for i=1:lengthCoor
    temp = Coor(i,:);
    row_coor = temp(1); 
    column_coor = temp(2);
    color = temp(3);
    coor_ea(1,:) = [row_coor - 1.5*sizeXs, column_coor];
    coor_ea(2,:) = [row_coor, column_coor];
    coor_ea(3,:) = [row_coor + 1.5*sizeXs, column_coor];
    coor_ea(4,:) = [row_coor, column_coor - 1.5*sizeXs];
    coor_ea(5,:) = [row_coor, column_coor + 1.5*sizeXs];
    
    for j = 1:5
        if isequal(squeeze(emptyImg(coor_ea(j,1),coor_ea(j,2),:)),[0; 0; 1])
            Coor1(i,j+3) = 3;
        elseif isequal(squeeze(emptyImg(coor_ea(j,1),coor_ea(j,2),:)),[1; 0; 0])
            Coor1(i,j+3) = 1;
        elseif isequal(squeeze(emptyImg(coor_ea(j,1),coor_ea(j,2),:)),[0; 1; 0])
            Coor1(i,j+3) = 2;
        elseif isequal(squeeze(emptyImg(coor_ea(j,1),coor_ea(j,2),:)),[1; 1; 0])
            Coor1(i,j+3) = 4;
        else Coor1(i,j+3) = 0;
        end
    end
end

Coor1 = double([Coor1 zeros(lengthCoor, 2)]);
for i = 1:lengthCoor
    [x,y] = xy_position(Coor1(i,4),Coor1(i,5),Coor1(i,6),Coor1(i,7),Coor1(i,8));
    Coor1(i,9) = x;
    Coor1(i,10) = y;
end


