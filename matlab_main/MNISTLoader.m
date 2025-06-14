classdef MNISTLoader
    methods(Static)
        function images = loadImages(filename)
            fid = fopen(filename, 'rb');
            if fid == -1
                error(['Could not open file: ', filename]);
            end
            magicNumber = fread(fid, 1, 'int32', 0, 'ieee-be');
            if magicNumber ~= 2051
                error('Invalid image file');
            end
            numImages = fread(fid, 1, 'int32', 0, 'ieee-be');
            numRows   = fread(fid, 1, 'int32', 0, 'ieee-be');
            numCols   = fread(fid, 1, 'int32', 0, 'ieee-be');
            images = fread(fid, inf, 'unsigned char');
            fclose(fid);
            images = reshape(images, numCols, numRows, numImages);
            images = permute(images, [2 1 3]); % rows x columns x images
            images = double(images) / 255; % normalize
        end
        function labels = loadLabels(filename)
            fid = fopen(filename, 'rb');
            if fid == -1
                error(['Could not open file: ', filename]);
            end
            magicNumber = fread(fid, 1, 'int32', 0, 'ieee-be');
            if magicNumber ~= 2049
                error('Invalid label file');
            end
            numLabels = fread(fid, 1, 'int32', 0, 'ieee-be');
            labels = fread(fid, inf, 'unsigned char');
            fclose(fid);
        end
    end
end