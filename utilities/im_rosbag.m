% IMPORT ROSBAG FILES 
addpath('utilities\')

bagfile_path = "bagfiles_vigneto\vigneto2.bag";
bagfile = rosbag(bagfile_path);
bagInfo = rosbag('info',bagfile_path);

% CAMERA
bagPoint = select (bagfile, 'Topic' , '/camera/depth/color/points');
pcloud = readMessages(bagPoint,'DataFormat','struct');
save("pointData.mat","pcloud");
% 
% bagDepth = select (bagfile, 'Topic' , '/camera/depth/image_rect_raw');
% imDepth = readMessages(bagDepth,'DataFormat','struct');

% LIDAR
bagScan = select(bagfile, 'Topic','/scan');
scanStructs = readMessages(bagScan,'DataFormat','struct');
save("scanData.mat","scanStructs");
% 