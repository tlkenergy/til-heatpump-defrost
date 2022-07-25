within TIL_HeatPumpDefrost.Cycles;
model DefrostScenario
  extends TIL.Internals.ClassTypes.ExampleModel;
  // components
  HeatPumpCycle_Propane heatPumpCycle_Propane_FMU
    annotation (Placement(transformation(extent={{12,28},{50,52}})));
  Modelica.Blocks.Sources.Constant TairIn(k=7)
    annotation (Placement(transformation(extent={{0,-14},{12,-2}})));
  Modelica.Blocks.Sources.Constant phiAir(k=70)
    annotation (Placement(transformation(extent={{0,-34},{12,-22}})));
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

  TIL.OtherComponents.Controllers.PIController subcooling_controller(
    controllerType="PI",
    invertFeedback=true,
    k=0.01,
    Ti=100,
    yMax=1,
    yMin=0,
    yInitial=0.3,
    use_activeInput=true,
    activationTime=100)
    annotation (Placement(transformation(extent={{-46,26},{-34,14}})));
  Modelica.Blocks.Sources.RealExpression dT_sc_meas(y=heatPumpCycle_Propane_FMU.dT_sc)
    annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
  Modelica.Blocks.Sources.Constant
                               dT_sc_setpoint(k=0.4)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Blocks.Sources.BooleanPulse reverseCycle(
    width=10,
    period=1000,
    startTime=500)  annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
  Modelica.Blocks.Sources.Constant
                                compressor(k=0.5)
    annotation (Placement(transformation(extent={{98,30},{78,50}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-2,-90},{-22,-70}})));
equation
  connect(TairIn.y, heatPumpCycle_Propane_FMU.TairInlet_degC)
    annotation (Line(points={{12.6,-8},{20,-8},{20,26.4}}, color={0,0,127}));
  connect(phiAir.y, heatPumpCycle_Propane_FMU.phiAirInlet)
    annotation (Line(points={{12.6,-28},{24,-28},{24,26.4}},color={0,0,127}));
  connect(VflowLiq.y, heatPumpCycle_Propane_FMU.VflowLiq) annotation (Line(
        points={{-29,100},{0,100},{0,50},{10.6,50}}, color={0,0,127}));
  connect(TliqIn.y, heatPumpCycle_Propane_FMU.TliqInlet_degC)
    annotation (Line(points={{-29,60},{-10,60},{-10,46},{10.6,46}}, color={0,0,127}));
  connect(subcooling_controller.y, heatPumpCycle_Propane_FMU.eevRelPos)
    annotation (Line(points={{-33.6,20},{-10,20},{-10,40},{10.4,40}}, color={0,
          0,127}));
  connect(dT_sc_meas.y, subcooling_controller.u_m)
    annotation (Line(points={{-79,44},{-40,44},{-40,25.8}}, color={0,0,127}));
  connect(dT_sc_setpoint.y, subcooling_controller.u_s) annotation (Line(points={{-79,20},{
          -45.6,20}},                            color={0,0,127}));
  connect(reverseCycle.y, heatPumpCycle_Propane_FMU.reverseCycle) annotation (Line(points={{79,-80},
          {32,-80},{32,22},{33.2,22},{33.2,26.4}},         color={255,0,255}));
  connect(heatPumpCycle_Propane_FMU.relDisplacement, compressor.y)
    annotation (Line(points={{51.6,40},{77,40}}, color={0,0,127}));
  connect(not1.u, reverseCycle.y)
    annotation (Line(points={{0,-80},{79,-80}}, color={255,0,255}));
  connect(not1.y, subcooling_controller.activeInput) annotation (Line(points={{-23,-80},{-54,
          -80},{-54,23.8},{-45.6,23.8}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -120},{160,120}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-120},{160,
            120}})),
    experiment(StopTime=10000, __Dymola_Algorithm="Dassl"));
end DefrostScenario;
