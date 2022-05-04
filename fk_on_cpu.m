%% 3R data on Type 2
clear all;
clc;


data_from_csv = readmatrix('dataset_fk_3R.csv');
theta_from_csv = readmatrix('dataset_thetas_3R.csv');

% Extracting data from FK
x = data_from_csv(:,1);
y = data_from_csv(:,2);
z = data_from_csv(:,3);
roll = data_from_csv(:,4);
pitch = data_from_csv(:,5);
yaw = data_from_csv(:,6);

 
% data = [x y z roll pitch yaw theta_1' theta_2' theta_3' theta_4' theta_5' theta_6' theta_7'];
data = [x y z roll pitch yaw theta_from_csv];
data_ = data(randperm(size(data, 1)),: );

disp('Data has been shuffled');
% Separating data into train and test
train_partition_1 = data_(1:round( size(data_,1)*5/7),1:7);
test_partition_1 = data_(round(size(data_,1)*6/7)+1:size(data_,1),1:7);

train_partition_2 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,8]);
test_partition_2 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,8]);

train_partition_3 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,9]);
test_partition_3 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,9]);

train_partition_4 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,10]);
test_partition_4 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,10]);

train_partition_5 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,11]);
test_partition_5 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,11]);

train_partition_6 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,12]);
test_partition_6 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,12]);

train_partition_7 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,13]);
test_partition_7 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,13]);
disp('Data separation done');

% NN1 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net1= fitnet(hiddenSizes, trainingFunction);
net1.layers{1}.transferFcn = 'radbas';
net1.trainParam.epochs = 500;
net1.numlayers = 2;
net1.layerConnect = [0 0;1 0];
net1.outputConnect = [0 1];
net1_model = train(net1,train_partition_1(:,1:6)',train_partition_1(:,7)' );
predicted_Theta_1=sim(net1_model, test_partition_1(:,1:6)');
perf_1 = perform(net1_model, predicted_Theta_1 , test_partition_1(:,7)');
disp(perf_1);

thetaDifference_1 = test_partition_1(:,7)' - predicted_Theta_1;

% NN2 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net2= fitnet(hiddenSizes, trainingFunction);
net2.layers{1}.transferFcn = 'radbas';
net2.trainParam.epochs = 500;
net2.numlayers = 2;
net2.layerConnect = [0 0;1 0];
net2.outputConnect = [0 1];
net2_model = train(net1,train_partition_2(:,1:6)',train_partition_2(:,7)');
predicted_Theta_2=sim(net2_model, test_partition_2(:,1:6)');
perf_2 = perform(net2_model, predicted_Theta_2 , test_partition_2(:,7)');
disp(perf_2);

thetaDifference_2 = test_partition_2(:,7)' - predicted_Theta_2;

% NN3 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net3= fitnet(hiddenSizes, trainingFunction);
net3.layers{1}.transferFcn = 'radbas';
net3.trainParam.epochs = 500;
net3.numlayers = 2;
net3.layerConnect = [0 0;1 0];
net3.outputConnect = [0 1];
net3_model = train(net3,train_partition_3(:,1:6)',train_partition_3(:,7)');
predicted_Theta_3=sim(net3_model, test_partition_3(:,1:6)');
perf_3 = perform(net3_model, predicted_Theta_3 , test_partition_3(:,7)');
disp(perf_3);

thetaDifference_3 = test_partition_3(:,7)' - predicted_Theta_3;

% NN4 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net4= fitnet(hiddenSizes, trainingFunction);
net4.layers{1}.transferFcn = 'radbas';
net4.trainParam.epochs = 500;
net4.numlayers = 2;
net4.layerConnect = [0 0;1 0];
net4.outputConnect = [0 1];
net4_model = train(net4,train_partition_4(:,1:6)',train_partition_4(:,7)');
predicted_Theta_4=sim(net4_model, test_partition_4(:,1:6)');
perf_4 = perform(net4_model, predicted_Theta_4 , test_partition_4(:,7)');
disp(perf_4);

thetaDifference_4 = test_partition_4(:,7)' - predicted_Theta_4;

% NN5 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net5= fitnet(hiddenSizes, trainingFunction);
net5.layers{1}.transferFcn = 'radbas';
net5.trainParam.epochs = 500;
net5.numlayers = 2;
net5.layerConnect = [0 0;1 0];
net5.outputConnect = [0 1];
net5_model = train(net5,train_partition_5(:,1:6)',train_partition_5(:,7)');
predicted_Theta_5=sim(net5_model, test_partition_5(:,1:6)');
perf_5 = perform(net5_model, predicted_Theta_5 , test_partition_5(:,7)');
disp(perf_5);

thetaDifference_5 = test_partition_5(:,7)' - predicted_Theta_5;

% NN6 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net6= fitnet(hiddenSizes, trainingFunction);
net6.layers{1}.transferFcn = 'radbas';
net6.trainParam.epochs = 500;
net6.numlayers = 2;
net6.layerConnect = [0 0;1 0];
net6.outputConnect = [0 1];
net6_model = train(net6,train_partition_6(:,1:6)',train_partition_6(:,7)');
predicted_Theta_6=sim(net6_model, test_partition_6(:,1:6)');
perf_6 = perform(net6_model, predicted_Theta_6 , test_partition_6(:,7)');
disp(perf_6);

thetaDifference_6 = test_partition_6(:,7)' - predicted_Theta_6;

% NN7 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net7= fitnet(hiddenSizes, trainingFunction);
net7.layers{1}.transferFcn = 'radbas';
net7.trainParam.epochs = 500;
net7.numlayers = 2;
net7.layerConnect = [0 0;1 0];
net7.outputConnect = [0 1];
net7_model = train(net7,train_partition_7(:,1:6)',train_partition_7(:,7)');
predicted_Theta_7=sim(net7_model, test_partition_7(:,1:6)');
perf_7 = perform(net7_model, predicted_Theta_7 , test_partition_7(:,7)');
disp(perf_7);

thetaDifference_7 = test_partition_7(:,7)' - predicted_Theta_7;

disp('3R on Type 1 is done');

%% 8R for Type 1
clear all; 

data_from_csv = readmatrix('dataset_fk_8R.csv');
theta_from_csv = readmatrix('dataset_thetas_8R.csv');


% Extracting data from FK
x = data_from_csv(:,1);
y = data_from_csv(:,2);
z = data_from_csv(:,3);
roll = data_from_csv(:,4);
pitch = data_from_csv(:,5);
yaw = data_from_csv(:,6);

 
% data = [x y z roll pitch yaw theta_1' theta_2' theta_3' theta_4' theta_5' theta_6' theta_7'];
data = [x y z roll pitch yaw theta_from_csv];
data_ = data(randperm(size(data, 1)),: );

disp('Data has been shuffled');
% Separating data into train and test
train_partition_1 = data_(1:round( size(data_,1)*5/7),1:7);
test_partition_1 = data_(round(size(data_,1)*6/7)+1:size(data_,1),1:7);

train_partition_2 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,8]);
test_partition_2 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,8]);

train_partition_3 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,9]);
test_partition_3 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,9]);

train_partition_4 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,10]);
test_partition_4 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,10]);

train_partition_5 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,11]);
test_partition_5 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,11]);

train_partition_6 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,12]);
test_partition_6 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,12]);

train_partition_7 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,13]);
test_partition_7 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,13]);
disp('Data separation done');

