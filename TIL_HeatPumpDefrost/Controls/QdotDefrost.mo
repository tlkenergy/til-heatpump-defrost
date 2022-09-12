within TIL_HeatPumpDefrost.Controls;
block QdotDefrost "Discrete PI controller"
  extends BaseHeatPumpController;

  inner Real exv;
  inner Boolean reverseCycle;
  inner Real epsilon_rel;

  Modelica.Blocks.Sources.Constant comp(k=0.5)
    annotation (Placement(transformation(extent={{52,-40},{64,-28}})));
Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock
                                               periodicClock(factor=1000, resolution=
        Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-108,-36},{-96,-24}})));
  Defrost defrost annotation (Placement(transformation(extent={{-38,58},{-18,78}})));
  Heating heating annotation (Placement(transformation(extent={{-40,18},{-20,38}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=exv)
    annotation (Placement(transformation(extent={{12,-10},{32,10}})));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{-74,-6},{-62,6}})));
  Modelica.Clocked.RealSignals.Sampler.Hold hold_y
    annotation (Placement(transformation(extent={{50,-6},{62,6}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=reverseCycle)
    annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  Modelica.Clocked.BooleanSignals.Sampler.Hold hold1
    annotation (Placement(transformation(extent={{50,-22},{62,-10}})));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked sample2
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-70,-46})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=epsilon)
    annotation (Placement(transformation(extent={{-106,-56},{-86,-36}})));

  Real epsilon;

equation
  epsilon = (sensors.Qdot_cond - sensors.P_comp)/(sensors.T_air - sensors.T_evap);

  connect(comp.y, actuators.comp) annotation (Line(points={{64.6,-34},{86,-34},{86,0.05},{100.05,
          0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
public
  block Defrost
    outer output Real exv;
    outer output Boolean reverseCycle;

  equation
    exv = 0.8;
    reverseCycle = true;

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            extent={{-100,100},{100,-100}},
            textColor={0,0,0},
            textString="%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            extent={{-100,100},{100,-100}},
            textColor={0,0,0},
            textString="%stateName",
            fontSize=10)}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true);
  end Defrost;

  block Heating
     outer output Real exv;
     outer output Boolean reverseCycle;


    Modelica.Clocked.RealSignals.NonPeriodic.PI
                                       PI(
      x(fixed=true, start=15),
      T=100,
      k=0.02)
             annotation (Placement(transformation(extent={{-2,-6},{18,14}})));
    Modelica.Blocks.Sources.Constant
                                 dT_sc_setpoint(k=2)
      annotation (Placement(transformation(extent={{-54,-28},{-42,-16}})));
    Modelica.Blocks.Math.Feedback feedback
      annotation (Placement(transformation(extent={{-35,-6},{-15,14}})));
    Modelica.Blocks.Interfaces.RealInput subcooling annotation (Placement(transformation(
            extent={{-140,-20},{-100,20}}), iconTransformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealInput epsilon annotation (Placement(transformation(extent=
             {{-140,-100},{-100,-60}}), iconTransformation(extent={{-140,-100},{-100,-60}})));

    Integer epsilon_init(start=0);
    outer output Real epsilon_rel;

  equation
    when ticksInState() == 100.0 then
      epsilon_init = integer(previous(epsilon));
    end when;

    epsilon_rel = previous(epsilon)/max(epsilon_init, 1);

    exv = PI.y;
    reverseCycle = false;

    connect(dT_sc_setpoint.y, feedback.u2)
      annotation (Line(points={{-41.4,-22},{-25,-22},{-25,-4}}, color={0,0,127}));
    connect(subcooling, feedback.u1)
      annotation (Line(points={{-120,0},{-40,0},{-40,4},{-33,4}}, color={0,0,127}));
    connect(feedback.y, PI.u) annotation (Line(points={{-16,4},{-4,4}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            extent={{-100,100},{100,-100}},
            textColor={0,0,0},
            textString="%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            extent={{-100,100},{100,-100}},
            textColor={0,0,0},
            textString="%stateName",
            fontSize=10)}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true);
  end Heating;
equation
  initialState(heating);

  transition(
    heating,
    defrost,ticksInState() > 200 and epsilon_rel < 0.5,
    immediate=false,
    reset=true,
    synchronize=false,
    priority=1) annotation (Line(
      points={{-18,32},{14,44},{14,64},{-16,70}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{4,4},{4,10}},
      fontSize=10,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  transition(
    defrost,
    heating,ticksInState() > 100,immediate=true,reset=true,synchronize=false,priority=1)
                          annotation (Line(
      points={{-40,76},{-76,62},{-66,34},{-64,34},{-42,32}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{-4,4},{-4,10}},
      fontSize=10,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Right));
  connect(sensors.subcooling, sample1.u) annotation (Line(points={{-99.95,0.05},{-88,0.05},{-88,
          0},{-75.2,0}}, color={0,0,0}), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sample1.y, heating.subcooling)
    annotation (Line(points={{-61.4,0},{-54,0},{-54,28},{-42,28}}, color={0,0,127}));
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-95.4,-30},{-68,-30},{-68,-7.2}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(realExpression.y, hold_y.u)
    annotation (Line(points={{33,0},{48.8,0}}, color={0,0,127}));
  connect(hold_y.y, actuators.exv) annotation (Line(points={{62.6,0},{82,0},{82,0.05},{100.05,
          0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanExpression.y, hold1.u)
    annotation (Line(points={{31,-20},{42,-20},{42,-16},{48.8,-16}}, color={255,0,255}));
  connect(hold1.y, actuators.reverseCycle) annotation (Line(points={{62.6,-16},{84,-16},{84,0.05},
          {100.05,0.05}},
                       color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(periodicClock.y, sample2.clock) annotation (Line(
      points={{-95.4,-30},{-70,-30},{-70,-38.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(realExpression1.y, sample2.u)
    annotation (Line(points={{-85,-46},{-77.2,-46}}, color={0,0,127}));
  connect(sample2.y, heating.epsilon)
    annotation (Line(points={{-63.4,-46},{-50,-46},{-50,20},{-42,20}}, color={0,0,127}));
end QdotDefrost;
