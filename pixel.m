function p = pixel(image, pimage, block)

large = double(imread(image));
imshow(uint8(round(large)));

s = block-1;

[XL YL ZL] = size(large);

trim_row = XL - (uint16(floor(XL / block)) * block);
trim_col = YL - (uint16(floor(YL / block)) * block);

if (trim_row ~= 0)
    top = trim_row / 2;
    bottom = trim_row - top;
    large((XL-bottom+1):XL,:,:) = [];
    large(1:top,:,:) = [];
end

if (trim_col ~= 0)
    left = trim_col / 2;
    right = trim_col - left;
    large(:,(YL-right+1):YL,:) = [];
    large(:,1:left,:) = [];
end

[XL YL ZL] = size(large);

for i = 1:block:XL
    for j = 1:block:YL
        temp = large(i:i+s,j:j+s,:);
        ravg = sum(sum(temp(:,:,1))) / (block^2);
        gavg = sum(sum(temp(:,:,2))) / (block^2);
        bavg = sum(sum(temp(:,:,3))) / (block^2);
        temp(:,:,1) = ravg;
        temp(:,:,2) = gavg;
        temp(:,:,3) = bavg;
        large(i:i+s,j:j+s,:) = temp;
    end
end

figure
imshow(uint8(round(large)));
imwrite(uint8(round(large)), pimage);