% NN1 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net1= fitnet(hiddenSizes, trainingFunction);
net1.layers{1}.transferFcn = 'radbas';
net1.trainParam.epochs = 500;
net1.numlayers = 2;
net1.layerConnect = [0 0;1 0];
net1.outputConnect = [0 1];
net1_model = train(net1,train_partition_1(:,1:6)',train_partition_1(:,7)' );
predicted_Theta_1=sim(net1_model, test_partition_1(:,1:6)');
perf_1 = perform(net1_model, predicted_Theta_1 , test_partition_1(:,7)');
disp(perf_1);

thetaDifference_1 = test_partition_1(:,7)' - predicted_Theta_1;

% NN2 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net2= fitnet(hiddenSizes, trainingFunction);
net2.layers{1}.transferFcn = 'radbas';
net2.trainParam.epochs = 500;
net2.numlayers = 2;
net2.layerConnect = [0 0;1 0];
net2.outputConnect = [0 1];
net2_model = train(net1,train_partition_2(:,1:6)',train_partition_2(:,7)');
predicted_Theta_2=sim(net2_model, test_partition_2(:,1:6)');
perf_2 = perform(net2_model, predicted_Theta_2 , test_partition_2(:,7)');
disp(perf_2);

thetaDifference_2 = test_partition_2(:,7)' - predicted_Theta_2;

% NN3 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net3= fitnet(hiddenSizes, trainingFunction);
net3.layers{1}.transferFcn = 'radbas';
net3.trainParam.epochs = 500;
net3.numlayers = 2;
net3.layerConnect = [0 0;1 0];
net3.outputConnect = [0 1];
net3_model = train(net3,train_partition_3(:,1:6)',train_partition_3(:,7)');
predicted_Theta_3=sim(net3_model, test_partition_3(:,1:6)');
perf_3 = perform(net3_model, predicted_Theta_3 , test_partition_3(:,7)');
disp(perf_3);

thetaDifference_3 = test_partition_3(:,7)' - predicted_Theta_3;

% NN4 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net4= fitnet(hiddenSizes, trainingFunction);
net4.layers{1}.transferFcn = 'radbas';
net4.trainParam.epochs = 500;
net4.numlayers = 2;
net4.layerConnect = [0 0;1 0];
net4.outputConnect = [0 1];
net4_model = train(net4,train_partition_4(:,1:6)',train_partition_4(:,7)');
predicted_Theta_4=sim(net4_model, test_partition_4(:,1:6)');
perf_4 = perform(net4_model, predicted_Theta_4 , test_partition_4(:,7)');
disp(perf_4);

thetaDifference_4 = test_partition_4(:,7)' - predicted_Theta_4;

% NN5 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net5= fitnet(hiddenSizes, trainingFunction);
net5.layers{1}.transferFcn = 'radbas';
net5.trainParam.epochs = 500;
net5.numlayers = 2;
net5.layerConnect = [0 0;1 0];
net5.outputConnect = [0 1];
net5_model = train(net5,train_partition_5(:,1:6)',train_partition_5(:,7)');
predicted_Theta_5=sim(net5_model, test_partition_5(:,1:6)');
perf_5 = perform(net5_model, predicted_Theta_5 , test_partition_5(:,7)');
disp(perf_5);

thetaDifference_5 = test_partition_5(:,7)' - predicted_Theta_5;

% NN6 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net6= fitnet(hiddenSizes, trainingFunction);
net6.layers{1}.transferFcn = 'radbas';
net6.trainParam.epochs = 500;
net6.numlayers = 2;
net6.layerConnect = [0 0;1 0];
net6.outputConnect = [0 1];
net6_model = train(net6,train_partition_6(:,1:6)',train_partition_6(:,7)');
predicted_Theta_6=sim(net6_model, test_partition_6(:,1:6)');
perf_6 = perform(net6_model, predicted_Theta_6 , test_partition_6(:,7)');
disp(perf_6);

thetaDifference_6 = test_partition_6(:,7)' - predicted_Theta_6;

% NN7 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net7= fitnet(hiddenSizes, trainingFunction);
net7.layers{1}.transferFcn = 'radbas';
net7.trainParam.epochs = 500;
net7.numlayers = 2;
net7.layerConnect = [0 0;1 0];
net7.outputConnect = [0 1];
net7_model = train(net7,train_partition_7(:,1:6)',train_partition_7(:,7)');
predicted_Theta_7=sim(net7_model, test_partition_7(:,1:6)');
perf_7 = perform(net7_model, predicted_Theta_7 , test_partition_7(:,7)');
disp(perf_7);

thetaDifference_7 = test_partition_7(:,7)' - predicted_Theta_7;

disp('8R on Type 1 is done');

%% 8R on Type 2
clear all; 


data_from_csv = readmatrix('dataset_fk_8R.csv');
theta_from_csv = readmatrix('dataset_thetas_8R.csv');


% Extracting data from FK
x = data_from_csv(:,1);
y = data_from_csv(:,2);
z = data_from_csv(:,3);
roll = data_from_csv(:,4);
pitch = data_from_csv(:,5);
yaw = data_from_csv(:,6);

 
% data = [x y z roll pitch yaw theta_1' theta_2' theta_3' theta_4' theta_5' theta_6' theta_7'];
data = [x y z roll pitch yaw theta_from_csv];
data_ = data(randperm(size(data, 1)),: );

disp('Data has been shuffled');
% Separating data into train and test
train_partition_1 = data_(1:round( size(data_,1)*5/7),1:7);
test_partition_1 = data_(round(size(data_,1)*6/7)+1:size(data_,1),1:7);

train_partition_2 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,8]);
test_partition_2 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,8]);

train_partition_3 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,9]);
test_partition_3 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,9]);

train_partition_4 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,10]);
test_partition_4 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,10]);

train_partition_5 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,11]);
test_partition_5 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,11]);

train_partition_6 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,12]);
test_partition_6 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,12]);

train_partition_7 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,13]);
test_partition_7 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,13]);
disp('Data separation done');

% NN1 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net1= fitnet(hiddenSizes, trainingFunction);
net1.layers{1}.transferFcn = 'radbas';
net1.trainParam.epochs = 500;
net1.numlayers = 2;
net1.layerConnect = [0 0;1 0];
net1.outputConnect = [0 1];
net1_model = train(net1,train_partition_1(:,1:6)',train_partition_1(:,7)' );
predicted_Theta_1=sim(net1_model, test_partition_1(:,1:6)');
perf_1 = perform(net1_model, predicted_Theta_1 , test_partition_1(:,7)');
disp(perf_1);

thetaDifference_1 = test_partition_1(:,7)' - predicted_Theta_1;

% NN2 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net2= fitnet(hiddenSizes, trainingFunction);
net2.layers{1}.transferFcn = 'radbas';
net2.trainParam.epochs = 500;
net2.numlayers = 2;
net2.layerConnect = [0 0;1 0];
net2.outputConnect = [0 1];
net2_model = train(net1,train_partition_2(:,1:6)',train_partition_2(:,7)');
predicted_Theta_2=sim(net2_model, test_partition_2(:,1:6)');
perf_2 = perform(net2_model, predicted_Theta_2 , test_partition_2(:,7)');
disp(perf_2);

thetaDifference_2 = test_partition_2(:,7)' - predicted_Theta_2;

% NN3 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net3= fitnet(hiddenSizes, trainingFunction);
net3.layers{1}.transferFcn = 'radbas';
net3.trainParam.epochs = 500;
net3.numlayers = 2;
net3.layerConnect = [0 0;1 0];
net3.outputConnect = [0 1];
net3_model = train(net3,train_partition_3(:,1:6)',train_partition_3(:,7)');
predicted_Theta_3=sim(net3_model, test_partition_3(:,1:6)');
perf_3 = perform(net3_model, predicted_Theta_3 , test_partition_3(:,7)');
disp(perf_3);

thetaDifference_3 = test_partition_3(:,7)' - predicted_Theta_3;

% NN4 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net4= fitnet(hiddenSizes, trainingFunction);
net4.layers{1}.transferFcn = 'radbas';
net4.trainParam.epochs = 500;
net4.numlayers = 2;
net4.layerConnect = [0 0;1 0];
net4.outputConnect = [0 1];
net4_model = train(net4,train_partition_4(:,1:6)',train_partition_4(:,7)');
predicted_Theta_4=sim(net4_model, test_partition_4(:,1:6)');
perf_4 = perform(net4_model, predicted_Theta_4 , test_partition_4(:,7)');
disp(perf_4);

thetaDifference_4 = test_partition_4(:,7)' - predicted_Theta_4;

% NN5 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net5= fitnet(hiddenSizes, trainingFunction);
net5.layers{1}.transferFcn = 'radbas';
net5.trainParam.epochs = 500;
net5.numlayers = 2;
net5.layerConnect = [0 0;1 0];
net5.outputConnect = [0 1];
net5_model = train(net5,train_partition_5(:,1:6)',train_partition_5(:,7)');
predicted_Theta_5=sim(net5_model, test_partition_5(:,1:6)');
perf_5 = perform(net5_model, predicted_Theta_5 , test_partition_5(:,7)');
disp(perf_5);

thetaDifference_5 = test_partition_5(:,7)' - predicted_Theta_5;

% NN6 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net6= fitnet(hiddenSizes, trainingFunction);
net6.layers{1}.transferFcn = 'radbas';
net6.trainParam.epochs = 500;
net6.numlayers = 2;
net6.layerConnect = [0 0;1 0];
net6.outputConnect = [0 1];
net6_model = train(net6,train_partition_6(:,1:6)',train_partition_6(:,7)');
predicted_Theta_6=sim(net6_model, test_partition_6(:,1:6)');
perf_6 = perform(net6_model, predicted_Theta_6 , test_partition_6(:,7)');
disp(perf_6);

thetaDifference_6 = test_partition_6(:,7)' - predicted_Theta_6;

% NN7 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net7= fitnet(hiddenSizes, trainingFunction);
net7.layers{1}.transferFcn = 'radbas';
net7.trainParam.epochs = 500;
net7.numlayers = 2;
net7.layerConnect = [0 0;1 0];
net7.outputConnect = [0 1];
net7_model = train(net7,train_partition_7(:,1:6)',train_partition_7(:,7)');
predicted_Theta_7=sim(net7_model, test_partition_7(:,1:6)');
perf_7 = perform(net7_model, predicted_Theta_7 , test_partition_7(:,7)');
disp(perf_7);

thetaDifference_7 = test_partition_7(:,7)' - predicted_Theta_7;
disp('8R on Type 2 is done');

%% 8R on Type 3

clear all; 
data_from_csv = readmatrix('dataset_fk_8R.csv');
theta_from_csv = readmatrix('dataset_thetas_8R.csv');


% Extracting data from FK
x = data_from_csv(:,1);
y = data_from_csv(:,2);
z = data_from_csv(:,3);
roll = data_from_csv(:,4);
pitch = data_from_csv(:,5);
yaw = data_from_csv(:,6);

 
% data = [x y z roll pitch yaw theta_1' theta_2' theta_3' theta_4' theta_5' theta_6' theta_7'];
data = [x y z roll pitch yaw theta_from_csv];
data_ = data(randperm(size(data, 1)),: );

disp('Data has been shuffled');
% Separating data into train and test
train_partition_1 = data_(1:round( size(data_,1)*5/7),1:7);
test_partition_1 = data_(round(size(data_,1)*6/7)+1:size(data_,1),1:7);

train_partition_2 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,8]);
test_partition_2 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,8]);

train_partition_3 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,9]);
test_partition_3 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,9]);

train_partition_4 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,10]);
test_partition_4 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,10]);

train_partition_5 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,11]);
test_partition_5 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,11]);

