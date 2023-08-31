within TIL_HeatPumpDefrost.Components;
model FourWayValve "Switching connections without pressure loss"

  /*********************** SIM ***********************************/
protected
  outer TIL.SystemInformationManager sim "System information manager";
public
  parameter TILMedia.VLEFluidTypes.BaseVLEFluid vleFluidType=sim.vleFluidType1
    "VLEFluid type of tube a" annotation (Dialog(tab="SIM", group="SIM"),
      choices(
      choice=sim.vleFluidType1 "VLE Fluid 1 as defined in SIM",
      choice=sim.vleFluidType2 "VLE Fluid 2 as defined in SIM",
      choice=sim.vleFluidType3 "VLE Fluid 3 as defined in SIM"));

  /******************** Ports *****************************/
  TIL.Connectors.VLEFluidPort portA_b(final vleFluidType=vleFluidType)
    "Port A of vleFluid tube b" annotation (Placement(transformation(extent={{-70,52},
            {-50,72}},     rotation=0), iconTransformation(extent={{-10,50},{10,
            70}})));
  TIL.Connectors.VLEFluidPort portA_a(final vleFluidType=vleFluidType)
    "Port A of vleFluid tube a" annotation (Placement(transformation(extent={{-10,-70},
            {10,-50}},       rotation=0), iconTransformation(extent={{-10,-70},{
            10,-50}})));
  TIL.Connectors.VLEFluidPort portB_a(final vleFluidType=vleFluidType)
    "Port B of vleFluid tube a" annotation (Placement(transformation(extent={{50,54},
            {70,74}},        rotation=0), iconTransformation(extent={{50,50},{70,
            70}})));
  TIL.Connectors.VLEFluidPort portB_b(final vleFluidType=vleFluidType)
    "Port A of vleFluid tube b" annotation (Placement(transformation(extent={{-70,50},
            {-50,70}},     rotation=0), iconTransformation(extent={{-70,50},{-50,
            70}})));

  /******************** Inputs *****************************/
  Modelica.Blocks.Interfaces.BooleanInput switch annotation (Placement(
        transformation(extent={{-30,-110},{10,-70}}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,0})));
  input Modelica.Units.SI.Temperature T_ambient=273.15
    "Constant ambient temperature";

equation

  if not switch then
    // switch is false
    //connect(portA_a, portB_a);
    portA_a.p = portB_a.p;
    portA_a.m_flow + portB_a.m_flow = 0.0;
    portA_a.h_outflow = inStream(portB_a.h_outflow);
    portB_a.h_outflow = inStream(portA_a.h_outflow);
    portA_a.h_limit = inStream(portB_a.h_limit);
    portB_a.h_limit = inStream(portA_a.h_limit);
    portA_a.xi_outflow = inStream(portB_a.xi_outflow);
    portB_a.xi_outflow = inStream(portA_a.xi_outflow);

    //connect(portA_b, portB_b);
    portA_b.p = portB_b.p;
    portA_b.m_flow + portB_b.m_flow = 0.0;
    portA_b.h_outflow = inStream(portB_b.h_outflow);
    portB_b.h_outflow = inStream(portA_b.h_outflow);
    portA_b.h_limit = inStream(portB_b.h_limit);
    portB_b.h_limit = inStream(portA_b.h_limit);
    portA_b.xi_outflow = inStream(portB_b.xi_outflow);
    portB_b.xi_outflow = inStream(portA_b.xi_outflow);

  else
    // switch is true
    //connect(portA_a, portB_b);
    portA_a.p = portB_b.p;
    portA_a.m_flow + portB_b.m_flow = 0.0;
    portA_a.h_outflow = inStream(portB_b.h_outflow);
    portB_b.h_outflow = inStream(portA_a.h_outflow);
    portA_a.h_limit = inStream(portB_b.h_limit);
    portB_b.h_limit = inStream(portA_a.h_limit);
    portA_a.xi_outflow = inStream(portB_b.xi_outflow);
    portB_b.xi_outflow = inStream(portA_a.xi_outflow);

    //connect(portA_b, portB_a);
    portA_b.p = portB_a.p;
    portA_b.m_flow + portB_a.m_flow = 0.0;
    portA_b.h_outflow = inStream(portB_a.h_outflow);
    portB_a.h_outflow = inStream(portA_b.h_outflow);
    portA_b.h_limit = inStream(portB_a.h_limit);
    portB_a.h_limit = inStream(portA_b.h_limit);
    portA_b.xi_outflow = inStream(portB_a.xi_outflow);
    portB_a.xi_outflow = inStream(portA_b.xi_outflow);

  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-80,-80},
            {80,80}}), graphics={
        Polygon(
          points={{-80,60},{-60,20},{-40,60},{-80,60}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Polygon(
          points={{-20,60},{0,20},{20,60},{-20,60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Polygon(
          points={{40,60},{60,20},{80,60},{40,60}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Polygon(
          points={{-20,-60},{0,-20},{20,-60},{-20,-60}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Rectangle(
          extent={{-80,20},{80,-20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Polygon(
          points={{-20,-60},{0,-20},{20,-60},{-20,-60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1,
          visible= switch),
        Polygon(
          points={{-80,60},{-60,20},{-40,60},{-80,60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1,
          visible= not switch),
        Polygon(
          points={{40,60},{60,20},{80,60},{40,60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1,
          visible=switch),
        Line(
          points={{4,-8},{4,-48}},
          color={153,204,0},
          thickness=1),
        Line(
          points={{4,-8},{64,-8}},
          color={153,204,0},
          thickness=1),
        Line(
          points={{64,48},{64,-8}},
          color={153,204,0},
          thickness=1),
        Line(
          points={{-56,16},{-4,16}},
          color={153,204,0},
          thickness=1),
        Line(
          points={{-4,48},{-4,16}},
          color={153,204,0},
          thickness=1),
        Line(
          points={{-56,48},{-56,16}},
          color={153,204,0},
          thickness=1),
        Line(
          points={{4,16},{56,16}},
          color={153,204,0},
          thickness=1,
          pattern=LinePattern.Dot),
        Line(
          points={{-66,-8},{-4,-8}},
          color={153,204,0},
          thickness=1,
          pattern=LinePattern.Dot),
        Line(
          points={{4,16},{4,48}},
          color={153,204,0},
          thickness=1,
          pattern=LinePattern.Dot),
        Line(
          points={{-66,-8},{-66,48}},
          color={153,204,0},
          thickness=1,
          pattern=LinePattern.Dot),
        Line(
          points={{56,16},{56,48}},
          color={153,204,0},
          thickness=1,
          pattern=LinePattern.Dot),
        Line(
          points={{-4,-8},{-4,-48}},
          color={153,204,0},
          thickness=1,
          pattern=LinePattern.Dot)}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-80,-80},{80,80}})));
end FourWayValve;
