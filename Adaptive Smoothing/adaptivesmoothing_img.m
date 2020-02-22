imageObj = imread("dirty_image.jpg");

tempImageObj = imageObj;
alphaRatio = 0.1;
gammaRatio = 4;
[m,n] = size(tempImageObj);tempImageObj
S = zeros(m, n);
SF = zeros(m, n);
beta = zeros(m, n);
for count = 1:5
    for i = 1:m
        for j=1:n
            for k = i-1:i+1 % window size 3x3
                for l = j-1:j+1
                    if k>0 && l>0 && k<=m && l<=n
                        S(i,j)= S(i,j)+ 1/(1 + ( sqrt(double((k-i)^2 + (l-j)^2 + (tempImageObj(i,j)-tempImageObj(k,l))^2 )))^gammaRatio);
                    end                        
                end
            end
            
            beta(i, j) = alphaRatio/(S(i,j)-1);
            for k = i-1:i+1
                for l = j-1:j+1
                    if k>0 && l>0 && k<=m && l<=n
                        SF(i,j)= SF(i,j)+ (tempImageObj(k,l)/(1 + ( sqrt(double((k-i)^2 + (l-j)^2 + (tempImageObj(i,j)-tempImageObj(k,l))^2 )))^gammaRatio));
                    end                        
                end
            end
            SF(i,j) = SF(i,j)-tempImageObj(i,j);
            tempImageObj(i,j) = (1-alphaRatio)*tempImageObj(i,j) + beta(i,j)*SF(i,j);
        end
    end    
end
figure(1);
imshow(imageObj);
figure(2);
imshow(tempImageObj);
%Comparison with other filters
%figure(3);
%imshow(wiener2(imageObj));