train_partition_6 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,12]);
test_partition_6 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,12]);

train_partition_7 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,13]);
test_partition_7 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,13]);
disp('Data separation done');


% NN1 and IK
hiddenSizes = [10 10];
trainingFunction = 'trainbr';
net1= fitnet(hiddenSizes, trainingFunction);
net1.layers{1}.transferFcn = 'radbas';
net1.layers{2}.transferFcn = 'radbas';
net1.trainParam.epochs = 500;
net1.numlayers = 3;
net1.biasConnect = [1;1;1];
net1.layerConnect = [0 0 0;1 0 0; 0 1 0];
net1.outputConnect = [0 0 1];
net1_model = train(net1,train_partition_1(:,1:6)',train_partition_1(:,7)');
predicted_Theta_1=sim(net1_model, test_partition_1(:,1:6)');
perf_1 = perform(net1_model, predicted_Theta_1 , test_partition_1(:,7)');
disp(perf_1);

thetaDifference_1 = test_partition_1(:,7)' - predicted_Theta_1;

% NN2 and IK
hiddenSizes = [10 10];
trainingFunction = 'trainbr';
net2= fitnet(hiddenSizes, trainingFunction);
net2.layers{1}.transferFcn = 'radbas';
net2.layers{2}.transferFcn = 'radbas';
net2.trainParam.epochs = 500;
net2.numlayers = 3;
net2.biasConnect = [1;1;1];
net2.layerConnect = [0 0 0;1 0 0; 0 1 0];
net2.outputConnect = [0 0 1];
net2_model = train(net1,train_partition_2(:,1:6)',train_partition_2(:,7)');
predicted_Theta_2=sim(net2_model, test_partition_2(:,1:6)');
perf_2 = perform(net2_model, predicted_Theta_2 , test_partition_2(:,7)');
disp(perf_2);

thetaDifference_2 = test_partition_2(:,7)' - predicted_Theta_2;

% NN3 and IK
hiddenSizes = [10 10];
trainingFunction = 'trainbr';
net3= fitnet(hiddenSizes, trainingFunction);
net3.layers{1}.transferFcn = 'radbas';
net3.layers{2}.transferFcn = 'radbas';
net3.trainParam.epochs = 500;
net3.numlayers = 3;
net3.biasConnect = [1;1;1];
net3.layerConnect = [0 0 0;1 0 0; 0 1 0];
net3.outputConnect = [0 0 1];
net3_model = train(net3,train_partition_3(:,1:6)',train_partition_3(:,7)');
predicted_Theta_3=sim(net3_model, test_partition_3(:,1:6)');
perf_3 = perform(net3_model, predicted_Theta_3 , test_partition_3(:,7)');
disp(perf_3);

thetaDifference_3 = test_partition_3(:,7)' - predicted_Theta_3;

% NN4 and IK
hiddenSizes = [10 10];
trainingFunction = 'trainbr';
net4= fitnet(hiddenSizes, trainingFunction);
net4.layers{1}.transferFcn = 'radbas';
net4.layers{2}.transferFcn = 'radbas';
net4.trainParam.epochs = 500;
net4.numlayers = 3;
net4.biasConnect = [1;1;1];
net4.layerConnect = [0 0 0;1 0 0; 0 1 0];
net4.outputConnect = [0 0 1];
net4_model = train(net4,train_partition_4(:,1:6)',train_partition_4(:,7)');
predicted_Theta_4=sim(net4_model, test_partition_4(:,1:6)');
perf_4 = perform(net4_model, predicted_Theta_4 , test_partition_4(:,7)');
disp(perf_4);

thetaDifference_4 = test_partition_4(:,7)' - predicted_Theta_4;

% NN5 and IK
hiddenSizes = [10 10];
trainingFunction = 'trainbr';
net5= fitnet(hiddenSizes, trainingFunction);
net5.layers{1}.transferFcn = 'radbas';
net5.layers{2}.transferFcn = 'radbas';
net5.trainParam.epochs = 500;
net5.numlayers = 3;
net5.biasConnect = [1;1;1];
net5.layerConnect = [0 0 0;1 0 0; 0 1 0];
net5.outputConnect = [0 0 1];
net5_model = train(net5,train_partition_5(:,1:6)',train_partition_5(:,7)');
predicted_Theta_5=sim(net5_model, test_partition_5(:,1:6)');
perf_5 = perform(net5_model, predicted_Theta_5 , test_partition_5(:,7)');
disp(perf_5);

thetaDifference_5 = test_partition_5(:,7)' - predicted_Theta_5;

% NN6 and IK
hiddenSizes = [10 10];
trainingFunction = 'trainbr';
net6= fitnet(hiddenSizes, trainingFunction);
net6.layers{1}.transferFcn = 'radbas';
net6.layers{2}.transferFcn = 'radbas';
net6.trainParam.epochs = 500;
net6.numlayers = 3;
net6.biasConnect = [1;1;1];
net6.layerConnect = [0 0 0;1 0 0; 0 1 0];
net6.outputConnect = [0 0 1];
net6_model = train(net6,train_partition_6(:,1:6)',train_partition_6(:,7)');
predicted_Theta_6=sim(net6_model, test_partition_6(:,1:6)');
perf_6 = perform(net6_model, predicted_Theta_6 , test_partition_6(:,7)');
disp(perf_6);

thetaDifference_6 = test_partition_6(:,7)' - predicted_Theta_6;

% NN7 and IK
hiddenSizes = [10 10];
trainingFunction = 'trainbr';
net7= fitnet(hiddenSizes, trainingFunction);
net7.layers{1}.transferFcn = 'radbas';
net7.layers{2}.transferFcn = 'radbas';
net7.trainParam.epochs = 500;
net7.numlayers = 3;
net7.biasConnect = [1;1;1];
net7.layerConnect = [0 0 0;1 0 0; 0 1 0];
net7.outputConnect = [0 0 1];
net7_model = train(net7,train_partition_7(:,1:6)',train_partition_7(:,7)');
predicted_Theta_7=sim(net7_model, test_partition_7(:,1:6)');
perf_7 = perform(net7_model, predicted_Theta_7 , test_partition_7(:,7)');
disp(perf_7);

thetaDifference_7 = test_partition_7(:,7)' - predicted_Theta_7;
disp('8R on Type 3 is done');

%% 8R on Type 4

clear all; 
data_from_csv = readmatrix('dataset_fk_8R.csv');
theta_from_csv = readmatrix('dataset_thetas_8R.csv');


% Extracting data from FK
x = data_from_csv(:,1);
y = data_from_csv(:,2);
z = data_from_csv(:,3);
roll = data_from_csv(:,4);
pitch = data_from_csv(:,5);
yaw = data_from_csv(:,6);

 
% data = [x y z roll pitch yaw theta_1' theta_2' theta_3' theta_4' theta_5' theta_6' theta_7'];
data = [x y z roll pitch yaw theta_from_csv];
data_ = data(randperm(size(data, 1)),: );

disp('Data has been shuffled');
% Separating data into train and test
train_partition_1 = data_(1:round( size(data_,1)*5/7),1:7);
test_partition_1 = data_(round(size(data_,1)*6/7)+1:size(data_,1),1:7);

train_partition_2 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,8]);
test_partition_2 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,8]);

train_partition_3 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,9]);
test_partition_3 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,9]);

train_partition_4 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,10]);
test_partition_4 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,10]);

train_partition_5 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,11]);
test_partition_5 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,11]);

train_partition_6 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,12]);
test_partition_6 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,12]);

train_partition_7 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,13]);
test_partition_7 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,13]);
disp('Data separation done');


