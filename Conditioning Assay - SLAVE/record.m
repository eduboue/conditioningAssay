imgFile = fopen('~/Desktop/conditioned.erikVid','a+');


vid = videoinput('macvideo', 2, 'MONO8_640x480');
src = getselectedsource(vid);
vid.FramesPerTrigger = Inf;
start(vid);
itr = 1;
while(itr<=100)
    data = getdata(vid,2); 
    data = data(:,:,1);
    fwrite(imgFile,data(:));
    itr = itr+1;
end
stoppreview(vid);
delete(vid)
fclose(imgFile);