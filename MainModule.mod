MODULE MainModule
    ! if destination_joints_angles isn't in range program stopped
    CONST num JOINT1MAX := 180;
    CONST num JOINT1MIN := -180;
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
    
    CONST num EQUAL_CONDITION := 0.5;
    
    VAR bool flag_exec := FALSE;
    VAR bool flag_stop := FALSE;
    VAR bool flag_out_of_range := FALSE;
    VAR jointtarget current_joints_angles; 
    VAR jointtarget destination_joints_angles:=[[0,0,0,-90,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    VAR jointtarget dynamic_joints_angles;
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
            
            ! Make movement mory dynamic
            IF flag_out_of_range = FALSE THEN
                dynamic_joints_angles := current_joints_angles;
                
                dynamic_joints_angles.robax.rax_1 := dynamic_joints_angles.robax.rax_1 + 
                    signum(destination_joints_angles.robax.rax_1, dynamic_joints_angles.robax.rax_1);
                dynamic_joints_angles.robax.rax_2 := dynamic_joints_angles.robax.rax_2 + 
                    signum(destination_joints_angles.robax.rax_2, dynamic_joints_angles.robax.rax_2);
                dynamic_joints_angles.robax.rax_3 := dynamic_joints_angles.robax.rax_3 + 
                    signum(destination_joints_angles.robax.rax_3, dynamic_joints_angles.robax.rax_3);
                dynamic_joints_angles.robax.rax_4 := dynamic_joints_angles.robax.rax_4 + 
                    signum(destination_joints_angles.robax.rax_4, dynamic_joints_angles.robax.rax_4);
                dynamic_joints_angles.robax.rax_5 := dynamic_joints_angles.robax.rax_5 + 
                    signum(destination_joints_angles.robax.rax_5, dynamic_joints_angles.robax.rax_5);
                dynamic_joints_angles.robax.rax_6 := dynamic_joints_angles.robax.rax_6 + 
                    signum(destination_joints_angles.robax.rax_6, dynamic_joints_angles.robax.rax_6);
                
            ENDIF
            
            IF flag_exec = TRUE AND flag_out_of_range = FALSE THEN
                ! MoveAbsJ destination_joints_angles, v200, fine, tool0;
                MoveAbsJ dynamic_joints_angles, v200, fine, tool0;
                
                current_joints_angles := CJointT();
                
                IF compare_two_joints_angles(current_joints_angles, destination_joints_angles) = TRUE THEN
                    flag_exec := FALSE;
                ENDIF
            ENDIF
        ENDWHILE
    ENDPROC
    
    FUNC num signum (num a, num b) ! Return 1 if a > b, -1 a < b, 0 a == b
        IF ABS(a-b) < EQUAL_CONDITION THEN
            RETURN 0;
        ELSEIF (a > b) THEN
            RETURN 1;
        ELSE
            RETURN -1;
        ENDIF
    ENDFUNC
    
    FUNC bool compare_two_joints_angles(jointtarget a, jointtarget b)
        IF ABS(a.robax.rax_1 - b.robax.rax_1) < EQUAL_CONDITION AND
           ABS(a.robax.rax_2 - b.robax.rax_2) < EQUAL_CONDITION AND
           ABS(a.robax.rax_3 - b.robax.rax_3) < EQUAL_CONDITION AND
           ABS(a.robax.rax_4 - b.robax.rax_4) < EQUAL_CONDITION AND
           ABS(a.robax.rax_5 - b.robax.rax_5) < EQUAL_CONDITION AND
           ABS(a.robax.rax_6 - b.robax.rax_6) < EQUAL_CONDITION THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        ENDIF
    ENDFUNC
ENDMODULE