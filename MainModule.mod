MODULE MainModule
    VAR bool flag_exec := FALSE;
    VAR bool flag_stop := FALSE;
    VAR jointtarget current_joints_angles; 
    VAR jointtarget destination_joints_angles:=[[0,0,0,-90,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    PROC main()
        current_joints_angles := CJointT();
        WHILE flag_stop = FALSE DO
            IF flag_exec = TRUE THEN
                MoveAbsJ destination_joints_angles, v200, fine, tool0;
                flag_exec := FALSE;
                current_joints_angles := CJointT();
            ENDIF
        ENDWHILE
    ENDPROC
ENDMODULE