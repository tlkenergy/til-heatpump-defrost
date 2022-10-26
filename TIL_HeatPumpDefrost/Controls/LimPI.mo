within TIL_HeatPumpDefrost.Controls;
block LimPI "Discrete-time PI controller with limited output"
  extends Modelica.Clocked.RealSignals.Interfaces.PartialClockedSISO;

  parameter Real k "Gain of continuous PI controller";
  parameter Real T(min=Modelica.Constants.small)
    "Time constant of continuous PI controller";
  output Real x(start=0) "Discrete PI state";

  parameter Real yMax(start=1) "Upper limit of output";
  parameter Real yMin=-yMax "Lower limit of output";

protected
  Real Ts = interval(u) "Sample time (periodic or non-periodic)";
  Real x_unlimited;
  Real y_unlimited;

equation
  when Clock() then
     x_unlimited = previous(x) + u*(Ts/T);
     y_unlimited = k*(x_unlimited + u);

     if y_unlimited >= yMax then
       x = previous(x);
       y = yMax;
     elseif y_unlimited <= yMin then
       x = previous(x);
       y = yMin;
     else
       x = previous(x) + u*(Ts/T);
       y = k*(x + u);
     end if;
  end when;

  annotation (defaultComponentName="PI1",
       Icon(graphics={
        Polygon(
          points={{90,-82},{68,-74},{68,-90},{90,-82}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-82},{82,-82}}, color={192,192,192}),
        Line(points={{-80,76},{-80,-92}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-82},{-80,-10},{-32,-10},{-32,18},{16,18},{16,46},{64,46},
              {64,80}},
          color={0,0,127},
          pattern=LinePattern.Dot),
        Text(
          extent={{-30,-4},{82,-58}},
          textColor={192,192,192},
          textString="PI"),
        Text(
          extent={{-150,-150},{150,-110}},
          textString="Td=%Td"),
        Ellipse(
          extent={{-87,-3},{-75,-15}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-37,25},{-25,13}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{9,52},{21,40}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{58,87},{70,75}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This block defines a discrete-time PI controller by the formula:
</p>
<blockquote><pre>
// State space form:
   x(ti) = previous(x(ti)) + u(ti)/Td;
   y(ti) = kd*(x(ti) + u(ti));

// Transfer function form:
   y(z) = kd*(c*z-1)/(z-1)*u(z);
          c = 1 + 1/Td
</pre></blockquote>
<p>
where kd is the gain, Td is the time constant, ti is the time instant
of the i-th clock tick and z is the inverse shift operator.
</p>

<p>
This discrete-time form has been derived from the continuous-time
form of a PI controller by using the implicit Euler discretization formula.
</p>
</html>"));
end LimPI;
