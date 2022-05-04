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


k = linspace(-90,90,180);
l = 1;
for i = 1:180
    q(l,5).JointPosition = k(i)*(pi/180);
    for j = 1:180
      q(l,6).JointPosition = k(j)*(pi/180);  
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