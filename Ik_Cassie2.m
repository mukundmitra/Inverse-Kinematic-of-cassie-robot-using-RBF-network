
%% Generating dataset
clear all;
clc;

cassie = importrobot('cassie.urdf');
% showdetails(cassie);
q = struct([]);
disp('Initiating configuration setup');
%% 
for i = 1:(6^7)
    q(i,1).JointName = 'hip_abduction_left';
    q(i,2).JointName = 'hip_rotation_left';
    q(i,3).JointName = 'hip_flexion_left';
    q(i,4).JointName = 'knee_joint_left';
    q(i,5).JointName = 'knee_to_shin_left';
    q(i,6).JointName = 'ankle_joint_left';
    q(i,7).JointName = 'toe_joint_left';
    q(i,8).JointName = 'hip_abduction_right';
    q(i,9).JointName = 'hip_rotation_right';
    q(i,10).JointName = 'hip_flexion_right';
    q(i,11).JointName = 'knee_joint_right';
    q(i,12).JointName = 'knee_to_shin_right';
    q(i,13).JointName = 'ankle_joint_right';
    q(i,14).JointName = 'toe_joint_right';
end

for i = 1:(6^7)
    for j = 1:14
        q(i,j).JointPosition = 0;
    end
end

disp('Configuration initialised');

k17 = randi([5 10],1,6); %choose random, dense dataset
k2 = randi([8 15],1,6);
k34 = randi([10 20],1,6);
k56 = randi([-5,20],1,6);

disp('Constraints initialised');

l = 1;
for a = 1:6
    for b = 1:6
        for c = 1:6
            for d = 1:6
                for e = 1:6
                    for f = 1:6
                        for g = 1:6
                            
                            theta_1(l) = k17(a)*(pi/180);
                            theta_2(l) = k2(b)*(pi/180);
                            theta_3(l) = k34(c)*(pi/180);
                            theta_4(l) = k34(d)*(pi/180);
                            theta_5(l) = k56(e)*(pi/180);
                            theta_6(l) = k56(f)*(pi/180);
                            theta_7(l) = k17(g)*(pi/180);
                            
                            q(l,1).JointPosition = theta_1(l);
                            q(l,2).JointPosition = theta_2(l);
                            q(l,3).JointPosition = theta_3(l);
                            q(l,4).JointPosition = theta_4(l);
                            q(l,5).JointPosition = theta_5(l);
                            q(l,6).JointPosition = theta_6(l);
                            q(l,7).JointPosition = theta_7(l);
                                 
                            l = l+1;
                        end
                    end
                end
            end
        end
    end
end