% NN1 and IK
hiddenSizes = [30 10];
trainingFunction = 'trainbr';
net1= fitnet(hiddenSizes, trainingFunction);
net1.layers{1}.transferFcn = 'radbas';
net1.layers{2}.transferFcn = 'radbas';
net1.trainParam.epochs = 500;
net1.numlayers = 3;
net1.biasConnect = [1;1;1];
net1.layerConnect = [0 0 0;1 0 0; 0 1 0];
net1.outputConnect = [0 0 1];
net1_model = train(net1,train_partition_1(:,1:6)',train_partition_1(:,7)');
predicted_Theta_1=sim(net1_model, test_partition_1(:,1:6)');
perf_1 = perform(net1_model, predicted_Theta_1 , test_partition_1(:,7)');
disp(perf_1);

thetaDifference_1 = test_partition_1(:,7)' - predicted_Theta_1;

% NN2 and IK
hiddenSizes = [30 10];
trainingFunction = 'trainbr';
net2= fitnet(hiddenSizes, trainingFunction);
net2.layers{1}.transferFcn = 'radbas';
net2.layers{2}.transferFcn = 'radbas';
net2.trainParam.epochs = 500;
net2.numlayers = 3;
net2.biasConnect = [1;1;1];
net2.layerConnect = [0 0 0;1 0 0; 0 1 0];
net2.outputConnect = [0 0 1];
net2_model = train(net1,train_partition_2(:,1:6)',train_partition_2(:,7)');
predicted_Theta_2=sim(net2_model, test_partition_2(:,1:6)');
perf_2 = perform(net2_model, predicted_Theta_2 , test_partition_2(:,7)');
disp(perf_2);

thetaDifference_2 = test_partition_2(:,7)' - predicted_Theta_2;

% NN3 and IK
hiddenSizes = [30 10];
trainingFunction = 'trainbr';
net3= fitnet(hiddenSizes, trainingFunction);
net3.layers{1}.transferFcn = 'radbas';
net3.layers{2}.transferFcn = 'radbas';
net3.trainParam.epochs = 500;
net3.numlayers = 3;
net3.biasConnect = [1;1;1];
net3.layerConnect = [0 0 0;1 0 0; 0 1 0];
net3.outputConnect = [0 0 1];
net3_model = train(net3,train_partition_3(:,1:6)',train_partition_3(:,7)');
predicted_Theta_3=sim(net3_model, test_partition_3(:,1:6)');
perf_3 = perform(net3_model, predicted_Theta_3 , test_partition_3(:,7)');
disp(perf_3);

thetaDifference_3 = test_partition_3(:,7)' - predicted_Theta_3;

% NN4 and IK
hiddenSizes = [30 10];
trainingFunction = 'trainbr';
net4= fitnet(hiddenSizes, trainingFunction);
net4.layers{1}.transferFcn = 'radbas';
net4.layers{2}.transferFcn = 'radbas';
net4.trainParam.epochs = 500;
net4.numlayers = 3;
net4.biasConnect = [1;1;1];
net4.layerConnect = [0 0 0;1 0 0; 0 1 0];
net4.outputConnect = [0 0 1];
net4_model = train(net4,train_partition_4(:,1:6)',train_partition_4(:,7)');
predicted_Theta_4=sim(net4_model, test_partition_4(:,1:6)');
perf_4 = perform(net4_model, predicted_Theta_4 , test_partition_4(:,7)');
disp(perf_4);

thetaDifference_4 = test_partition_4(:,7)' - predicted_Theta_4;

% NN5 and IK
hiddenSizes = [30 10];
trainingFunction = 'trainbr';
net5= fitnet(hiddenSizes, trainingFunction);
net5.layers{1}.transferFcn = 'radbas';
net5.layers{2}.transferFcn = 'radbas';
net5.trainParam.epochs = 500;
net5.numlayers = 3;
net5.biasConnect = [1;1;1];
net5.layerConnect = [0 0 0;1 0 0; 0 1 0];
net5.outputConnect = [0 0 1];
net5_model = train(net5,train_partition_5(:,1:6)',train_partition_5(:,7)');
predicted_Theta_5=sim(net5_model, test_partition_5(:,1:6)');
perf_5 = perform(net5_model, predicted_Theta_5 , test_partition_5(:,7)');
disp(perf_5);

thetaDifference_5 = test_partition_5(:,7)' - predicted_Theta_5;

% NN6 and IK
hiddenSizes = [30 10];
trainingFunction = 'trainbr';
net6= fitnet(hiddenSizes, trainingFunction);
net6.layers{1}.transferFcn = 'radbas';
net6.layers{2}.transferFcn = 'radbas';
net6.trainParam.epochs = 500;
net6.numlayers = 3;
net6.biasConnect = [1;1;1];
net6.layerConnect = [0 0 0;1 0 0; 0 1 0];
net6.outputConnect = [0 0 1];
net6_model = train(net6,train_partition_6(:,1:6)',train_partition_6(:,7)');
predicted_Theta_6=sim(net6_model, test_partition_6(:,1:6)');
perf_6 = perform(net6_model, predicted_Theta_6 , test_partition_6(:,7)');
disp(perf_6);

thetaDifference_6 = test_partition_6(:,7)' - predicted_Theta_6;

% NN7 and IK
hiddenSizes = [30 10];
trainingFunction = 'trainbr';
net7= fitnet(hiddenSizes, trainingFunction);
net7.layers{1}.transferFcn = 'radbas';
net7.layers{2}.transferFcn = 'radbas';
net7.trainParam.epochs = 500;
net7.numlayers = 3;
net7.biasConnect = [1;1;1];
net7.layerConnect = [0 0 0;1 0 0; 0 1 0];
net7.outputConnect = [0 0 1];
net7_model = train(net7,train_partition_7(:,1:6)',train_partition_7(:,7)');
predicted_Theta_7=sim(net7_model, test_partition_7(:,1:6)');
perf_7 = perform(net7_model, predicted_Theta_7 , test_partition_7(:,7)');
disp(perf_7);

thetaDifference_7 = test_partition_7(:,7)' - predicted_Theta_7;

disp('8R on Type 4 is done');


%% 8R on Type 5

clear all; 
data_from_csv = readmatrix('dataset_fk_8R.csv');
theta_from_csv = readmatrix('dataset_thetas_8R.csv');


% Extracting data from FK
x = data_from_csv(:,1);
y = data_from_csv(:,2);
z = data_from_csv(:,3);
roll = data_from_csv(:,4);
pitch = data_from_csv(:,5);
yaw = data_from_csv(:,6);

 
% data = [x y z roll pitch yaw theta_1' theta_2' theta_3' theta_4' theta_5' theta_6' theta_7'];
data = [x y z roll pitch yaw theta_from_csv];
data_ = data(randperm(size(data, 1)),: );

disp('Data has been shuffled');
% Separating data into train and test
train_partition_1 = data_(1:round( size(data_,1)*5/7),1:7);
test_partition_1 = data_(round(size(data_,1)*6/7)+1:size(data_,1),1:7);

train_partition_2 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,8]);
test_partition_2 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,8]);

train_partition_3 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,9]);
test_partition_3 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,9]);

train_partition_4 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,10]);
test_partition_4 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,10]);

train_partition_5 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,11]);
test_partition_5 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,11]);

train_partition_6 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,12]);
test_partition_6 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,12]);

train_partition_7 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,13]);
test_partition_7 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,13]);
disp('Data separation done');


