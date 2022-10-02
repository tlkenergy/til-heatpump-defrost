within TIL_HeatPumpDefrost.Controls.Interfaces;
expandable connector Sensors


  SI.Pressure p_evap "Evaporator pressure";
  SI.Pressure p_cond "Condenser pressure";
  SI.HeatFlowRate Qdot_cond "Condenser heat flow rate";
  SI.TemperatureDifference subcooling "Subcooling after condenser";
  SI.Power P_comp "Compressor power";
  SI.Temperature T_air "Air inlet temperature";
  SI.Temperature T_evap "Evaporation temperature";
  Real fillingLevelSeparator;
  Real COP;
  Real TliqOutlet_degC;
  Real TairOutlet_degC;
  Real m_flow_air;
  Real mass_ice;

  // StatePoints
  SI.Pressure p0;
  SI.SpecificEnthalpy h0;
  SI.Pressure p1;
  SI.SpecificEnthalpy h1;
  SI.Pressure p2;
  SI.SpecificEnthalpy h2;
  SI.Pressure p3;
  SI.SpecificEnthalpy h3;
  SI.Pressure p4;
  SI.SpecificEnthalpy h4;


  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end Sensors;
