within TIL_HeatPumpDefrost.Examples;
model TimeBasedDefrost2
  extends TIL.Internals.ClassTypes.ExampleModel;
  // components
  Cycles.HeatPumpCycle_Propane heatPumpCycle_Propane_FMU
    annotation (Placement(transformation(extent={{12,28},{50,52}})));



  Controls.TimeBasedDefrost   heatPumpController
    annotation (Placement(transformation(extent={{76,26},{96,46}})));
  Modelica.Blocks.Sources.Constant TairIn(k=7.1)
    annotation (Placement(transformation(extent={{-118,74},{-106,86}})));
  Modelica.Blocks.Sources.Constant phiAir(k=70)
    annotation (Placement(transformation(extent={{-118,94},{-106,106}})));
  Modelica.Blocks.Sources.Constant VflowLiq(k=15/60000)
    annotation (Placement(transformation(extent={{-118,48},{-106,60}})));
  Modelica.Blocks.Sources.Constant TliqIn(k=30)
    annotation (Placement(transformation(extent={{-118,28},{-106,40}})));
  Controls.Interfaces.Actuators actuators annotation (Placement(transformation(extent={{-26,56},
            {-22,60}}),    iconTransformation(extent={{-12,4},{-8,8}})));
equation
  connect(heatPumpCycle_Propane_FMU.sensors, heatPumpController.sensors)
    annotation (Line(points={{50,34},{52,34},{52,36},{76,36}},   color={0,0,0}));
  connect(heatPumpController.actuators, heatPumpCycle_Propane_FMU.actuators) annotation (
      Line(points={{96,36},{100,36},{100,22},{4,22},{4,34},{12.2,34}},          color={0,0,
          0}));
  connect(TliqIn.y,actuators. TliqInlet_degC) annotation (Line(points={{-105.4,34},{-24,34},{
          -24,58}},color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(VflowLiq.y,actuators. VflowLiq) annotation (Line(points={{-105.4,54},{-48,54},{-48,
          58},{-24,58}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuators, heatPumpCycle_Propane_FMU.actuators) annotation (Line(points={{-24,58},{
          -24,34},{12.2,34}},color={0,0,0}), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TairIn.y,actuators. TairInlet_degC) annotation (Line(points={{-105.4,80},{-24,80},{
          -24,58}},color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(phiAir.y,actuators. phiAirInlet) annotation (Line(points={{-105.4,100},{-24,100},{-24,
          58}},    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -120},{160,120}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-120},{160,
            120}})),
    experiment(
      StopTime=10000,
      Tolerance=1e-05,
      __Dymola_Algorithm="Cvode"));
end TimeBasedDefrost2;
