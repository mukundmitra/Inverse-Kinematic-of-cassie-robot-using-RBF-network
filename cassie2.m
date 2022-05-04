cassie = importrobot('cassie.urdf');
showdetails(cassie);
% show(cassie);
q = struct([]);

for i = 1:1000
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

for i = 1:1000
    for j = 1:14
        q(i,j).JointPosition = 0;
    end
end


k = 0;
for i = 1:1000
    for j = 1:7
        q(i,j).JointPosition = k*(pi/180);
        k = k+1;
    end
end

for i = 1:1000
    T21 = getTransform(cassie,q(i,:),'left_pelvis_abduction','left_pelvis_rotation');
    T32 = getTransform(cassie,q(i,:),'left_pelvis_rotation','left_hip');
    T43 = getTransform(cassie,q(i,:),'left_hip','left_thigh');
    T54 = getTransform(cassie,q(i,:),'left_thigh','left_knee');
    T65 = getTransform(cassie,q(i,:),'left_knee','left_shin');
    T76 = getTransform(cassie,q(i,:),'left_shin','left_tarsus');
    T87 = getTransform(cassie,q(i,:),'left_tarsus','left_toe');

    T81 = T21*T32*T43*T54*T65*T76*T87;
    
    P87 = [.0047;.0275;-0.0001;1];
    P81(i,:) = [T81*P87]';
    position = P81(i,1:3);
    eul81(i,:) = [tform2eul(T81,'XYZ')];
    orientation = eul81(i,1:3);
    pose_end_effector(i,:) = [position orientation];
end

 csvwrite('dataset2.csv',pose_end_effector);
