within TIL_HeatPumpDefrost.Examples;
model TimeBasedDefrost
  extends TIL.Internals.ClassTypes.ExampleModel;
  // components
  Cycles.HeatPumpCycle_Propane heatPumpCycle_Propane_FMU
    annotation (Placement(transformation(extent={{6,-36},{44,-12}})));
  Modelica.Blocks.Sources.Constant TairIn(k=7.1)
    annotation (Placement(transformation(extent={{-138,26},{-126,38}})));
  Modelica.Blocks.Sources.Constant phiAir(k=70)
    annotation (Placement(transformation(extent={{-138,46},{-126,58}})));
  Modelica.Blocks.Sources.Constant VflowLiq(k=15/60000)
    annotation (Placement(transformation(extent={{-138,0},{-126,12}})));
  Modelica.Blocks.Sources.Constant TliqIn(k=30)
    annotation (Placement(transformation(extent={{-138,-22},{-126,-10}})));

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

  output Real epsilon = (Qflow_cond - Pshaft_comp)/(heatPumpCycle_Propane_FMU.evaporator.summary.T_air_A-heatPumpCycle_Propane_FMU.evaporator.summary.T_vle_A);

  Controls.ContinuousController
                              heatPumpController
    annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
  Controls.Interfaces.Actuators actuators annotation (Placement(transformation(extent={{-12,4},
            {-8,8}}),      iconTransformation(extent={{-12,4},{-8,8}})));
equation
  connect(heatPumpCycle_Propane_FMU.sensors, heatPumpController.sensors)
    annotation (Line(points={{44,-30},{70,-30}},                 color={0,0,0}));
  connect(heatPumpController.actuators, heatPumpCycle_Propane_FMU.actuators) annotation (
      Line(points={{90,-30},{94,-30},{94,-44},{-2,-44},{-2,-30},{6.2,-30}},     color={0,0,
          0}));
  connect(TliqIn.y, actuators.TliqInlet_degC) annotation (Line(points={{-125.4,-16},{-10,-16},
          {-10,6}},color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(VflowLiq.y, actuators.VflowLiq) annotation (Line(points={{-125.4,6},{-10,6}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuators, heatPumpCycle_Propane_FMU.actuators) annotation (Line(points={{-10,6},{
          -10,-30},{6.2,-30}},
                             color={0,0,0}), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TairIn.y, actuators.TairInlet_degC) annotation (Line(points={{-125.4,32},{-10,32},
          {-10,6}},color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(phiAir.y, actuators.phiAirInlet) annotation (Line(points={{-125.4,52},{-10,52},{
          -10,6}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -120},{160,120}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-120},{160,
            120}})),
    experiment(StopTime=10000, __Dymola_Algorithm="Dassl"));
end TimeBasedDefrost;
