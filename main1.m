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


k = linspace(-20,40,180);
l = 1;
for i = 1:180
    for j = 1:180
        q(l,5).JointPosition = k(i)*(pi/180);
        q(l,6).JointPosition = k(j)*(pi/180);  
        l = l+1;
    end
end

k = linspace(-20,40,180);
l = 1;
for i = 1:180
    for j = 1:180
        theta_5(l) = k(i)*(pi/180);
        theta_6(l) = k(j)*(pi/180);  
        l = l+1;
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
 
data = [x y z roll pitch yaw theta_5' theta_6'];
data_ = data(randperm(size(data, 1)),: );


%% partitioning data into train, check and test
train_partition_5 = data_(1:round( size(data_,1)*5/7),1:7);
check_partition_5 = data_(round(size(data_,1)*5/7)+1:round(size(data_,1)*6/7),1:7);
test_partition_5 = data_(round(size(data_,1)*6/7)+1:size(data_,1),1:7);


%% creating a NN and performing IK
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

figure()
subplot(3,1,1);
plot(thetaDifference_5);
ylabel(['Theta 5 Error']);
title('Desired theta5 - Predicted theta5 (in degrees)');
