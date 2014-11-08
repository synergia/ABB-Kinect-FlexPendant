MODULE JointTargets
    CONST jointtarget BasePositionTarget:=[[0,0,0,-90,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    PROC BasePositionPath()
        MoveAbsJ BasePositionTarget,v1000,z100,tool0\WObj:=wobj0;
    ENDPROC
ENDMODULE