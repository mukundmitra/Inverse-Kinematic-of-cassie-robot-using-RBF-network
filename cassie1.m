cassie = importrobot('cassie.urdf');
showdetails(cassie);
% show(cassie);
q = struct([]);

for i = 1:(3^7)
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

for i = 1:(3^7)
    for j = 1:14
        q(i,j).JointPosition = 0;
    end
end

l = 1;
deg = pi/180;

for a = 1:5:11
    q(l,1).JointPosition = (a-1)*deg;
    q(l,8).JointPosition = (a-1)*deg;
    for b = 1:5:11
        q(l,2).JointPosition = (b-1)*deg;
        q(l,9).JointPosition = (b-1)*deg;
        for c = 1:5:11
            q(l,3).JointPosition = (c-1)*deg;
            q(l,10).JointPosition = (c-1)*deg;
            for d = 1:5:11
                q(l,4).JointPosition = (d-1)*deg;
                q(l,11).JointPosition = (d-1)*deg;
                for e = 1:5:11
                    q(l,5).JointPosition = (e-1)*deg;
                    q(l,12).JointPosition = (e-1)*deg;
                    for f = 1:5:11
                        q(l,6).JointPosition = (f-1)*deg;
                         q(l,13).JointPosition = (f-1)*deg;
                        for g = 1:5:11
                            q(l,7).JointPosition = (g-1)*deg;
                            q(l,14).JointPosition = (g-1)*deg;
                            l = l+1;
                        end
                    end
                end
            end
        end
    end                           
end

for i = 1:(3^7)
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

 csvwrite('dataset1.csv',pose_end_effector);


% j1  j2  j3  j4  j5  j6  j7 
% 0   0   0   0   0   0   0
% 0   0   0   0   0   0   5
% 0   0   0   0   0   0   10
% 0   0   0   0   0   5   0
% 0   0   0   0   0   5   5
% 0   0   0   0   0   5   10  
% 0   0   0   0   0   10  0
% 0   0   0   0   0   10  5
% 0   0   0   0   0   10  10







