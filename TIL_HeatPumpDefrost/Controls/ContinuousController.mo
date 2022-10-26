within TIL_HeatPumpDefrost.Controls;
block ContinuousController "Continuos PI controllers and time based defrosting"
  extends BaseHeatPumpController;

  Modelica.Blocks.Sources.BooleanPulse reverseCycle(
    width=10,
    period=1000,
    startTime=500)  annotation (Placement(transformation(extent={{-34,68},{-20,82}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{0,48},{14,62}})));
  Modelica.Blocks.Sources.Constant
                               dT_sc_setpoint(k=0.4)
    annotation (Placement(transformation(extent={{-12,-6},{0,6}})));
  TIL.OtherComponents.Controllers.PIController subcooling_controller(
    controllerType="PI",
    invertFeedback=true,
    k=0.01,
    Ti=100,
    yMax=1,
    yMin=0.1,
    yInitial=0.3,
    use_activeInput=true,
    activationTime=100)
    annotation (Placement(transformation(extent={{32,6},{44,-6}})));
  Modelica.Blocks.Sources.Constant comp(k=0.5)
    annotation (Placement(transformation(extent={{40,-40},{52,-28}})));
  inner TIL.SystemInformationManager sim
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation


  connect(dT_sc_setpoint.y, subcooling_controller.u_s)
    annotation (Line(points={{0.6,0},{32.4,0}}, color={0,0,127}));
  connect(reverseCycle.y, actuators.reverseCycle) annotation (Line(points={{-19.3,75},{86,75},
          {86,0.05},{100.05,0.05}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(reverseCycle.y, not1.u)
    annotation (Line(points={{-19.3,75},{-6,75},{-6,55},{-1.4,55}}, color={255,0,255}));
  connect(not1.y, subcooling_controller.activeInput)
    annotation (Line(points={{14.7,55},{14.7,3.8},{32.4,3.8}}, color={255,0,255}));
  connect(subcooling_controller.y, actuators.exv) annotation (Line(points={{44.4,0},{84,0},{84,
          0.05},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensors.subcooling, subcooling_controller.u_m) annotation (Line(points={{-99.95,0.05},
          {-80,0.05},{-80,0},{-56,0},{-56,32},{38,32},{38,5.8}}, color={0,0,0}), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(comp.y, actuators.comp) annotation (Line(points={{52.6,-34},{86,-34},{86,0.05},{
          100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
end ContinuousController;
