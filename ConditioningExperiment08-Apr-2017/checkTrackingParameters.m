function checkTrackingParameters(img,background,threshold)

   if nargin > 3
       error('Must enter image, background image, and threshold value (recomend 0.2)')
   end
   
   [height , width , frames] = size(img);
   
   for i = 1:frames
       imshow(im2bw(imabsdiff(background,img(:,:,i)),threshold));
       drawnow
   end
   
   
end