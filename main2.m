%% generating dataset by FK
cassie = importrobot('cassie.urdf');
showdetails(cassie);
q = struct([]);

for i = 1:(180^2)
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

for i = 1:(180^2)
    for j = 1:14
        q(i,j).JointPosition = 0;
    end
end


k17 = linspace(5,15,180);
k2 = linspace(8,20,180);
k34 = linspace(10,30,180);
k56 = linspace(-20,40,180);

l = 1;
for a = 1:180
    for b = 1:180
        for c = 1:180
            for d = 1:180
                for e = 1:180
                    for f = 1:180
                        for g = 1:180
                            q(l,1).JointPosition = k17(a)*(pi/180);
                            q(l,2).JointPosition = k2(b)*(pi/180);
                            q(l,3).JointPosition = k34(c)*(pi/180);
                            q(l,4).JointPosition = k34(d)*(pi/180);
                            q(l,5).JointPosition = k56(e)*(pi/180);
                            q(l,6).JointPosition = k56(f)*(pi/180);
                            q(l,7).JointPosition = k17(g)*(pi/180);
                            l = l+1;
                        end
                    end
                end
            end
        end
    end
end


for a = 1:180
    for b = 1:180
        for c = 1:180
            for d = 1:180
                for e = 1:180
                    for f = 1:180
                        for g = 1:180
                            theta_1(l) = k17(a)*(pi/180);
                            theta_2(l) = k2(b)*(pi/180);
                            theta_3(l) = k34(c)*(pi/180);
                            theta_4(l) = k34(d)*(pi/180);
                            theta_5(l) = k56(e)*(pi/180);
                            theta_6(l) = k56(f)*(pi/180);
                            theta_7(l) = k17(g)*(pi/180);
                            l = l+1;
                        end
                    end
                end
            end
        end
    end
end


for i = 1:(180^2)
    T = getTransform(cassie,q(i,:),'left_toe');  
    P87 = [.0047;.0275;-0.0001;1];
    P81(i,:) = [T*P87]';
    position = P81(i,1:3);
    eul81(i,:) = [tform2eul(T)];
    orientation = eul81(i,1:3);
    pose_end_effector(i,:) = [position orientation];
end

csvwrite('dataset3.csv',pose_end_effector);

%% strong data in matrix form
x = pose_end_effector(:,1);
y = pose_end_effector(:,2);
z = pose_end_effector(:,3);
roll = pose_end_effector(:,4);
pitch = pose_end_effector(:,5);
yaw = pose_end_effector(:,6);
 
data = [x y z roll pitch yaw theta_1' theta_2' theta_3' theta_4' theta_5' theta_6' theta_7'];
data_ = data(randperm(size(data, 1)),: );


%% partitioning data into train, check and test
train_partition_1 = data_(1:round( size(data_,1)*5/7),1:7);
check_partition_1 = data_(round(size(data_,1)*5/7)+1:round(size(data_,1)*6/7),1:7);
test_partition_1 = data_(round(size(data_,1)*6/7)+1:size(data_,1),1:7);

train_partition_2 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,8]);
check_partition_2 = data_(round(size(data_,1)*5/7)+1:round(size(data_,1)*6/7),[1,2,3,4,5,6,8]);
test_partition_2 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,8]);

train_partition_3 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,9]);
check_partition_3 = data_(round(size(data_,1)*5/7)+1:round(size(data_,1)*6/7),[1,2,3,4,5,6,9]);
test_partition_3 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,9]);

train_partition_4 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,10]);
check_partition_4 = data_(round(size(data_,1)*5/7)+1:round(size(data_,1)*6/7),[1,2,3,4,5,6,10]);
test_partition_4 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,10]);

train_partition_5 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,11]);
check_partition_5 = data_(round(size(data_,1)*5/7)+1:round(size(data_,1)*6/7),[1,2,3,4,5,6,11]);
test_partition_5 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,11]);

train_partition_6 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,12]);
check_partition_6 = data_(round(size(data_,1)*5/7)+1:round(size(data_,1)*6/7),[1,2,3,4,5,6,12]);
test_partition_6 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,12]);

train_partition_7 = data_(1:round( size(data_,1)*5/7),[1,2,3,4,5,6,13]);
check_partition_7 = data_(round(size(data_,1)*5/7)+1:round(size(data_,1)*6/7),[1,2,3,4,5,6,13]);
test_partition_7 = data_(round(size(data_,1)*6/7)+1:size(data_,1),[1,2,3,4,5,6,13]);


%% creating a NN1 and performing IK
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
ylabel(['Theta 1 Error']);
title('Desired theta1 - Predicted theta1 (in degrees)');