% NN1 and IK
hiddenSizes = [30 30];
trainingFunction = 'trainbr';
net1= fitnet(hiddenSizes, trainingFunction);
net1.layers{1}.transferFcn = 'radbas';
net1.layers{2}.transferFcn = 'radbas';
net1.trainParam.epochs = 500;
net1.numlayers = 3;
net1.biasConnect = [1;1;1];
net1.layerConnect = [0 0 0;1 0 0; 0 1 0];
net1.outputConnect = [0 0 1];
net1_model = train(net1,train_partition_1(:,1:6)',train_partition_1(:,7)');
predicted_Theta_1=sim(net1_model, test_partition_1(:,1:6)');
perf_1 = perform(net1_model, predicted_Theta_1 , test_partition_1(:,7)');
disp(perf_1);

thetaDifference_1 = test_partition_1(:,7)' - predicted_Theta_1;

% NN2 and IK
hiddenSizes = [30 30];
trainingFunction = 'trainbr';
net2= fitnet(hiddenSizes, trainingFunction);
net2.layers{1}.transferFcn = 'radbas';
net2.layers{2}.transferFcn = 'radbas';
net2.trainParam.epochs = 500;
net2.numlayers = 3;
net2.biasConnect = [1;1;1];
net2.layerConnect = [0 0 0;1 0 0; 0 1 0];
net2.outputConnect = [0 0 1];
net2_model = train(net1,train_partition_2(:,1:6)',train_partition_2(:,7)');
predicted_Theta_2=sim(net2_model, test_partition_2(:,1:6)');
perf_2 = perform(net2_model, predicted_Theta_2 , test_partition_2(:,7)');
disp(perf_2);

thetaDifference_2 = test_partition_2(:,7)' - predicted_Theta_2;

% NN3 and IK
hiddenSizes = [30 30];
trainingFunction = 'trainbr';
net3= fitnet(hiddenSizes, trainingFunction);
net3.layers{1}.transferFcn = 'radbas';
net3.layers{2}.transferFcn = 'radbas';
net3.trainParam.epochs = 500;
net3.numlayers = 3;
net3.biasConnect = [1;1;1];
net3.layerConnect = [0 0 0;1 0 0; 0 1 0];
net3.outputConnect = [0 0 1];
net3_model = train(net3,train_partition_3(:,1:6)',train_partition_3(:,7)');
predicted_Theta_3=sim(net3_model, test_partition_3(:,1:6)');
perf_3 = perform(net3_model, predicted_Theta_3 , test_partition_3(:,7)');
disp(perf_3);

thetaDifference_3 = test_partition_3(:,7)' - predicted_Theta_3;

% NN4 and IK
hiddenSizes = [30 30];
trainingFunction = 'trainbr';
net4= fitnet(hiddenSizes, trainingFunction);
net4.layers{1}.transferFcn = 'radbas';
net4.layers{2}.transferFcn = 'radbas';
net4.trainParam.epochs = 500;
net4.numlayers = 3;
net4.biasConnect = [1;1;1];
net4.layerConnect = [0 0 0;1 0 0; 0 1 0];
net4.outputConnect = [0 0 1];
net4_model = train(net4,train_partition_4(:,1:6)',train_partition_4(:,7)');
predicted_Theta_4=sim(net4_model, test_partition_4(:,1:6)');
perf_4 = perform(net4_model, predicted_Theta_4 , test_partition_4(:,7)');
disp(perf_4);

thetaDifference_4 = test_partition_4(:,7)' - predicted_Theta_4;

% NN5 and IK
hiddenSizes = [30 30];
trainingFunction = 'trainbr';
net5= fitnet(hiddenSizes, trainingFunction);
net5.layers{1}.transferFcn = 'radbas';
net5.layers{2}.transferFcn = 'radbas';
net5.trainParam.epochs = 500;
net5.numlayers = 3;
net5.biasConnect = [1;1;1];
net5.layerConnect = [0 0 0;1 0 0; 0 1 0];
net5.outputConnect = [0 0 1];
net5_model = train(net5,train_partition_5(:,1:6)',train_partition_5(:,7)');
predicted_Theta_5=sim(net5_model, test_partition_5(:,1:6)');
perf_5 = perform(net5_model, predicted_Theta_5 , test_partition_5(:,7)');
disp(perf_5);

thetaDifference_5 = test_partition_5(:,7)' - predicted_Theta_5;

% NN6 and IK
hiddenSizes = [30 30];
trainingFunction = 'trainbr';
net6= fitnet(hiddenSizes, trainingFunction);
net6.layers{1}.transferFcn = 'radbas';
net6.layers{2}.transferFcn = 'radbas';
net6.trainParam.epochs = 500;
net6.numlayers = 3;
net6.biasConnect = [1;1;1];
net6.layerConnect = [0 0 0;1 0 0; 0 1 0];
net6.outputConnect = [0 0 1];
net6_model = train(net6,train_partition_6(:,1:6)',train_partition_6(:,7)');
predicted_Theta_6=sim(net6_model, test_partition_6(:,1:6)');
perf_6 = perform(net6_model, predicted_Theta_6 , test_partition_6(:,7)');
disp(perf_6);

thetaDifference_6 = test_partition_6(:,7)' - predicted_Theta_6;

% NN7 and IK
hiddenSizes = [30 30];
trainingFunction = 'trainbr';
net7= fitnet(hiddenSizes, trainingFunction);
net7.layers{1}.transferFcn = 'radbas';
net7.layers{2}.transferFcn = 'radbas';
net7.trainParam.epochs = 500;
net7.numlayers = 3;
net7.biasConnect = [1;1;1];
net7.layerConnect = [0 0 0;1 0 0; 0 1 0];
net7.outputConnect = [0 0 1];
net7_model = train(net7,train_partition_7(:,1:6)',train_partition_7(:,7)');
predicted_Theta_7=sim(net7_model, test_partition_7(:,1:6)');
perf_7 = perform(net7_model, predicted_Theta_7 , test_partition_7(:,7)');
disp(perf_7);

thetaDifference_7 = test_partition_7(:,7)' - predicted_Theta_7;

disp('8R on Type 5 is done');

%% 8E for Type 1
clear all; 

data_from_csv = readmatrix('dataset_fk_8E.csv');
theta_from_csv = readmatrix('dataset_thetas_8E.csv');


% Extracting data from FK
x = data_from_csv(:,1);
y = data_from_csv(:,2);
z = data_from_csv(:,3);
roll = data_from_csv(:,4);
pitch = data_from_csv(:,5);
yaw = data_from_csv(:,6);

 
% data = [x y z roll pitch yaw theta_1' theta_2' theta_3' theta_4' theta_5' theta_6' theta_7'];
data = [x y z roll pitch yaw theta_from_csv];
data_ = data(randperm(size(data, 1)),: );

disp('Data has been shuffled');
% Separating data into train and test
train_partition_1 = data_(1:round( size(data_,1)*5/7),1:7);
test_partition_1 = data_(round(size(data_,1)*6/7)+1:size(data_,1),1:7);

train_partition_2 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,8]);
test_partition_2 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,8]);

train_partition_3 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,9]);
test_partition_3 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,9]);

train_partition_4 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,10]);
test_partition_4 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,10]);

train_partition_5 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,11]);
test_partition_5 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,11]);

train_partition_6 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,12]);
test_partition_6 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,12]);

train_partition_7 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,13]);
test_partition_7 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,13]);
disp('Data separation done');

% NN1 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net1= fitnet(hiddenSizes, trainingFunction);
net1.layers{1}.transferFcn = 'radbas';
net1.trainParam.epochs = 500;
net1.numlayers = 2;
net1.layerConnect = [0 0;1 0];
net1.outputConnect = [0 1];
net1_model = train(net1,train_partition_1(:,1:6)',train_partition_1(:,7)' );
predicted_Theta_1=sim(net1_model, test_partition_1(:,1:6)');
perf_1 = perform(net1_model, predicted_Theta_1 , test_partition_1(:,7)');
disp(perf_1);

thetaDifference_1 = test_partition_1(:,7)' - predicted_Theta_1;

% NN2 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net2= fitnet(hiddenSizes, trainingFunction);
net2.layers{1}.transferFcn = 'radbas';
net2.trainParam.epochs = 500;
net2.numlayers = 2;
net2.layerConnect = [0 0;1 0];
net2.outputConnect = [0 1];
net2_model = train(net1,train_partition_2(:,1:6)',train_partition_2(:,7)');
predicted_Theta_2=sim(net2_model, test_partition_2(:,1:6)');
perf_2 = perform(net2_model, predicted_Theta_2 , test_partition_2(:,7)');
disp(perf_2);

thetaDifference_2 = test_partition_2(:,7)' - predicted_Theta_2;

% NN3 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net3= fitnet(hiddenSizes, trainingFunction);
net3.layers{1}.transferFcn = 'radbas';
net3.trainParam.epochs = 500;
net3.numlayers = 2;
net3.layerConnect = [0 0;1 0];
net3.outputConnect = [0 1];
net3_model = train(net3,train_partition_3(:,1:6)',train_partition_3(:,7)');
predicted_Theta_3=sim(net3_model, test_partition_3(:,1:6)');
perf_3 = perform(net3_model, predicted_Theta_3 , test_partition_3(:,7)');
disp(perf_3);

thetaDifference_3 = test_partition_3(:,7)' - predicted_Theta_3;

% NN4 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net4= fitnet(hiddenSizes, trainingFunction);
net4.layers{1}.transferFcn = 'radbas';
net4.trainParam.epochs = 500;
net4.numlayers = 2;
net4.layerConnect = [0 0;1 0];
net4.outputConnect = [0 1];
net4_model = train(net4,train_partition_4(:,1:6)',train_partition_4(:,7)');
predicted_Theta_4=sim(net4_model, test_partition_4(:,1:6)');
perf_4 = perform(net4_model, predicted_Theta_4 , test_partition_4(:,7)');
disp(perf_4);

thetaDifference_4 = test_partition_4(:,7)' - predicted_Theta_4;

% NN5 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net5= fitnet(hiddenSizes, trainingFunction);
net5.layers{1}.transferFcn = 'radbas';
net5.trainParam.epochs = 500;
net5.numlayers = 2;
net5.layerConnect = [0 0;1 0];
net5.outputConnect = [0 1];
net5_model = train(net5,train_partition_5(:,1:6)',train_partition_5(:,7)');
predicted_Theta_5=sim(net5_model, test_partition_5(:,1:6)');
perf_5 = perform(net5_model, predicted_Theta_5 , test_partition_5(:,7)');
disp(perf_5);

thetaDifference_5 = test_partition_5(:,7)' - predicted_Theta_5;

% NN6 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net6= fitnet(hiddenSizes, trainingFunction);
net6.layers{1}.transferFcn = 'radbas';
net6.trainParam.epochs = 500;
net6.numlayers = 2;
net6.layerConnect = [0 0;1 0];
net6.outputConnect = [0 1];
net6_model = train(net6,train_partition_6(:,1:6)',train_partition_6(:,7)');
predicted_Theta_6=sim(net6_model, test_partition_6(:,1:6)');
perf_6 = perform(net6_model, predicted_Theta_6 , test_partition_6(:,7)');
disp(perf_6);

thetaDifference_6 = test_partition_6(:,7)' - predicted_Theta_6;

% NN7 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net7= fitnet(hiddenSizes, trainingFunction);
net7.layers{1}.transferFcn = 'radbas';
net7.trainParam.epochs = 500;
net7.numlayers = 2;
net7.layerConnect = [0 0;1 0];
net7.outputConnect = [0 1];
net7_model = train(net7,train_partition_7(:,1:6)',train_partition_7(:,7)');
predicted_Theta_7=sim(net7_model, test_partition_7(:,1:6)');
perf_7 = perform(net7_model, predicted_Theta_7 , test_partition_7(:,7)');
disp(perf_7);

thetaDifference_7 = test_partition_7(:,7)' - predicted_Theta_7;

disp('8E on Type 1 is done');

%% 8E on Type 2
clear all; 


data_from_csv = readmatrix('dataset_fk_8E.csv');
theta_from_csv = readmatrix('dataset_thetas_8E.csv');


% Extracting data from FK
x = data_from_csv(:,1);
y = data_from_csv(:,2);
z = data_from_csv(:,3);
roll = data_from_csv(:,4);
pitch = data_from_csv(:,5);
yaw = data_from_csv(:,6);

 
% data = [x y z roll pitch yaw theta_1' theta_2' theta_3' theta_4' theta_5' theta_6' theta_7'];
data = [x y z roll pitch yaw theta_from_csv];
data_ = data(randperm(size(data, 1)),: );

disp('Data has been shuffled');
% Separating data into train and test
train_partition_1 = data_(1:round( size(data_,1)*5/7),1:7);
test_partition_1 = data_(round(size(data_,1)*6/7)+1:size(data_,1),1:7);

train_partition_2 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,8]);
test_partition_2 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,8]);

train_partition_3 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,9]);
test_partition_3 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,9]);

train_partition_4 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,10]);
test_partition_4 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,10]);

train_partition_5 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,11]);
test_partition_5 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,11]);

