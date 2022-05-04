%% Input Values
x_pose = input('Input x coordinate:');
y_pose = input('Input y coordinate:');
z_pose = input('Input z coordinate:');
roll_pose = input('Input Roll:');
pitch_pose = input('Input pitch:');
yaw_pose = input('Input yaw:');

test_data = [x_pose y_pose z_pose roll_pose pitch_pose yaw_pose];
disp('test data stored')


%% Generating dataset
cassie = importrobot('cassie.urdf');
% showdetails(cassie);
q = struct([]);
disp('Initiating configuration setup');

for i = 1:(5^7)
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

for i = 1:(5^7)
    for j = 1:14
        q(i,j).JointPosition = 0;
    end
end

disp('Configuration initialised');

k17 = linspace(5,15,5);
k2 = linspace(8,20,5);
k34 = linspace(10,30,5);
k56 = linspace(-20,40,5);

disp('Constraints initialised');

l = 1;
for a = 1:5
    for b = 1:5
        for c = 1:5
            for d = 1:5
                for e = 1:5
                    for f = 1:5
                        for g = 1:5
                            
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

disp('Configuration setup done');

%% Forward Kinematics
for i = 1:(5^7)
    T = getTransform(cassie,q(i,:),'left_toe');  
    P87 = [.0047;.0275;-0.0001;1];
    P81(i,:) = [T*P87]';
    position = P81(i,1:3);
    eul81(i,:) = [tform2eul(T)];
    orientation = eul81(i,1:3);
    pose_end_effector(i,:) = [position orientation];
end

csvwrite('dataset4.csv',pose_end_effector);

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
%% Separating data into train, check and test
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
disp('Data separation done');




%% NN1 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net1= fitnet(hiddenSizes, trainingFunction);
net1.layers{1}.transferFcn = 'radbas';
net1.trainParam.epochs = 100;
net1.numlayers = 2;
net1.layerConnect = [0 0;1 0];
net1.outputConnect = [0 1];
net1_model = train(net1,train_partition_1(:,1:6)',train_partition_1(:,7)');
predicted_Theta_1=sim(net1_model,test_data');
fprintf('Theta_1 = %d',predicted_Theta_1);


%% NN2 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net2= fitnet(hiddenSizes, trainingFunction);
net2.layers{1}.transferFcn = 'radbas';
net2.trainParam.epochs = 100;
net2.numlayers = 2;
net2.layerConnect = [0 0;1 0];
net2.outputConnect = [0 1];
net2_model = train(net1,train_partition_2(:,1:6)',train_partition_2(:,7)');
predicted_Theta_2=sim(net2_model,test_data');
fprintf('Theta_2 = %d',predicted_Theta_2);


%% NN3 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net3= fitnet(hiddenSizes, trainingFunction);
net3.layers{1}.transferFcn = 'radbas';
net3.trainParam.epochs = 100;
net3.numlayers = 2;
net3.layerConnect = [0 0;1 0];
net3.outputConnect = [0 1];
net3_model = train(net3,train_partition_3(:,1:6)',train_partition_3(:,7)');
predicted_Theta_3=sim(net3_model,test_data');
fprintf('Theta_3 = %d',predicted_Theta_3);


%% NN4 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net4= fitnet(hiddenSizes, trainingFunction);
net4.layers{1}.transferFcn = 'radbas';
net4.trainParam.epochs = 100;
net4.numlayers = 2;
net4.layerConnect = [0 0;1 0];
net4.outputConnect = [0 1];
net4_model = train(net4,train_partition_4(:,1:6)',train_partition_4(:,7)');
predicted_Theta_4=sim(net4_model, test_data');
fprintf('Theta_4 = %d',predicted_Theta_4);



%% NN5 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net5= fitnet(hiddenSizes, trainingFunction);
net5.layers{1}.transferFcn = 'radbas';
net5.trainParam.epochs = 100;
net5.numlayers = 2;
net5.layerConnect = [0 0;1 0];
net5.outputConnect = [0 1];
net5_model = train(net5,train_partition_5(:,1:6)',train_partition_5(:,7)');
predicted_Theta_5=sim(net5_model,test_data');
fprintf('Theta_5 = %d',predicted_Theta_5);



%% NN6 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net6= fitnet(hiddenSizes, trainingFunction);
net6.layers{1}.transferFcn = 'radbas';
net6.trainParam.epochs = 100;
net6.numlayers = 2;
net6.layerConnect = [0 0;1 0];
net6.outputConnect = [0 1];
net6_model = train(net6,train_partition_6(:,1:6)',train_partition_6(:,7)');
predicted_Theta_6=sim(net6_model,test_data');
fprintf('Theta_6 = %d',predicted_Theta_6);




%% NN7 and IK
hiddenSizes = 10;
trainingFunction = 'trainbr';
net7= fitnet(hiddenSizes, trainingFunction);
net7.layers{1}.transferFcn = 'radbas';
net7.trainParam.epochs = 100;
net7.numlayers = 2;
net7.layerConnect = [0 0;1 0];
net7.outputConnect = [0 1];
net7_model = train(net7,train_partition_7(:,1:6)',train_partition_7(:,7)');
predicted_Theta_7=sim(net7_model,test_data');
fprintf('Theta_7 = %d',predicted_Theta_7);

%% Check for Singularity
if (predicted_Theta_1 < max(theta_1) || predicted_Theta_1 > min(theta_1))
    if (predicted_Theta_2 < max(theta_2) || predicted_Theta_2 > min(theta_2))
        if (predicted_Theta_3 < max(theta_3) || predicted_Theta_3 > min(theta_3))
            if (predicted_Theta_4 < max(theta_4) || predicted_Theta_4 > min(theta_4))
                if (predicted_Theta_5 < max(theta_5) || predicted_Theta_5 > min(theta_5))
                    if (predicted_Theta_6 < max(theta_6) || predicted_Theta_6 > min(theta_6))
                        if (predicted_Theta_7 < max(theta_7) || predicted_Theta_7 > min(theta_7))
                            disp('Configuration Reached')
                        else
                            disp('Singular Configuration')
                        end
                    else
                        disp('Singular Configuration')
                    end
                else
                    disp('Singular Configuration')
                end
            else
                disp('Singular Configuration')
            end
        else
            disp('Singular Configuration')
        end
    else
        disp('Singular Configuration')
    end
else
    disp('Singular Configuration')
end


%% visual comparison

visual_data_calculated = [predicted_Theta_1' predicted_Theta_2' predicted_Theta_3' predicted_Theta_4' predicted_Theta_5' predicted_Theta_6' predicted_Theta_7'];

calculated_config = q;


for j = 1:7
     calculated_config(1,j).JointPosition = visual_data_calculated(1,j); 
end

figure()
show(cassie,calculated_config(i,:));
hold off

