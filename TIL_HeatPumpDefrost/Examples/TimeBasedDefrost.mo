within TIL_HeatPumpDefrost.Examples;
model TimeBasedDefrost
  extends TIL.Internals.ClassTypes.ExampleModel;
  // components
  Cycles.HeatPumpCycle_Propane heatPumpCycle_Propane_FMU
    annotation (Placement(transformation(extent={{6,-36},{44,-12}})));
  Modelica.Blocks.Sources.Constant TairIn(k=7.1)
    annotation (Placement(transformation(extent={{-138,24},{-126,36}})));
  Modelica.Blocks.Sources.Constant phiAir(k=70)
    annotation (Placement(transformation(extent={{-138,44},{-126,56}})));
  Modelica.Blocks.Sources.Constant VflowLiq(k=15/60000)
    annotation (Placement(transformation(extent={{-138,-2},{-126,10}})));
  Modelica.Blocks.Sources.Constant TliqIn(k=30)
    annotation (Placement(transformation(extent={{-138,-22},{-126,-10}})));



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
  connect(VflowLiq.y, actuators.VflowLiq) annotation (Line(points={{-125.4,4},{-68,4},{-68,6},
          {-10,6}},
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
  connect(TairIn.y, actuators.TairInlet_degC) annotation (Line(points={{-125.4,30},{-10,30},{
          -10,6}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(phiAir.y, actuators.phiAirInlet) annotation (Line(points={{-125.4,50},{-10,50},{-10,
          6}},     color={0,0,127}), Text(
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