train_partition_6 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,12]);
test_partition_6 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,12]);

train_partition_7 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,13]);
test_partition_7 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,13]);
disp('Data separation done');

% NN1 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net1= fitnet(hiddenSizes, trainingFunction);
net1.layers{1}.transferFcn = 'radbas';
net1.trainParam.epochs = 500;
net1.numlayers = 2;
net1.layerConnect = [0 0;1 0];
net1.outputConnect = [0 1];
net1_model = train(net1,train_partition_1(:,1:6)',train_partition_1(:,7)' );
predicted_Theta_1=sim(net1_model, test_partition_1(:,1:6)');
perf_1 = perform(net1_model, predicted_Theta_1 , test_partition_1(:,7)');
disp(perf_1);

thetaDifference_1 = test_partition_1(:,7)' - predicted_Theta_1;

% NN2 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net2= fitnet(hiddenSizes, trainingFunction);
net2.layers{1}.transferFcn = 'radbas';
net2.trainParam.epochs = 500;
net2.numlayers = 2;
net2.layerConnect = [0 0;1 0];
net2.outputConnect = [0 1];
net2_model = train(net1,train_partition_2(:,1:6)',train_partition_2(:,7)');
predicted_Theta_2=sim(net2_model, test_partition_2(:,1:6)');
perf_2 = perform(net2_model, predicted_Theta_2 , test_partition_2(:,7)');
disp(perf_2);

thetaDifference_2 = test_partition_2(:,7)' - predicted_Theta_2;

% NN3 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net3= fitnet(hiddenSizes, trainingFunction);
net3.layers{1}.transferFcn = 'radbas';
net3.trainParam.epochs = 500;
net3.numlayers = 2;
net3.layerConnect = [0 0;1 0];
net3.outputConnect = [0 1];
net3_model = train(net3,train_partition_3(:,1:6)',train_partition_3(:,7)');
predicted_Theta_3=sim(net3_model, test_partition_3(:,1:6)');
perf_3 = perform(net3_model, predicted_Theta_3 , test_partition_3(:,7)');
disp(perf_3);

thetaDifference_3 = test_partition_3(:,7)' - predicted_Theta_3;

% NN4 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net4= fitnet(hiddenSizes, trainingFunction);
net4.layers{1}.transferFcn = 'radbas';
net4.trainParam.epochs = 500;
net4.numlayers = 2;
net4.layerConnect = [0 0;1 0];
net4.outputConnect = [0 1];
net4_model = train(net4,train_partition_4(:,1:6)',train_partition_4(:,7)');
predicted_Theta_4=sim(net4_model, test_partition_4(:,1:6)');
perf_4 = perform(net4_model, predicted_Theta_4 , test_partition_4(:,7)');
disp(perf_4);

thetaDifference_4 = test_partition_4(:,7)' - predicted_Theta_4;

% NN5 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net5= fitnet(hiddenSizes, trainingFunction);
net5.layers{1}.transferFcn = 'radbas';
net5.trainParam.epochs = 500;
net5.numlayers = 2;
net5.layerConnect = [0 0;1 0];
net5.outputConnect = [0 1];
net5_model = train(net5,train_partition_5(:,1:6)',train_partition_5(:,7)');
predicted_Theta_5=sim(net5_model, test_partition_5(:,1:6)');
perf_5 = perform(net5_model, predicted_Theta_5 , test_partition_5(:,7)');
disp(perf_5);

thetaDifference_5 = test_partition_5(:,7)' - predicted_Theta_5;

% NN6 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net6= fitnet(hiddenSizes, trainingFunction);
net6.layers{1}.transferFcn = 'radbas';
net6.trainParam.epochs = 500;
net6.numlayers = 2;
net6.layerConnect = [0 0;1 0];
net6.outputConnect = [0 1];
net6_model = train(net6,train_partition_6(:,1:6)',train_partition_6(:,7)');
predicted_Theta_6=sim(net6_model, test_partition_6(:,1:6)');
perf_6 = perform(net6_model, predicted_Theta_6 , test_partition_6(:,7)');
disp(perf_6);

thetaDifference_6 = test_partition_6(:,7)' - predicted_Theta_6;

% NN7 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net7= fitnet(hiddenSizes, trainingFunction);
net7.layers{1}.transferFcn = 'radbas';
net7.trainParam.epochs = 500;
net7.numlayers = 2;
net7.layerConnect = [0 0;1 0];
net7.outputConnect = [0 1];
net7_model = train(net7,train_partition_7(:,1:6)',train_partition_7(:,7)');
predicted_Theta_7=sim(net7_model, test_partition_7(:,1:6)');
perf_7 = perform(net7_model, predicted_Theta_7 , test_partition_7(:,7)');
disp(perf_7);

thetaDifference_7 = test_partition_7(:,7)' - predicted_Theta_7;

disp('8E on Type 2 is done');

%% 8E on Type 3

clear all; 
data_from_csv = readmatrix('dataset_fk_8E.csv');
theta_from_csv = readmatrix('dataset_thetas_8E.csv');


% Extracting data from FK
x = data_from_csv(:,1);
y = data_from_csv(:,2);
z = data_from_csv(:,3);
roll = data_from_csv(:,4);
pitch = data_from_csv(:,5);
yaw = data_from_csv(:,6);

 
% data = [x y z roll pitch yaw theta_1' theta_2' theta_3' theta_4' theta_5' theta_6' theta_7'];
data = [x y z roll pitch yaw theta_from_csv];
data_ = data(randperm(size(data, 1)),: );

disp('Data has been shuffled');
% Separating data into train and test
train_partition_1 = data_(1:round( size(data_,1)*5/7),1:7);
test_partition_1 = data_(round(size(data_,1)*6/7)+1:size(data_,1),1:7);

train_partition_2 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,8]);
test_partition_2 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,8]);

train_partition_3 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,9]);
test_partition_3 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,9]);

train_partition_4 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,10]);
test_partition_4 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,10]);

train_partition_5 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,11]);
test_partition_5 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,11]);

train_partition_6 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,12]);
test_partition_6 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,12]);

train_partition_7 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,13]);
test_partition_7 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,13]);
disp('Data separation done');


