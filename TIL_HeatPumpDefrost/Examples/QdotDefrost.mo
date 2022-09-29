within TIL_HeatPumpDefrost.Examples;
model QdotDefrost
  extends TIL.Internals.ClassTypes.ExampleModel;
  // components
  Cycles.HeatPumpCycle_Propane heatPumpCycle_Propane_FMU
    annotation (Placement(transformation(extent={{12,28},{50,52}})));


  Controls.QdotDefrost        heatPumpController
    annotation (Placement(transformation(extent={{66,24},{86,44}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=10,
    duration=10,
    offset=30,
    startTime=3500) annotation (Placement(transformation(extent={{-140,-32},{-128,-20}})));
  Modelica.Blocks.Sources.Constant TairIn(k=7.1)
    annotation (Placement(transformation(extent={{-142,16},{-130,28}})));
  Modelica.Blocks.Sources.Constant phiAir(k=70)
    annotation (Placement(transformation(extent={{-142,36},{-130,48}})));
  Modelica.Blocks.Sources.Constant VflowLiq(k=15/60000)
    annotation (Placement(transformation(extent={{-142,-10},{-130,2}})));
  Controls.Interfaces.Actuators actuators annotation (Placement(transformation(extent={{-44,38},
            {-40,34}}),    iconTransformation(extent={{-12,4},{-8,8}})));
equation
  connect(heatPumpCycle_Propane_FMU.sensors, heatPumpController.sensors)
    annotation (Line(points={{50,34},{66,34}},                   color={0,0,0}));
  connect(heatPumpController.actuators, heatPumpCycle_Propane_FMU.actuators) annotation (
      Line(points={{86,34},{96,34},{96,18},{6,18},{6,34},{12.2,34}},            color={0,0,
          0}));
  connect(VflowLiq.y,actuators. VflowLiq) annotation (Line(points={{-129.4,-4},{-42,-4},{-42,
          36}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuators, heatPumpCycle_Propane_FMU.actuators) annotation (Line(points={{-42,36},{
          -42,34},{12.2,34}},color={0,0,0}), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TairIn.y,actuators. TairInlet_degC) annotation (Line(points={{-129.4,22},{-42,22},{
          -42,36}},color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(phiAir.y,actuators. phiAirInlet) annotation (Line(points={{-129.4,42},{-42,42},{-42,
          36}},    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ramp.y, actuators.TliqInlet_degC) annotation (Line(points={{-127.4,-26},{-42,-26},{
          -42,36}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -120},{160,120}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-120},{160,
            120}})),
    experiment(
      StopTime=6000,
      Tolerance=1e-05,
      __Dymola_Algorithm="Cvode"));
end QdotDefrost;
