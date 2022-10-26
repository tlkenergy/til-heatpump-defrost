within TIL_HeatPumpDefrost.Controls.Testers;
model TestLimPI
  LimPI PI1(
    k=10,
    T=1,
    yMax=1) annotation (Placement(transformation(extent={{0,16},{20,36}})));
Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock
                                               periodicClock(factor=100, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-44,62},{-32,74}})));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked sample annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-14,26})));
  Modelica.Clocked.RealSignals.Sampler.Hold hold
    annotation (Placement(transformation(extent={{32,20},{44,32}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-49,16},{-30,36}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=1)
    annotation (Placement(transformation(extent={{56,16},{76,36}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=1.5, f=0.1)
    annotation (Placement(transformation(extent={{-96,16},{-76,36}})));
equation
  connect(hold.y, firstOrder.u)
    annotation (Line(points={{44.6,26},{54,26}}, color={0,0,127}));
  connect(periodicClock.y, sample.clock) annotation (Line(
      points={{-31.4,68},{-14,68},{-14,33.2}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sine.y, feedback.u1)
    annotation (Line(points={{-75,26},{-47.1,26}}, color={0,0,127}));
  connect(feedback.y, sample.u)
    annotation (Line(points={{-30.95,26},{-21.2,26}}, color={0,0,127}));
  connect(firstOrder.y, feedback.u2) annotation (Line(points={{77,26},{86,26},{86,-8},{-40,
          -8},{-40,18},{-39.5,18}}, color={0,0,127}));
  connect(PI1.y, hold.u) annotation (Line(points={{21,26},{30.8,26}}, color={0,0,127}));
  connect(sample.y, PI1.u) annotation (Line(points={{-7.4,26},{-2,26}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end TestLimPI;