% NN1 and IK
hiddenSizes = [10 10];
trainingFunction = 'trainbr';
net1= fitnet(hiddenSizes, trainingFunction);
net1.layers{1}.transferFcn = 'radbas';
net1.layers{2}.transferFcn = 'radbas';
net1.trainParam.epochs = 500;
net1.numlayers = 3;
net1.biasConnect = [1;1;1];
net1.layerConnect = [0 0 0;1 0 0; 0 1 0];
net1.outputConnect = [0 0 1];
net1_model = train(net1,train_partition_1(:,1:6)',train_partition_1(:,7)');
predicted_Theta_1=sim(net1_model, test_partition_1(:,1:6)');
perf_1 = perform(net1_model, predicted_Theta_1 , test_partition_1(:,7)');
disp(perf_1);

thetaDifference_1 = test_partition_1(:,7)' - predicted_Theta_1;

% NN2 and IK
hiddenSizes = [10 10];
trainingFunction = 'trainbr';
net2= fitnet(hiddenSizes, trainingFunction);
net2.layers{1}.transferFcn = 'radbas';
net2.layers{2}.transferFcn = 'radbas';
net2.trainParam.epochs = 500;
net2.numlayers = 3;
net2.biasConnect = [1;1;1];
net2.layerConnect = [0 0 0;1 0 0; 0 1 0];
net2.outputConnect = [0 0 1];
net2_model = train(net1,train_partition_2(:,1:6)',train_partition_2(:,7)');
predicted_Theta_2=sim(net2_model, test_partition_2(:,1:6)');
perf_2 = perform(net2_model, predicted_Theta_2 , test_partition_2(:,7)');
disp(perf_2);

thetaDifference_2 = test_partition_2(:,7)' - predicted_Theta_2;

% NN3 and IK
hiddenSizes = [10 10];
trainingFunction = 'trainbr';
net3= fitnet(hiddenSizes, trainingFunction);
net3.layers{1}.transferFcn = 'radbas';
net3.layers{2}.transferFcn = 'radbas';
net3.trainParam.epochs = 500;
net3.numlayers = 3;
net3.biasConnect = [1;1;1];
net3.layerConnect = [0 0 0;1 0 0; 0 1 0];
net3.outputConnect = [0 0 1];
net3_model = train(net3,train_partition_3(:,1:6)',train_partition_3(:,7)');
predicted_Theta_3=sim(net3_model, test_partition_3(:,1:6)');
perf_3 = perform(net3_model, predicted_Theta_3 , test_partition_3(:,7)');
disp(perf_3);

thetaDifference_3 = test_partition_3(:,7)' - predicted_Theta_3;

% NN4 and IK
hiddenSizes = [10 10];
trainingFunction = 'trainbr';
net4= fitnet(hiddenSizes, trainingFunction);
net4.layers{1}.transferFcn = 'radbas';
net4.layers{2}.transferFcn = 'radbas';
net4.trainParam.epochs = 500;
net4.numlayers = 3;
net4.biasConnect = [1;1;1];
net4.layerConnect = [0 0 0;1 0 0; 0 1 0];
net4.outputConnect = [0 0 1];
net4_model = train(net4,train_partition_4(:,1:6)',train_partition_4(:,7)');
predicted_Theta_4=sim(net4_model, test_partition_4(:,1:6)');
perf_4 = perform(net4_model, predicted_Theta_4 , test_partition_4(:,7)');
disp(perf_4);

thetaDifference_4 = test_partition_4(:,7)' - predicted_Theta_4;

% NN5 and IK
hiddenSizes = [10 10];
trainingFunction = 'trainbr';
net5= fitnet(hiddenSizes, trainingFunction);
net5.layers{1}.transferFcn = 'radbas';
net5.layers{2}.transferFcn = 'radbas';
net5.trainParam.epochs = 500;
net5.numlayers = 3;
net5.biasConnect = [1;1;1];
net5.layerConnect = [0 0 0;1 0 0; 0 1 0];
net5.outputConnect = [0 0 1];
net5_model = train(net5,train_partition_5(:,1:6)',train_partition_5(:,7)');
predicted_Theta_5=sim(net5_model, test_partition_5(:,1:6)');
perf_5 = perform(net5_model, predicted_Theta_5 , test_partition_5(:,7)');
disp(perf_5);

thetaDifference_5 = test_partition_5(:,7)' - predicted_Theta_5;

% NN6 and IK
hiddenSizes = [10 10];
trainingFunction = 'trainbr';
net6= fitnet(hiddenSizes, trainingFunction);
net6.layers{1}.transferFcn = 'radbas';
net6.layers{2}.transferFcn = 'radbas';
net6.trainParam.epochs = 500;
net6.numlayers = 3;
net6.biasConnect = [1;1;1];
net6.layerConnect = [0 0 0;1 0 0; 0 1 0];
net6.outputConnect = [0 0 1];
net6_model = train(net6,train_partition_6(:,1:6)',train_partition_6(:,7)');
predicted_Theta_6=sim(net6_model, test_partition_6(:,1:6)');
perf_6 = perform(net6_model, predicted_Theta_6 , test_partition_6(:,7)');
disp(perf_6);

thetaDifference_6 = test_partition_6(:,7)' - predicted_Theta_6;

% NN7 and IK
hiddenSizes = [10 10];
trainingFunction = 'trainbr';
net7= fitnet(hiddenSizes, trainingFunction);
net7.layers{1}.transferFcn = 'radbas';
net7.layers{2}.transferFcn = 'radbas';
net7.trainParam.epochs = 500;
net7.numlayers = 3;
net7.biasConnect = [1;1;1];
net7.layerConnect = [0 0 0;1 0 0; 0 1 0];
net7.outputConnect = [0 0 1];
net7_model = train(net7,train_partition_7(:,1:6)',train_partition_7(:,7)');
predicted_Theta_7=sim(net7_model, test_partition_7(:,1:6)');
perf_7 = perform(net7_model, predicted_Theta_7 , test_partition_7(:,7)');
disp(perf_7);

thetaDifference_7 = test_partition_7(:,7)' - predicted_Theta_7;

disp('8E on Type 3 is done');

%% 8E on Type 4

clear all; 
data_from_csv = readmatrix('dataset_fk_8E.csv');
theta_from_csv = readmatrix('dataset_thetas_8E.csv');


% Extracting data from FK
x = data_from_csv(:,1);
y = data_from_csv(:,2);
z = data_from_csv(:,3);
roll = data_from_csv(:,4);
pitch = data_from_csv(:,5);
yaw = data_from_csv(:,6);

 
% data = [x y z roll pitch yaw theta_1' theta_2' theta_3' theta_4' theta_5' theta_6' theta_7'];
data = [x y z roll pitch yaw theta_from_csv];
data_ = data(randperm(size(data, 1)),: );

disp('Data has been shuffled');
% Separating data into train and test
train_partition_1 = data_(1:round( size(data_,1)*5/7),1:7);
test_partition_1 = data_(round(size(data_,1)*6/7)+1:size(data_,1),1:7);

train_partition_2 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,8]);
test_partition_2 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,8]);

train_partition_3 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,9]);
test_partition_3 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,9]);

train_partition_4 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,10]);
test_partition_4 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,10]);

train_partition_5 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,11]);
test_partition_5 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,11]);

train_partition_6 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,12]);
test_partition_6 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,12]);

train_partition_7 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,13]);
test_partition_7 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,13]);
disp('Data separation done');


% NN1 and IK
hiddenSizes = [30 10];
trainingFunction = 'trainbr';
net1= fitnet(hiddenSizes, trainingFunction);
net1.layers{1}.transferFcn = 'radbas';
net1.layers{2}.transferFcn = 'radbas';
net1.trainParam.epochs = 500;
net1.numlayers = 3;
net1.biasConnect = [1;1;1];
net1.layerConnect = [0 0 0;1 0 0; 0 1 0];
net1.outputConnect = [0 0 1];
net1_model = train(net1,train_partition_1(:,1:6)',train_partition_1(:,7)');
predicted_Theta_1=sim(net1_model, test_partition_1(:,1:6)');
perf_1 = perform(net1_model, predicted_Theta_1 , test_partition_1(:,7)');
disp(perf_1);

thetaDifference_1 = test_partition_1(:,7)' - predicted_Theta_1;

% NN2 and IK
hiddenSizes = [30 10];
trainingFunction = 'trainbr';
net2= fitnet(hiddenSizes, trainingFunction);
net2.layers{1}.transferFcn = 'radbas';
net2.layers{2}.transferFcn = 'radbas';
net2.trainParam.epochs = 500;
net2.numlayers = 3;
net2.biasConnect = [1;1;1];
net2.layerConnect = [0 0 0;1 0 0; 0 1 0];
net2.outputConnect = [0 0 1];
net2_model = train(net1,train_partition_2(:,1:6)',train_partition_2(:,7)');
predicted_Theta_2=sim(net2_model, test_partition_2(:,1:6)');
perf_2 = perform(net2_model, predicted_Theta_2 , test_partition_2(:,7)');
disp(perf_2);

thetaDifference_2 = test_partition_2(:,7)' - predicted_Theta_2;

% NN3 and IK
hiddenSizes = [30 10];
trainingFunction = 'trainbr';
net3= fitnet(hiddenSizes, trainingFunction);
net3.layers{1}.transferFcn = 'radbas';
net3.layers{2}.transferFcn = 'radbas';
net3.trainParam.epochs = 500;
net3.numlayers = 3;
net3.biasConnect = [1;1;1];
net3.layerConnect = [0 0 0;1 0 0; 0 1 0];
net3.outputConnect = [0 0 1];
net3_model = train(net3,train_partition_3(:,1:6)',train_partition_3(:,7)');
predicted_Theta_3=sim(net3_model, test_partition_3(:,1:6)');
perf_3 = perform(net3_model, predicted_Theta_3 , test_partition_3(:,7)');
disp(perf_3);

thetaDifference_3 = test_partition_3(:,7)' - predicted_Theta_3;

% NN4 and IK
hiddenSizes = [30 10];
trainingFunction = 'trainbr';
net4= fitnet(hiddenSizes, trainingFunction);
net4.layers{1}.transferFcn = 'radbas';
net4.layers{2}.transferFcn = 'radbas';
net4.trainParam.epochs = 500;
net4.numlayers = 3;
net4.biasConnect = [1;1;1];
net4.layerConnect = [0 0 0;1 0 0; 0 1 0];
net4.outputConnect = [0 0 1];
net4_model = train(net4,train_partition_4(:,1:6)',train_partition_4(:,7)');
predicted_Theta_4=sim(net4_model, test_partition_4(:,1:6)');
perf_4 = perform(net4_model, predicted_Theta_4 , test_partition_4(:,7)');
disp(perf_4);

thetaDifference_4 = test_partition_4(:,7)' - predicted_Theta_4;

% NN5 and IK
hiddenSizes = [30 10];
trainingFunction = 'trainbr';
net5= fitnet(hiddenSizes, trainingFunction);
net5.layers{1}.transferFcn = 'radbas';
net5.layers{2}.transferFcn = 'radbas';
net5.trainParam.epochs = 500;
net5.numlayers = 3;
net5.biasConnect = [1;1;1];
net5.layerConnect = [0 0 0;1 0 0; 0 1 0];
net5.outputConnect = [0 0 1];
net5_model = train(net5,train_partition_5(:,1:6)',train_partition_5(:,7)');
predicted_Theta_5=sim(net5_model, test_partition_5(:,1:6)');
perf_5 = perform(net5_model, predicted_Theta_5 , test_partition_5(:,7)');
disp(perf_5);

thetaDifference_5 = test_partition_5(:,7)' - predicted_Theta_5;

% NN6 and IK
hiddenSizes = [30 10];
trainingFunction = 'trainbr';
net6= fitnet(hiddenSizes, trainingFunction);
net6.layers{1}.transferFcn = 'radbas';
net6.layers{2}.transferFcn = 'radbas';
net6.trainParam.epochs = 500;
net6.numlayers = 3;
net6.biasConnect = [1;1;1];
net6.layerConnect = [0 0 0;1 0 0; 0 1 0];
net6.outputConnect = [0 0 1];
net6_model = train(net6,train_partition_6(:,1:6)',train_partition_6(:,7)');
predicted_Theta_6=sim(net6_model, test_partition_6(:,1:6)');
perf_6 = perform(net6_model, predicted_Theta_6 , test_partition_6(:,7)');
disp(perf_6);

thetaDifference_6 = test_partition_6(:,7)' - predicted_Theta_6;

% NN7 and IK
hiddenSizes = [30 10];
trainingFunction = 'trainbr';
net7= fitnet(hiddenSizes, trainingFunction);
net7.layers{1}.transferFcn = 'radbas';
net7.layers{2}.transferFcn = 'radbas';
net7.trainParam.epochs = 500;
net7.numlayers = 3;
net7.biasConnect = [1;1;1];
net7.layerConnect = [0 0 0;1 0 0; 0 1 0];
net7.outputConnect = [0 0 1];
net7_model = train(net7,train_partition_7(:,1:6)',train_partition_7(:,7)');
predicted_Theta_7=sim(net7_model, test_partition_7(:,1:6)');
perf_7 = perform(net7_model, predicted_Theta_7 , test_partition_7(:,7)');
disp(perf_7);

thetaDifference_7 = test_partition_7(:,7)' - predicted_Theta_7;

disp('8E on Type 4 is done');


%% 8E on Type 5

clear all; 
data_from_csv = readmatrix('dataset_fk_8E.csv');
theta_from_csv = readmatrix('dataset_thetas_8E.csv');


% Extracting data from FK
x = data_from_csv(:,1);
y = data_from_csv(:,2);
z = data_from_csv(:,3);
roll = data_from_csv(:,4);
pitch = data_from_csv(:,5);
yaw = data_from_csv(:,6);

 
% data = [x y z roll pitch yaw theta_1' theta_2' theta_3' theta_4' theta_5' theta_6' theta_7'];
data = [x y z roll pitch yaw theta_from_csv];
data_ = data(randperm(size(data, 1)),: );

disp('Data has been shuffled');
% Separating data into train and test
train_partition_1 = data_(1:round( size(data_,1)*5/7),1:7);
test_partition_1 = data_(round(size(data_,1)*6/7)+1:size(data_,1),1:7);

train_partition_2 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,8]);
test_partition_2 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,8]);

train_partition_3 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,9]);
test_partition_3 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,9]);

train_partition_4 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,10]);
test_partition_4 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,10]);

train_partition_5 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,11]);
test_partition_5 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,11]);

