within TIL_HeatPumpDefrost.Controls.Interfaces;
expandable connector Sensors


  SI.Pressure p_evap "Evaporator pressure";
  SI.Pressure p_cond "Condenser pressure";
  SI.HeatFlowRate Qdot_cond "Condenser heat flow rate";
  SI.TemperatureDifference subcooling "Subcooling after condenser";
  SI.Power P_comp "Compressor power";
  SI.Temperature T_air "Air inlet temperature";
  SI.Temperature T_evap "Evaporation temperature";


  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end Sensors;