theta = [theta_1' theta_2' theta_3' theta_4' theta_5' theta_6' theta_7'];
csvwrite('dataset_thetas2',theta);
disp('Configuration setup done');

%% Forward Kinematics
for i = 1:(6^7)
    T = getTransform(cassie,q(i,:),'left_toe');  
    P87 = [.0047;.0275;-0.0001;1];
    P81(i,:) = [T*P87]';
    position = P81(i,1:3);
    eul81(i,:) = [tform2eul(T)];
    orientation = eul81(i,1:3);
    pose_end_effector(i,:) = [position orientation];
end

csvwrite('dataset_fk2.csv',pose_end_effector);

disp('Forward kinematics done');

%% Extracting data from FK
x = pose_end_effector(:,1);
y = pose_end_effector(:,2);
z = pose_end_effector(:,3);
roll = pose_end_effector(:,4);
pitch = pose_end_effector(:,5);
yaw = pose_end_effector(:,6);
 
data = [x y z roll pitch yaw theta_1' theta_2' theta_3' theta_4' theta_5' theta_6' theta_7'];
data_ = data(randperm(size(data, 1)),: );

disp('Data has been shuffled');
%% Separating data into train and test
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

%% NN1 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net1= fitnet(hiddenSizes, trainingFunction);
net1.layers{1}.transferFcn = 'radbas';
net1.trainParam.epochs = 500;
net1.numlayers = 2;
net1.layerConnect = [0 0;1 0];
net1.outputConnect = [0 1];
net1_model = train(net1,train_partition_1(:,1:6)',train_partition_1(:,7)');
predicted_Theta_1=sim(net1_model, test_partition_1(:,1:6)');
perf_1 = perform(net1_model, predicted_Theta_1 , test_partition_1(:,7)');
disp(perf_1);

thetaDifference_1 = test_partition_1(:,7)' - predicted_Theta_1;

figure()
subplot(7,1,1);
plot(thetaDifference_1);
ylim([-0.2 0.2])
ylabel(['Theta 1 Error']);
title('Desired theta1 - Predicted theta1 (in degrees)');
hold on

%% NN2 and IK
hiddenSizes = 20;
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

subplot(7,1,2);
plot(thetaDifference_2);
ylim([-0.2 0.2])
ylabel(['Theta 2 Error']);
title('Desired theta2 - Predicted theta2 (in degrees)');
hold on

%% NN3 and IK
hiddenSizes = 40;
trainingFunction = 'trainbr';
net3= fitnet(hiddenSizes, trainingFunction);
net3.layers{1}.transferFcn = 'radbas';
net3.trainParam.epochs = 1000;
net3.numlayers = 2;
net3.layerConnect = [0 0;1 0];
net3.outputConnect = [0 1];
net3_model = train(net3,train_partition_3(:,1:6)',train_partition_3(:,7)');
predicted_Theta_3=sim(net3_model, test_partition_3(:,1:6)');
perf_3 = perform(net3_model, predicted_Theta_3 , test_partition_3(:,7)');
disp(perf_3);

thetaDifference_3 = test_partition_3(:,7)' - predicted_Theta_3;

subplot(7,1,3);
plot(thetaDifference_3);
ylim([-1 1])
ylabel(['Theta 3 Error']);
title('Desired theta3 - Predicted theta3 (in degrees)');
hold on

%% NN4 and IK
hiddenSizes = 30;
trainingFunction = 'trainbr';
net4= fitnet(hiddenSizes, trainingFunction);
net4.layers{1}.transferFcn = 'radbas';
net4.trainParam.epochs = 2000;
net4.numlayers = 2;
net4.layerConnect = [0 0;1 0];
net4.outputConnect = [0 1];
net4_model = train(net4,train_partition_4(:,1:6)',train_partition_4(:,7)');
predicted_Theta_4=sim(net4_model, test_partition_4(:,1:6)');
perf_4 = perform(net4_model, predicted_Theta_4 , test_partition_4(:,7)');
disp(perf_4);

thetaDifference_4 = test_partition_4(:,7)' - predicted_Theta_4;

subplot(7,1,4);
plot(thetaDifference_4);
ylim([-1 1])
ylabel(['Theta 4 Error']);
title('Desired theta4 - Predicted theta4 (in degrees)');
hold on

%% NN5 and IK
hiddenSizes = 40;
trainingFunction = 'trainbr';
net5= fitnet(hiddenSizes, trainingFunction);
net5.layers{1}.transferFcn = 'radbas';
net5.trainParam.epochs = 2000;
net5.numlayers = 2;
net5.layerConnect = [0 0;1 0];
net5.outputConnect = [0 1];
net5_model = train(net5,train_partition_5(:,1:6)',train_partition_5(:,7)');
predicted_Theta_5=sim(net5_model, test_partition_5(:,1:6)');
perf_5 = perform(net5_model, predicted_Theta_5 , test_partition_5(:,7)');
disp(perf_5);

thetaDifference_5 = test_partition_5(:,7)' - predicted_Theta_5;

subplot(7,1,5);
plot(thetaDifference_5);
ylim([-0.5 0.5])
ylabel(['Theta 5 Error']);
title('Desired theta5 - Predicted theta5 (in degrees)');
hold on

%% NN6 and IK
hiddenSizes = 20;
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

subplot(7,1,6);
plot(thetaDifference_6);
ylim([-0.2 0.2])
ylabel(['Theta 6 Error']);
title('Desired theta6 - Predicted theta6 (in degrees)');
hold on

%% NN7 and IK
hiddenSizes = 20;
trainingFunction = 'trainbr';
net7= fitnet(hiddenSizes, trainingFunction);
net7.layers{1}.transferFcn = 'radbas';
net7.trainParam.epochs = 2000;
net7.numlayers = 2;
net7.layerConnect = [0 0;1 0];
net7.outputConnect = [0 1];
net7_model = train(net7,train_partition_7(:,1:6)',train_partition_7(:,7)');
predicted_Theta_7=sim(net7_model, test_partition_7(:,1:6)');
perf_7 = perform(net7_model, predicted_Theta_7 , test_partition_7(:,7)');
disp(perf_7);

thetaDifference_7 = test_partition_7(:,7)' - predicted_Theta_7;

subplot(7,1,7);
plot(thetaDifference_7);
ylim([-0.2 0.2])
ylabel(['Theta 7 Error']);
title('Desired theta7 - Predicted theta7 (in degrees)');
hold off

%% visual comparison

visual_data_baseline = data_(round(size(data_,1)*6/7)+1:size(data_,1),7:13);
visual_data_calculated = [predicted_Theta_1' predicted_Theta_2' predicted_Theta_3' predicted_Theta_4' predicted_Theta_5' predicted_Theta_6' predicted_Theta_7'];

baseline_config = q;
calculated_config = q;

for i = 1:11161
    for j = 1:7
        baseline_config(i,j).JointPosition = visual_data_baseline(i,j);
        calculated_config(i,j).JointPosition = visual_data_calculated(i,j); 
    end
end

figure()

for i = 1:11161
    subplot(1,2,1);
    show(cassie,baseline_config(i,:));
    subplot(1,2,2);
    show(cassie,calculated_config(i,:));
    pause(0.1);
end

hold off