train_partition_6 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,12]);
test_partition_6 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,12]);

train_partition_7 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,13]);
test_partition_7 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,13]);
disp('Data separation done');


% NN1 and IK
hiddenSizes = [30 30];
trainingFunction = 'trainbr';
net1= fitnet(hiddenSizes, trainingFunction);
net1.layers{1}.transferFcn = 'radbas';
net1.layers{2}.transferFcn = 'radbas';
net1.trainParam.epochs = 500;
net1.numlayers = 3;
net1.biasConnect = [1;1;1];
net1.layerConnect = [0 0 0;1 0 0; 0 1 0];
net1.outputConnect = [0 0 1];
net1_model = train(net1,train_partition_1(:,1:6)',train_partition_1(:,7)');
predicted_Theta_1=sim(net1_model, test_partition_1(:,1:6)');
perf_1 = perform(net1_model, predicted_Theta_1 , test_partition_1(:,7)');
disp(perf_1);

thetaDifference_1 = test_partition_1(:,7)' - predicted_Theta_1;

% NN2 and IK
hiddenSizes = [30 30];
trainingFunction = 'trainbr';
net2= fitnet(hiddenSizes, trainingFunction);
net2.layers{1}.transferFcn = 'radbas';
net2.layers{2}.transferFcn = 'radbas';
net2.trainParam.epochs = 500;
net2.numlayers = 3;
net2.biasConnect = [1;1;1];
net2.layerConnect = [0 0 0;1 0 0; 0 1 0];
net2.outputConnect = [0 0 1];
net2_model = train(net1,train_partition_2(:,1:6)',train_partition_2(:,7)');
predicted_Theta_2=sim(net2_model, test_partition_2(:,1:6)');
perf_2 = perform(net2_model, predicted_Theta_2 , test_partition_2(:,7)');
disp(perf_2);

thetaDifference_2 = test_partition_2(:,7)' - predicted_Theta_2;

% NN3 and IK
hiddenSizes = [30 30];
trainingFunction = 'trainbr';
net3= fitnet(hiddenSizes, trainingFunction);
net3.layers{1}.transferFcn = 'radbas';
net3.layers{2}.transferFcn = 'radbas';
net3.trainParam.epochs = 500;
net3.numlayers = 3;
net3.biasConnect = [1;1;1];
net3.layerConnect = [0 0 0;1 0 0; 0 1 0];
net3.outputConnect = [0 0 1];
net3_model = train(net3,train_partition_3(:,1:6)',train_partition_3(:,7)');
predicted_Theta_3=sim(net3_model, test_partition_3(:,1:6)');
perf_3 = perform(net3_model, predicted_Theta_3 , test_partition_3(:,7)');
disp(perf_3);

thetaDifference_3 = test_partition_3(:,7)' - predicted_Theta_3;

% NN4 and IK
hiddenSizes = [30 30];
trainingFunction = 'trainbr';
net4= fitnet(hiddenSizes, trainingFunction);
net4.layers{1}.transferFcn = 'radbas';
net4.layers{2}.transferFcn = 'radbas';
net4.trainParam.epochs = 500;
net4.numlayers = 3;
net4.biasConnect = [1;1;1];
net4.layerConnect = [0 0 0;1 0 0; 0 1 0];
net4.outputConnect = [0 0 1];
net4_model = train(net4,train_partition_4(:,1:6)',train_partition_4(:,7)');
predicted_Theta_4=sim(net4_model, test_partition_4(:,1:6)');
perf_4 = perform(net4_model, predicted_Theta_4 , test_partition_4(:,7)');
disp(perf_4);

thetaDifference_4 = test_partition_4(:,7)' - predicted_Theta_4;

% NN5 and IK
hiddenSizes = [30 30];
trainingFunction = 'trainbr';
net5= fitnet(hiddenSizes, trainingFunction);
net5.layers{1}.transferFcn = 'radbas';
net5.layers{2}.transferFcn = 'radbas';
net5.trainParam.epochs = 500;
net5.numlayers = 3;
net5.biasConnect = [1;1;1];
net5.layerConnect = [0 0 0;1 0 0; 0 1 0];
net5.outputConnect = [0 0 1];
net5_model = train(net5,train_partition_5(:,1:6)',train_partition_5(:,7)');
predicted_Theta_5=sim(net5_model, test_partition_5(:,1:6)');
perf_5 = perform(net5_model, predicted_Theta_5 , test_partition_5(:,7)');
disp(perf_5);

thetaDifference_5 = test_partition_5(:,7)' - predicted_Theta_5;

% NN6 and IK
hiddenSizes = [30 30];
trainingFunction = 'trainbr';
net6= fitnet(hiddenSizes, trainingFunction);
net6.layers{1}.transferFcn = 'radbas';
net6.layers{2}.transferFcn = 'radbas';
net6.trainParam.epochs = 500;
net6.numlayers = 3;
net6.biasConnect = [1;1;1];
net6.layerConnect = [0 0 0;1 0 0; 0 1 0];
net6.outputConnect = [0 0 1];
net6_model = train(net6,train_partition_6(:,1:6)',train_partition_6(:,7)');
predicted_Theta_6=sim(net6_model, test_partition_6(:,1:6)');
perf_6 = perform(net6_model, predicted_Theta_6 , test_partition_6(:,7)');
disp(perf_6);

thetaDifference_6 = test_partition_6(:,7)' - predicted_Theta_6;

% NN7 and IK
hiddenSizes = [30 30];
trainingFunction = 'trainbr';
net7= fitnet(hiddenSizes, trainingFunction);
net7.layers{1}.transferFcn = 'radbas';
net7.layers{2}.transferFcn = 'radbas';
net7.trainParam.epochs = 500;
net7.numlayers = 3;
net7.biasConnect = [1;1;1];
net7.layerConnect = [0 0 0;1 0 0; 0 1 0];
net7.outputConnect = [0 0 1];
net7_model = train(net7,train_partition_7(:,1:6)',train_partition_7(:,7)');
predicted_Theta_7=sim(net7_model, test_partition_7(:,1:6)');
perf_7 = perform(net7_model, predicted_Theta_7 , test_partition_7(:,7)');
disp(perf_7);

thetaDifference_7 = test_partition_7(:,7)' - predicted_Theta_7;

disp('8E on Type 5 is done');
