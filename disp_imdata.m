function disp_imdata(X, imsize, titles, layout, range, fps)
% disp_imdata(X, imsize, titles, layout, range)
% Displays images in a data matrix one by one.
% INPUTS
%       X        2D/3D data matrix containing vectorized images as columns
%       imsize   the image size
%       titles   subtitles for each image in the same figure (optional)
%       layout   number of rows and columns for the subplot grid (optional)
%       range    display range of pixel intensities (optional)
%       fps      if specified, images are displayed at this rate (optional)
% OUTPUTS
%       none
%
% George Papamakarios
% Imperial College London
% Apr 2014

n2 = size(X, 2);
n3 = size(X, 3);
fig = figure;
i = 1;
if nargin < 6, fps = []; end;
if nargin < 5, range = []; end;
if nargin < 4, layout = [1, n3]; end;
if nargin < 3, titles = cell(1, n3); end;
if prod(layout) ~= n3, error('Layout dimension does not match number of images'); end

while true
    
    % display next
    for j = 1:n3
        im = reshape(X(:,i,j), imsize);
        subplot(layout(1), layout(2), j);
        imshow(im, range);
        axis image;
        title(titles{j});
    end
    suptitle(sprintf('Image %d', i));
    drawnow;
    
    if isempty(fps)
    
        % pause and wait for key press
        waitforbuttonpress;
        key = double(get(fig, 'CurrentCharacter'));
        switch key
            % left/up arrow
            case {28, 30}
                i = i - 1;
                if i < 1, i = n2; end
            % right/down arrow
            case {29, 31}     
                i = i + 1;
                if i > n2, i = 1; end
            % escape
            case 27          
                break;
            % spacebar
            case 32
                idx = input('Image index: ');
                if 1 <= idx && idx <= n2, i = idx; end
        end
        
    else
        
        pause(1/fps);
        i = i + 1;
        if i > n2
            waitforbuttonpress;
            key = double(get(fig, 'CurrentCharacter'));
            switch key
                % escape
                case 27          
                    break;
                % spacebar
                case 32
                    i = 1;
                % any other key
                otherwise
                    i = i - 1;
            end
        end
        
    end
end

close(fig);
