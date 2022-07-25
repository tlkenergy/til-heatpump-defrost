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
    "Port A of vleFluid tube b" annotation (Placement(transformation(extent={{-80,60},
            {-60,80}},     rotation=0), iconTransformation(extent={{-80,60},{-60,
            80}})));
  TIL.Connectors.VLEFluidPort portA_a(final vleFluidType=vleFluidType)
    "Port A of vleFluid tube a" annotation (Placement(transformation(extent={{-80,-80},
            {-60,-60}},      rotation=0), iconTransformation(extent={{-80,-80},{
            -60,-60}})));
  TIL.Connectors.VLEFluidPort portB_a(final vleFluidType=vleFluidType)
    "Port B of vleFluid tube a" annotation (Placement(transformation(extent={{60,-80},
            {80,-60}},       rotation=0), iconTransformation(extent={{60,-80},{80,
            -60}})));
  TIL.Connectors.VLEFluidPort portB_b(final vleFluidType=vleFluidType)
    "Port A of vleFluid tube b" annotation (Placement(transformation(extent={{60,60},
            {80,80}},      rotation=0), iconTransformation(extent={{60,60},{80,80}})));

  /******************** Inputs *****************************/
  Modelica.Blocks.Interfaces.BooleanInput switch annotation (Placement(
        transformation(extent={{-30,-110},{10,-70}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  input Modelica.Units.SI.Temperature T_ambient=273.15
    "Constant ambient temperature";

equation

  if not switch then
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

  annotation (Icon(coordinateSystem(preserveAspectRatio=false),
    graphics={Bitmap(extent={{-100,-100},{100,100}},
          imageSource="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")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end FourWayValve;
