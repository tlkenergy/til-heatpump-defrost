within TIL_HeatPumpDefrost.Examples;
model QdotDefrost
  extends TIL.Internals.ClassTypes.ExampleModel;
  // components
  Cycles.HeatPumpCycle_Propane heatPumpCycle_Propane_FMU
    annotation (Placement(transformation(extent={{12,28},{50,52}})));
  Modelica.Blocks.Sources.Constant TairIn(k=7)
    annotation (Placement(transformation(extent={{2,4},{14,16}})));
  Modelica.Blocks.Sources.Constant phiAir(k=70)
    annotation (Placement(transformation(extent={{2,-14},{14,-2}})));
  Modelica.Blocks.Sources.Constant VflowLiq(k=15/60000)
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Blocks.Sources.Constant TliqIn(k=30)
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));

  // Outputs
  output Modelica.Units.SI.Pressure pHigh = heatPumpCycle_Propane_FMU.pHigh;
  output Modelica.Units.SI.Pressure pLow = heatPumpCycle_Propane_FMU.pLow;
  output Modelica.Units.SI.HeatFlowRate Qflow_cond = heatPumpCycle_Propane_FMU.Qflow_cond;
  output Modelica.Units.SI.HeatFlowRate Qflow_evap = heatPumpCycle_Propane_FMU.Qflow_evap;
  output Modelica.Units.SI.Power Pshaft_comp = heatPumpCycle_Propane_FMU.Pshaft_comp;
  output Real COP = heatPumpCycle_Propane_FMU.COP;
  output Modelica.Units.SI.MassFlowRate mflow_refrigerant = heatPumpCycle_Propane_FMU.mflow_refrigerant;
  output Modelica.Units.SI.VolumeFlowRate Vflow_liq = heatPumpCycle_Propane_FMU.Vflow_liq;
  output Modelica.Units.SI.MassFlowRate mflow_liq = heatPumpCycle_Propane_FMU.mflow_liq;
  output Modelica.Units.NonSI.Temperature_degC T_degC_liq_in = heatPumpCycle_Propane_FMU.T_degC_liq_in;
  output Modelica.Units.NonSI.Temperature_degC T_degC_liq_out = heatPumpCycle_Propane_FMU.T_degC_liq_out;
  output Modelica.Units.SI.VolumeFlowRate Vflow_air = heatPumpCycle_Propane_FMU.Vflow_air;
  output Modelica.Units.SI.MassFlowRate mflow_air = heatPumpCycle_Propane_FMU.mflow_air;
  output Modelica.Units.NonSI.Temperature_degC T_degC_air_in = heatPumpCycle_Propane_FMU.T_degC_air_in;
  output Modelica.Units.NonSI.Temperature_degC T_degC_air_out = heatPumpCycle_Propane_FMU.T_degC_air_out;
  output Modelica.Units.SI.TemperatureDifference dT_sc = heatPumpCycle_Propane_FMU.dT_sc;
  output Modelica.Units.SI.TemperatureDifference dT_sh = heatPumpCycle_Propane_FMU.dT_sh;
  output Real fillingLevelSeparator = heatPumpCycle_Propane_FMU.fillingLevelSeparator;
  output Modelica.Units.SI.Mass mass_ice = heatPumpCycle_Propane_FMU.mass_ice;

  Modelica.Blocks.Sources.RealExpression dT_sc_meas(y=heatPumpCycle_Propane_FMU.dT_sc)
    annotation (Placement(transformation(extent={{-104,-36},{-84,-16}})));
  Modelica.Blocks.Sources.Constant
                               dT_sc_setpoint(k=0.4)
    annotation (Placement(transformation(extent={{-140,-28},{-120,-8}})));
  Controls.QdotDefrost        heatPumpController
    annotation (Placement(transformation(extent={{82,-36},{102,-16}})));
equation
  connect(TairIn.y, heatPumpCycle_Propane_FMU.TairInlet_degC)
    annotation (Line(points={{14.6,10},{20,10},{20,26.4}}, color={0,0,127}));
  connect(phiAir.y, heatPumpCycle_Propane_FMU.phiAirInlet)
    annotation (Line(points={{14.6,-8},{24,-8},{24,26.4}},  color={0,0,127}));
  connect(VflowLiq.y, heatPumpCycle_Propane_FMU.VflowLiq) annotation (Line(
        points={{-29,100},{0,100},{0,50},{10.6,50}}, color={0,0,127}));
  connect(TliqIn.y, heatPumpCycle_Propane_FMU.TliqInlet_degC)
    annotation (Line(points={{-29,60},{-10,60},{-10,46},{10.6,46}}, color={0,0,127}));
  connect(heatPumpCycle_Propane_FMU.sensors, heatPumpController.sensors)
    annotation (Line(points={{50,34},{72,34},{72,-26},{82,-26}}, color={0,0,0}));
  connect(heatPumpController.actuators, heatPumpCycle_Propane_FMU.actuators) annotation (
      Line(points={{102,-26},{124,-26},{124,-76},{-62,-76},{-62,34},{12.2,34}}, color={0,0,
          0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -120},{160,120}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-120},{160,
            120}})),
    experiment(
      StopTime=10000,
      Tolerance=1e-05,
      __Dymola_Algorithm="Cvode"));
end QdotDefrost;
