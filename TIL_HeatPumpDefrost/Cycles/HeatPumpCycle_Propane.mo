within TIL_HeatPumpDefrost.Cycles;
model HeatPumpCycle_Propane "Heat Pump Cycle"


  // Heatpump Cycle
  TIL.HeatExchangers.Plate.VLEFluidLiquid.ParallelFlowHX
                               condenser(
    redeclare TIL.HeatExchangers.Plate.Geometry.Example hxGeometry(numberOfPlates=20),
    nCells=15,
    pressureStateID=1,
    redeclare model PressureDropModel_a =
        TIL.HeatExchangers.Plate.TransportPhenomena.PressureDrop.ZeroPressureDrop,
    redeclare model PressureDropModel_b =
        TIL.HeatExchangers.Plate.TransportPhenomena.PressureDrop.ZeroPressureDrop,
    initVLEFluid_a="linearEnthalpyDistribution",
    hInitialVLEFluid_a_CellN=350e3,
    TInitialLiquid_b(displayUnit="degC") = 303.15,
    redeclare model HeatTransferModel_a =
        TIL.HeatExchangers.Plate.TransportPhenomena.HeatTransfer.ConstantAlpha (
         constantAlpha=6000),
    redeclare model HeatTransferModel_b =
        TIL.HeatExchangers.Plate.TransportPhenomena.HeatTransfer.ConstantAlpha (
          constantAlpha=2000),
    hInitialVLEFluid_a_Cell1=550e3,
    redeclare model WallMaterial = TILMedia.SolidTypes.TILMedia_Copper,
    pStart_a=1500000)
    annotation (Placement(transformation(extent={{8,58},{-20,86}}, rotation=0)));

  TIL.LiquidComponents.Boundaries.Boundary condOut(boundaryType="p")
    annotation (Placement(transformation(extent={{26,70},{18,90}}, rotation=0)));
  TIL.LiquidComponents.Boundaries.Boundary condIn(
    use_massFlowRateInput=false,
    m_flowFixed=-0.4,
    use_volumeFlowRateInput=true,
    use_temperatureInput=true,
    TFixed=303.15,
    boundaryType="V_flow") annotation (Placement(transformation(extent={{-40,70},
            {-32,90}}, rotation=0)));

  Components.StatePoint                     statePoint1(stateViewerIndex=1)
    annotation (Placement(transformation(
        origin={116,-2},
        extent={{-4,-4},{4,4}},
        rotation=0)));
  Components.StatePoint                     statePoint2(stateViewerIndex=2)
    annotation (Placement(transformation(extent={{102,54},{110,62}},
                                                                   rotation=0)));

  TIL.VLEFluidComponents.Valves.OrificeValve valve(use_effectiveFlowAreaInput=true,
      effectiveFlowAreaFixed=0.5e-6)
    annotation (Placement(transformation(
        origin={-80,14},
        extent={{-8,4},{8,-4}},
        rotation=270)));
  TIL.HeatExchangers.FinAndTube.MoistAirVLEFluid.CrossFlowHX
                              evaporator(
    redeclare TIL.HeatExchangers.FinAndTube.Geometry.KKI001 hxGeometry,
    pressureStateID=2,
    nCells=10,
    redeclare model TubeSideHeatTransferModel =
        TIL.HeatExchangers.FinAndTube.TransportPhenomena.TubeSideHeatTransfer.ConstantAlpha
        (constantAlpha=4000),
    redeclare model WallMaterial = TILMedia.SolidTypes.TILMedia_Copper,
    redeclare model FinSideHeatTransferModel =
        TIL.HeatExchangers.FinAndTube.TransportPhenomena.FinSideHeatTransfer.ConstantAlpha (
          constantAlpha=80),
    redeclare model FinSidePressureDropModel =
        TIL.HeatExchangers.FinAndTube.TransportPhenomena.FinSidePressureDrop.Haaf,
    moistAirCellFlowType="flow A-B",
    flagActivateDynWaterBalance=true,
    pVLEFluidStart=200000,
    TInitialWall=276.15,
    splittingModeMoistAir="momentum balance")
                             annotation (Placement(transformation(
        origin={-18,-10},
        extent={{14,-14},{-14,14}},
        rotation=180)));

  TIL.VLEFluidComponents.Compressors.EffCompressor compressor(
    nFixed=100,
    displacement=50e-6,
    use_mechanicalPort=false,
    use_relDisplacementInput=true)
    annotation (Placement(transformation(extent={{98,18},{114,34}},
                                                                  rotation=0)));

  TIL.VLEFluidComponents.PressureStateElements.PressureState pressureState_hp(
      pressureStateID=1, pInitial=1500000) annotation (Placement(transformation(
          extent={{-54,58},{-42,70}}, rotation=0)));
  TIL.VLEFluidComponents.PressureStateElements.PressureState pressureState_lp(
      pressureStateID=2,
    initPressure="fixedInitialDewTemperature",
    pInitial=400000,
    TDewInitial=273.15)                   annotation (Placement(transformation(
          extent={{-52,-16},{-40,-4}},  rotation=0)));
  Components.StatePoint                     statePoint0(stateViewerIndex=0)
    annotation (Placement(transformation(extent={{42,4},{50,12}},    rotation=0)));
  Components.StatePoint                     statePoint4(stateViewerIndex=4)
    annotation (Placement(transformation(extent={{-38,20},{-30,28}},   rotation=
           0)));
  inner TIL.SystemInformationManager sim(
    redeclare TILMedia.GasTypes.VDI4670_MoistAir gasType1,
    redeclare replaceable TILMedia.LiquidTypes.TILMedia_Water liquidType1,
    redeclare replaceable VLEFluidTypes.TILMedia_Propane vleFluidType1)
    annotation (Placement(transformation(extent={{160,80},{180,100}})));
  TIL.VLEFluidComponents.Separators.Separator separator(
    pressureStateID=3,
    enableHeatPort=false,
    V(displayUnit="l") = 0.001,
    initialFillingLevel=0.65)
                annotation (Placement(transformation(extent={{90,-24},{102,-4}})));
  TIL.GasComponents.Boundaries.Boundary boundary(boundaryType="p")
    annotation (Placement(transformation(extent={{-4,-10},{4,10}},
        rotation=90,
        origin={-18,26})));
  TIL.GasComponents.Boundaries.Boundary boundary1(
    streamVariablesInputTypeConcentration="phi",
    use_temperatureInput=true,
    TFixed=278.15,
    use_relativeHumidityInput=true,
    boundaryType="p",
    use_massFlowRateInput=false,
    m_flowFixed=-0.4) annotation (Placement(transformation(extent={{4,-10},{-4,10}},
        rotation=270,
        origin={-18,-52})));

  TIL.VLEFluidComponents.Sensors.Sensor_subcooling sensor_subcooling(useTimeConstant=true)
    annotation (Placement(transformation(extent={{-82,68},{-74,76}})));
  Components.FourWayValve fourWayValve
    annotation (Placement(transformation(extent={{22,14},{42,34}})));
  TIL.VLEFluidComponents.PressureStateElements.PressureState pressureState_lp1(
    pressureStateID=3,
    initPressure="fixedInitialDewTemperature",
    pInitial=400000,
    TDewInitial=273.15)                   annotation (Placement(transformation(
          extent={{74,-16},{86,-4}},    rotation=0)));
  TIL.VLEFluidComponents.HydraulicResistors.LinearHydraulicResistor linearHydraulicResistor(
      mdot_nominal=0.1, dp_nominal=1000)
    annotation (Placement(transformation(extent={{46,-12},{58,-8}})));
  // Inputs
  Modelica.Blocks.Continuous.FirstOrder firstOrder_phi_air_in(
    k=1,
    T=1,
    y_start=85) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=180,
        origin={-44,-108})));
  // wrapper
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0.10)
    annotation (Placement(transformation(extent={{186,-8},{170,8}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder_comp(
    k=1,
    T=1,
    y_start=0.3)
    annotation (Placement(transformation(extent={{156,-8},{140,8}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1, uMin=0.1)
    annotation (Placement(transformation(extent={{-142,6},{-126,22}})));
  Modelica.Blocks.Math.Gain gain(k=1.5e-6)
    annotation (Placement(transformation(extent={{-112,6},{-96,22}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder_Tair_in(
    k=1,
    T=1,
    y_start=298.15) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=180,
        origin={-100,-84})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder_liq_Vflow_in(
    k=-1,
    T=1,
    y_start=0.0006) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-128,100})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder_liq_Vflow_in1(
    k=1,
    T=1,
    y_start=298.15) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-130,60})));
  // Outputs
  /*
  Modelica.Blocks.Interfaces.RealOutput pHigh = compressor.summary.p_vle_B annotation (Placement);
  Modelica.Blocks.Interfaces.RealOutput pLow = compressor.summary.p_vle_A annotation (Placement);
  Modelica.Blocks.Interfaces.RealOutput Qflow_cond = condenser.summary.path_b.Q_flow_liq annotation (Placement);
  Modelica.Blocks.Interfaces.RealOutput Qflow_evap = evaporator.summary.Q_flow_vle annotation (Placement);
  Modelica.Blocks.Interfaces.RealOutput Pshaft_comp = compressor.summary.P_shaft annotation (Placement);
  Modelica.Blocks.Interfaces.RealOutput COP = Qflow_cond/Pshaft_comp annotation (Placement);
  Modelica.Blocks.Interfaces.RealOutput mflow_refrigerant = compressor.summary.m_flow_vle_A annotation (Placement);
  Modelica.Blocks.Interfaces.RealOutput Vflow_liq = -condIn.summary.V_flow_liq annotation (Placement);
  Modelica.Blocks.Interfaces.RealOutput mflow_liq = -condIn.summary.m_flow_liq annotation (Placement);
  Modelica.Blocks.Interfaces.RealOutput T_degC_liq_in = condenser.summary.path_b.T_degC_liq_B annotation (Placement);
  Modelica.Blocks.Interfaces.RealOutput T_degC_liq_out = condenser.summary.path_b.T_degC_liq_A annotation (Placement);
  Modelica.Blocks.Interfaces.RealOutput Vflow_air = -boundary1.summary.V_flow_gas annotation (Placement);
  Modelica.Blocks.Interfaces.RealOutput mflow_air = -boundary1.summary.m_flow_gas annotation (Placement);
  Modelica.Blocks.Interfaces.RealOutput T_degC_air_in = evaporator.summary.T_degC_air_B annotation (Placement);
  Modelica.Blocks.Interfaces.RealOutput T_degC_air_out = evaporator.summary.T_degC_air_A annotation (Placement);
  Modelica.Blocks.Interfaces.RealOutput dT_sc = sensor_subcooling.sensorValue annotation (Placement);
  Modelica.Blocks.Interfaces.RealOutput dT_sh = evaporator.summary.superheating annotation (Placement);
  Modelica.Blocks.Interfaces.RealOutput fillingLevelSeparator = separator.fillingLevel annotation (Placement);
  */

  SI.Mass mass_ice = evaporator.summary.mass_water;

  Modelica.Blocks.Math.UnitConversions.From_degC from_degC annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-126,-84})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC1 annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-156,60})));
  Components.FourWayValve fourWayValve_ph "Only used to dynamically switch ph StatePoints"
    annotation (Placement(transformation(extent={{-64,20},{-44,40}})));
  Components.StatePoint                     statePoint3(stateViewerIndex=3)
    annotation (Placement(transformation(extent={{-44,44},{-36,52}},   rotation=
           0)));
  TIL.GasComponents.Fans.Fan2ndOrder fan2ndOrder(
    V_flow_nominal=0.3,
    V_flow0=0.5,
    deltaV_flow=0.01) annotation (Placement(transformation(extent={{-26,-46},{-10,-30}})));
  output Controls.Interfaces.Sensors sensors annotation (Placement(transformation(extent={{190,-70},
            {210,-50}}), iconTransformation(extent={{190,-70},{210,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=sensor_subcooling.sensorValue)
    annotation (Placement(transformation(extent={{140,-56},{160,-36}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=evaporator.portA_vle.p)
    annotation (Placement(transformation(extent={{140,-72},{160,-52}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=condenser.portA_a.p)
    annotation (Placement(transformation(extent={{140,-88},{160,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=-condenser.summary.Q_flow)
    annotation (Placement(transformation(extent={{140,-102},{160,-82}})));
  input Controls.Interfaces.Actuators actuators annotation (Placement(transformation(extent={
            {-188,-70},{-168,-50}}), iconTransformation(extent={{-188,-70},{-168,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=compressor.shaftPower)
    annotation (Placement(transformation(extent={{140,-120},{160,-100}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=evaporator.summary.T_vle_A)
    annotation (Placement(transformation(extent={{140,-138},{160,-118}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=separator.fillingLevel)
    annotation (Placement(transformation(extent={{140,-156},{160,-136}})));
  Modelica.Blocks.Sources.RealExpression realExpression7(y=condenser.summary.path_b.Q_flow_liq
        /compressor.summary.P_shaft)
    annotation (Placement(transformation(extent={{140,-174},{160,-154}})));
  Modelica.Blocks.Sources.RealExpression realExpression8(y=condenser.summary.path_b.T_degC_liq_A)
    annotation (Placement(transformation(extent={{140,-190},{160,-170}})));
  Modelica.Blocks.Sources.RealExpression realExpression9(y=evaporator.summary.T_degC_air_B)
    annotation (Placement(transformation(extent={{140,-206},{160,-186}})));
  Modelica.Blocks.Sources.RealExpression realExpression10(y=evaporator.summary.m_flow_air_A)
    annotation (Placement(transformation(extent={{140,-224},{160,-204}})));
  Modelica.Blocks.Sources.RealExpression realExpression11(y=mass_ice)
    annotation (Placement(transformation(extent={{140,-240},{160,-220}})));
equation


  connect(statePoint0._p, sensors.p0);
  connect(statePoint0._h, sensors.h0);
  connect(statePoint1._p, sensors.p1);
  connect(statePoint1._h, sensors.h1);
  connect(statePoint2._p, sensors.p2);
  connect(statePoint2._h, sensors.h2);
  connect(statePoint3._p, sensors.p3);
  connect(statePoint3._h, sensors.h3);
  connect(statePoint4._p, sensors.p4);
  connect(statePoint4._h, sensors.h4);

  connect(pressureState_lp.portB, valve.portB) annotation (Line(
      points={{-52,-10},{-80,-10},{-80,6}},
      color={153,204,0},
      thickness=0.5));
  connect(pressureState_hp.portA, condenser.portB_a) annotation (Line(
      points={{-42,64},{-20,64}},
      color={153,204,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(condenser.portA_b, condOut.port) annotation (Line(
      points={{8,80},{22,80}},
      color={0,170,238},
      thickness=0.5,
      smooth=Smooth.None));
  connect(condenser.portB_b, condIn.port) annotation (Line(
      points={{-20,80},{-36,80}},
      color={0,170,238},
      thickness=0.5,
      smooth=Smooth.None));
  connect(statePoint1.sensorPort, compressor.portA) annotation (Line(
      points={{116,-6},{116,-10},{106,-10},{106,18}},
      color={153,204,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(pressureState_hp.portB, valve.portA) annotation (Line(
      points={{-54,64},{-80,64},{-80,22}},
      color={153,204,0},
      thickness=0.5));
  connect(separator.portGas, compressor.portA) annotation (Line(
      points={{101,-10},{106,-10},{106,18}},
      color={153,204,0},
      thickness=0.5));
  connect(pressureState_lp.portA, evaporator.portA_vle) annotation (Line(
      points={{-40,-10},{-30,-10},{-30,-10},{-32,-10}},
      color={153,204,0},
      thickness=0.5));
  connect(sensor_subcooling.port, valve.portA) annotation (Line(
      points={{-78,68},{-78,64},{-80,64},{-80,22}},
      color={153,204,0},
      thickness=0.5));
  connect(evaporator.portB_vle, fourWayValve.portA_a) annotation (Line(
      points={{-4,-10},{22,-10},{22,17},{25,17}},
      color={153,204,0},
      thickness=0.5));
  connect(compressor.portB, fourWayValve.portB_b) annotation (Line(
      points={{106,34},{106,50},{39,50},{39,31}},
      color={153,204,0},
      thickness=0.5));
  connect(fourWayValve.portA_b, condenser.portA_a) annotation (Line(
      points={{25,31},{25,64},{8,64}},
      color={153,204,0},
      thickness=0.5));
  connect(statePoint2.sensorPort, fourWayValve.portB_b) annotation (Line(
      points={{106,54},{106,50},{39,50},{39,31}},
      color={153,204,0},
      thickness=0.5));
  connect(pressureState_lp1.portA, separator.portInlet) annotation (Line(
      points={{86,-10},{91,-10}},
      color={153,204,0},
      thickness=0.5));
  connect(fourWayValve.portB_a, linearHydraulicResistor.portA) annotation (Line(
      points={{39,17},{39,-10},{46,-10}},
      color={153,204,0},
      thickness=0.5));
  connect(linearHydraulicResistor.portB, pressureState_lp1.portB) annotation (Line(
      points={{58,-10},{74,-10}},
      color={153,204,0},
      thickness=0.5));
  connect(limiter.y, firstOrder_comp.u)
    annotation (Line(points={{169.2,0},{157.6,0}}, color={0,0,127}));
  connect(firstOrder_comp.y, compressor.relDisplacement_in) annotation (Line(
        points={{139.2,0},{130,0},{130,20},{117,20}}, color={0,0,127}));
  connect(firstOrder_Tair_in.y, boundary1.T_in) annotation (Line(points={{-91.2,-84},{-24,-84},
          {-24,-56}},                      color={0,0,127}));
  connect(firstOrder_liq_Vflow_in.y, condIn.V_flow_in) annotation (Line(points={
          {-119.2,100},{-100,100},{-100,82},{-40,82}}, color={0,0,127}));
  connect(firstOrder_liq_Vflow_in1.y, condIn.T_in) annotation (Line(points={{-121.2,
          60},{-100,60},{-100,78},{-40,78}}, color={0,0,127}));
  connect(firstOrder_phi_air_in.y, boundary1.phi_in) annotation (Line(points={{-35.2,-108},{-20,
          -108},{-20,-56}},                      color={0,0,127}));
  connect(from_degC.y, firstOrder_Tair_in.u)
    annotation (Line(points={{-119.4,-84},{-109.6,-84}}, color={0,0,127}));
  connect(from_degC1.y, firstOrder_liq_Vflow_in1.u)
    annotation (Line(points={{-149.4,60},{-139.6,60}}, color={0,0,127}));
  connect(statePoint0.sensorPort, linearHydraulicResistor.portA) annotation (Line(
      points={{46,4},{46,0},{39,0},{39,-10},{46,-10}},
      color={153,204,0},
      thickness=0.5));
  connect(fourWayValve_ph.portB_a,statePoint4. sensorPort) annotation (Line(
      points={{-47,23},{-47,14},{-34,14},{-34,20}},
      color={153,204,0},
      thickness=0.5));
  connect(statePoint3.sensorPort, fourWayValve_ph.portB_b) annotation (Line(
      points={{-40,44},{-40,37},{-47,37}},
      color={153,204,0},
      thickness=0.5));
  connect(fourWayValve_ph.switch, fourWayValve.switch)
    annotation (Line(points={{-54,20},{-54,6},{32,6},{32,14}}, color={255,0,255}));
  connect(fourWayValve_ph.portA_a, valve.portB) annotation (Line(
      points={{-61,23},{-61,-10},{-80,-10},{-80,6}},
      color={153,204,0},
      thickness=0.5));
  connect(fourWayValve_ph.portA_b, valve.portA) annotation (Line(
      points={{-61,37},{-61,64},{-80,64},{-80,22}},
      color={153,204,0},
      thickness=0.5));

  connect(fan2ndOrder.portA, boundary1.port) annotation (Line(
      points={{-18,-46},{-18,-52}},
      color={255,153,0},
      thickness=0.5));
  connect(evaporator.portA_gas, fan2ndOrder.portB) annotation (Line(
      points={{-18,-24},{-18,-30}},
      color={255,153,0},
      thickness=0.5));
  connect(evaporator.portB_gas, boundary.port) annotation (Line(
      points={{-18,4},{-18,26}},
      color={255,153,0},
      thickness=0.5));
  connect(realExpression.y, sensors.subcooling) annotation (Line(points={{161,-46},{184,-46},
          {184,-59.95},{200.05,-59.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression1.y, sensors.p_evap) annotation (Line(points={{161,-62},{184,-62},{
          184,-59.95},{200.05,-59.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression2.y, sensors.p_cond) annotation (Line(points={{161,-78},{184,-78},{
          184,-59.95},{200.05,-59.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression3.y, sensors.Qdot_cond) annotation (Line(points={{161,-92},{184,-92},
          {184,-59.95},{200.05,-59.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuators.comp, limiter.u) annotation (Line(points={{-177.95,-59.95},{124,-59.95},{
          124,-28},{196,-28},{196,0},{187.6,0}},
                                        color={0,0,0}), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fourWayValve.switch, actuators.reverseCycle) annotation (Line(points={{32,14},{32,
          6},{-64,6},{-64,-59.95},{-177.95,-59.95}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(realExpression4.y, sensors.P_comp) annotation (Line(points={{161,-110},{184,-110},
          {184,-59.95},{200.05,-59.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(firstOrder_Tair_in.y, sensors.T_air) annotation (Line(points={{-91.2,-84},{-24,-84},
          {-24,-62},{200,-62},{200,-59.95},{200.05,-59.95}},                color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression5.y, sensors.T_evap) annotation (Line(points={{161,-128},{184,-128},
          {184,-59.95},{200.05,-59.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(from_degC1.u, actuators.TliqInlet_degC) annotation (Line(points={{-163.2,60},{-194,
          60},{-194,-60},{-178,-60}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(firstOrder_liq_Vflow_in.u, actuators.VflowLiq) annotation (Line(points={{-137.6,100},
          {-194,100},{-194,-60},{-178,-60}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(from_degC.u, actuators.TairInlet_degC) annotation (Line(points={{-133.2,-84},{-160,
          -84},{-160,-60},{-178,-60}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(firstOrder_phi_air_in.u, actuators.phiAirInlet) annotation (Line(points={{-53.6,-108},
          {-88,-108},{-88,-118},{-196,-118},{-196,-60},{-178,-60}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(limiter1.u, actuators.exv) annotation (Line(points={{-143.6,14},{-160,14},{-160,-59.95},
          {-177.95,-59.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(limiter1.y, gain.u)
    annotation (Line(points={{-125.2,14},{-113.6,14}}, color={0,0,127}));
  connect(gain.y, valve.effectiveFlowArea_in)
    annotation (Line(points={{-95.2,14},{-85,14}}, color={0,0,127}));
  connect(realExpression6.y, sensors.fillingLevelSeparator) annotation (Line(points={{161,-146},
          {184,-146},{184,-59.95},{200.05,-59.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression7.y, sensors.COP) annotation (Line(points={{161,-164},{184,-164},{184,
          -59.95},{200.05,-59.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression8.y, sensors.TliqOutlet_degC) annotation (Line(points={{161,-180},{184,
          -180},{184,-59.95},{200.05,-59.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression9.y, sensors.TairOutlet_degC) annotation (Line(points={{161,-196},{184,
          -196},{184,-59.95},{200.05,-59.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression10.y, sensors.m_flow_air) annotation (Line(points={{161,-214},{184,-214},
          {184,-59.95},{200.05,-59.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression11.y, sensors.mass_ice) annotation (Line(points={{161,-230},{184,
          -230},{184,-59.95},{200.05,-59.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Diagram(coordinateSystem(extent={{-180,-120},{200,120}})), Icon(
        coordinateSystem(extent={{-180,-120},{200,120}})));
end HeatPumpCycle_Propane;
