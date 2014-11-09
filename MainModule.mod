MODULE MainModule
    ! if destination_joints_angles isn't in range program stopped
    CONST num JOINT1MAX := 20;
    CONST num JOINT1MIN := -20;
    CONST num JOINT2MAX := 180;
    CONST num JOINT2MIN := -180;
    CONST num JOINT3MAX := 180;
    CONST num JOINT3MIN := -180;
    CONST num JOINT4MAX := 180;
    CONST num JOINT4MIN := -180;
    CONST num JOINT5MAX := 180;
    CONST num JOINT5MIN := -180;
    CONST num JOINT6MAX := 180;
    CONST num JOINT6MIN := -180;
    
    VAR bool flag_exec := FALSE;
    VAR bool flag_stop := FALSE;
    VAR bool flag_out_of_range := FALSE;
    VAR jointtarget current_joints_angles; 
    VAR jointtarget destination_joints_angles:=[[0,0,0,-90,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    PROC main()
        current_joints_angles := CJointT();
        
        WHILE flag_stop = FALSE AND flag_out_of_range = FALSE DO
            
            ! Check if data is in range
            IF destination_joints_angles.robax.rax_1 > JOINT1MAX OR destination_joints_angles.robax.rax_1 < JOINT1MIN OR
            destination_joints_angles.robax.rax_2 > JOINT2MAX OR destination_joints_angles.robax.rax_2 < JOINT2MIN OR
            destination_joints_angles.robax.rax_3 > JOINT3MAX OR destination_joints_angles.robax.rax_3 < JOINT3MIN OR
            destination_joints_angles.robax.rax_4 > JOINT4MAX OR destination_joints_angles.robax.rax_4 < JOINT4MIN OR
            destination_joints_angles.robax.rax_5 > JOINT5MAX OR destination_joints_angles.robax.rax_5 < JOINT5MIN OR
            destination_joints_angles.robax.rax_6 > JOINT6MAX OR destination_joints_angles.robax.rax_6 < JOINT6MIN THEN
                flag_out_of_range := TRUE;
            ENDIF
            
            IF flag_exec = TRUE AND flag_out_of_range = FALSE THEN
                MoveAbsJ destination_joints_angles, v200, fine, tool0;
                flag_exec := FALSE;
                current_joints_angles := CJointT();
            ENDIF
        ENDWHILE
    ENDPROC
ENDMODULE