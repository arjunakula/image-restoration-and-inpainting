img_dist = imread('distroted_image.bmp');
img_mask = imread('mask_image.bmp');
img_orig = imread('original_image.bmp');

r_img = double(img_dist(:,:,1))*(31/255);
b_img = double(img_dist(:,:,2))*(31/255);
g_img = double(img_dist(:,:,3))*(31/255);

r_img_orig = double(img_orig(:,:,1))*(31/255);
b_img_orig = double(img_orig(:,:,2))*(31/255);
g_img_orig = double(img_orig(:,:,3))*(31/255);

% r_img = double(img_dist(:,:,1));
% b_img = double(img_dist(:,:,2));
% g_img = double(img_dist(:,:,3));
%
% r_img_orig = double(img_orig(:,:,1));
% b_img_orig = double(img_orig(:,:,2));
% g_img_orig = double(img_orig(:,:,3));


% method 1: Gibbs
acc = [];
sweep_error = [];

sweep_vals = 1:100;
min_error = 10000000;


for swp = 1:length(sweep_vals)
    for x_i = 1:size(img_mask,1)-2
        for y_i  = 1:size(img_mask,2)-2
            
            if(img_mask(x_i,y_i) == 0)
                continue;
            end
            
            
            %                 pdf_val = zeros(1,32);
            %                 cdf_val = zeros(1,32);
            %
            %                 for i = 1:32
            %                     pdf_val(i) = exp( double((-beta_val)* ((r_img((x_i)+1,(y_i)) - i) ^2 + (r_img((x_i),(y_i)+1) - i)^2) ));
            %                 end
            %
            %                 pdf_val = pdf_val/sum(pdf_val);
            %
            %                 r = rand();
            %
            %                 I_new = 31;
            %                 for i = 1:32
            %                     if(i==1)
            %                         cdf_val(i) =pdf_val(i);
            %                     else
            %                         cdf_val(i) = cdf_val(i-1)+pdf_val(i);
            %                     end
            %                     if((cdf_val(i) >= r))
            %                         I_new = i;
            %                         break;
            %                     end
            %                 end
            
            r_img(x_i,y_i) = (1/4)*(r_img(x_i-1,y_i) + (r_img(x_i+1,y_i)) + (r_img(x_i,y_i-1)) + r_img(x_i,y_i+1));
            
        end
    end
    
    
    
    %r_img_rescaled = double(r_img(:,:,1));
    
    error = 0;
    cnt = 0;
    for x_i = 1:size(img_mask,1)
        for y_i = 1:size(img_mask,2)
            % x_i,y_i
            if(img_mask(x_i,y_i) == 0)
                continue;
            end
            cnt = cnt+1;
            
            error = error+(r_img_orig(x_i,y_i) - r_img(x_i,y_i))^2;
            % (img_orig(x_i,y_i) - img_dist(x_i,y_i))^2
        end
    end
    
    error = (error*(1.0))/cnt;
    
    if(error < min_error)
        min_error = error;
        
    end
    acc(end+1) = error;
end

r_img_rescaled = double(r_img(:,:,1))*(255/31);


% method 1: Gibbs
sweep_vals = 1:100;


for swp = 1:length(sweep_vals)
    for x_i = 1:size(img_mask,1)-2
        for y_i = 1:size(img_mask,2)-2
            
            if(img_mask(x_i,y_i) == 0)
                continue;
            end
            
            %                 pdf_val = zeros(1,32);
            %                 cdf_val = zeros(1,32);
            %
            %                 for i = 1:32
            %                     pdf_val(i) = exp( double((-beta_val)* ((b_img((x_i)+1,(y_i)) - i) ^2 + (b_img((x_i),(y_i)+1) - i)^2) ));
            %                 end
            %
            %                 pdf_val = pdf_val/sum(pdf_val);
            %
            %                 r = rand();
            %
            %                 I_new = 31;
            %                 for i = 1:32
            %                     if(i==1)
            %                         cdf_val(i) =pdf_val(i);
            %                     else
            %                         cdf_val(i) = cdf_val(i-1)+pdf_val(i);
            %                     end
            %                     if((cdf_val(i) >= r))
            %                         I_new = i;
            %                         break;
            %                     end
            %                 end
            
            b_img(x_i,y_i) = (1/4)*(b_img(x_i-1,y_i) + (b_img(x_i+1,y_i)) + (b_img(x_i,y_i-1)) + b_img(x_i,y_i+1));
            
        end
    end
end


b_img_rescaled = double(b_img(:,:,1))*(255/31);
%b_img_rescaled = double(b_img(:,:,1));


% method 1: Gibbs
sweep_vals = 1:100;


for swp = 1:length(sweep_vals)
    for x_i = 1:size(img_mask,1)
        for y_i = 1:size(img_mask,2)
            
            if(img_mask(x_i,y_i) == 0)
                continue;
            end
            %
            %                 pdf_val = zeros(1,32);
            %                 cdf_val = zeros(1,32);
            %
            %                 for i = 1:32
            %                     pdf_val(i) = exp( double((-beta_val)* ((g_img((x_i)+1,(y_i)) - i) ^2 + (g_img((x_i),(y_i)+1) - i)^2) ));
            %                 end
            %
            %                 pdf_val = pdf_val/sum(pdf_val);
            %
            %                 r = rand();
            %
            %                 I_new = 31;
            %                 for i = 1:32
            %                     if(i==1)
            %                         cdf_val(i) =pdf_val(i);
            %                     else
            %                         cdf_val(i) = cdf_val(i-1)+pdf_val(i);
            %                     end
            %                     if((cdf_val(i) >= r))
            %                         I_new = i;
            %                         break;
            %                     end
            %                 end
            
            g_img(x_i,y_i) = (1/4)*(g_img(x_i-1,y_i) + (g_img(x_i+1,y_i)) + (g_img(x_i,y_i-1)) + g_img(x_i,y_i+1));
            
        end
    end
end

g_img_rescaled = double(g_img(:,:,1))*(255/31);
%g_img_rescaled = double(g_img(:,:,1));

r_img_1 = double(img_dist(:,:,1));
b_img_1 = double(img_dist(:,:,2));
g_img_1 = double(img_dist(:,:,3));

img_dist_2 =  uint8(cat(3,r_img_rescaled,b_img_rescaled,g_img_rescaled));

%plot(beta_vals,acc)

% method 2: PDE