%% creating a NN2 and performing IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net2= fitnet(hiddenSizes, trainingFunction);
net2.layers{1}.transferFcn = 'radbas';
net2.trainParam.epochs = 500;
net2.numlayers = 2;
net2.layerConnect = [0 0;1 0];
net2.outputConnect = [0 1];
net2_model = train(net2,train_partition_2(:,1:6)',train_partition_2(:,8)');
predicted_Theta_2=sim(net2_model, test_partition_2(:,1:6)');
perf_2 = perform(net2_model, predicted_Theta_2 , test_partition_2(:,8)');
disp(perf_2);

thetaDifference_2 = test_partition_2(:,8)' - predicted_Theta_2;

figure()
subplot(7,1,2);
plot(thetaDifference_2);
ylabel(['Theta 2 Error']);
title('Desired theta2 - Predicted theta2 (in degrees)');

%% creating a NN3 and performing IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net3= fitnet(hiddenSizes, trainingFunction);
net3.layers{1}.transferFcn = 'radbas';
net3.trainParam.epochs = 500;
net3.numlayers = 2;
net3.layerConnect = [0 0;1 0];
net3.outputConnect = [0 1];
net3_model = train(net3,train_partition_3(:,1:6)',train_partition_3(:,9)');
predicted_Theta_3=sim(net3_model, test_partition_3(:,1:6)');
perf_3 = perform(net3_model, predicted_Theta_3 , test_partition_3(:,9)');
disp(perf_3);

thetaDifference_3 = test_partition_3(:,9)' - predicted_Theta_3;

figure()
subplot(7,1,3);
plot(thetaDifference_3);
ylabel(['Theta 3 Error']);
title('Desired theta3 - Predicted theta3 (in degrees)');

%% creating a NN4 and performing IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net4= fitnet(hiddenSizes, trainingFunction);
net4.layers{1}.transferFcn = 'radbas';
net4.trainParam.epochs = 500;
net4.numlayers = 2;
net4.layerConnect = [0 0;1 0];
net4.outputConnect = [0 1];
net4_model = train(net4,train_partition_4(:,1:6)',train_partition_4(:,10)');
predicted_Theta_4=sim(net4_model, test_partition_4(:,1:6)');
perf_4 = perform(net4_model, predicted_Theta_4 , test_partition_4(:,10)');
disp(perf_4);

thetaDifference_4 = test_partition_4(:,10)' - predicted_Theta_4;

figure()
subplot(7,1,4);
plot(thetaDifference_4);
ylabel(['Theta 4 Error']);
title('Desired theta4 - Predicted theta4 (in degrees)');

%% creating a NN5 and performing IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net5= fitnet(hiddenSizes, trainingFunction);
net5.layers{1}.transferFcn = 'radbas';
net5.trainParam.epochs = 500;
net5.numlayers = 2;
net5.layerConnect = [0 0;1 0];
net5.outputConnect = [0 1];
net5_model = train(net5,train_partition_5(:,1:6)',train_partition_5(:,11)');
predicted_Theta_5=sim(net5_model, test_partition_5(:,1:6)');
perf_5 = perform(net5_model, predicted_Theta_5 , test_partition_5(:,11)');
disp(perf_5);

thetaDifference_5 = test_partition_5(:,11)' - predicted_Theta_5;

figure()
subplot(7,1,5);
plot(thetaDifference_5);
ylabel(['Theta 5 Error']);
title('Desired theta5 - Predicted theta5 (in degrees)');

%% creating a NN6 and performing IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net6= fitnet(hiddenSizes, trainingFunction);
net6.layers{1}.transferFcn = 'radbas';
net6.trainParam.epochs = 500;
net6.numlayers = 2;
net6.layerConnect = [0 0;1 0];
net6.outputConnect = [0 1];
net6_model = train(net6,train_partition_6(:,1:6)',train_partition_6(:,12)');
predicted_Theta_6=sim(net6_model, test_partition_6(:,1:6)');
perf_6 = perform(net6_model, predicted_Theta_6 , test_partition_6(:,12)');
disp(perf_6);

thetaDifference_6 = test_partition_6(:,12)' - predicted_Theta_6;

figure()
subplot(7,1,6);
plot(thetaDifference_6);
ylabel(['Theta 6 Error']);
title('Desired theta6 - Predicted theta6 (in degrees)');

%% creating a NN7 and performing IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net7= fitnet(hiddenSizes, trainingFunction);
net7.layers{1}.transferFcn = 'radbas';
net7.trainParam.epochs = 500;
net7.numlayers = 2;
net7.layerConnect = [0 0;1 0];
net7.outputConnect = [0 1];
net7_model = train(net7,train_partition_7(:,1:6)',train_partition_7(:,13)');
predicted_Theta_7=sim(net7_model, test_partition_7(:,1:6)');
perf_7 = perform(net7_model, predicted_Theta_7 , test_partition_7(:,13)');
disp(perf_7);

thetaDifference_7 = test_partition_7(:,13)' - predicted_Theta_7;

figure()
subplot(7,1,7);
plot(thetaDifference_7);
ylabel(['Theta 7 Error']);
title('Desired theta7 - Predicted theta7 (in degrees)');
