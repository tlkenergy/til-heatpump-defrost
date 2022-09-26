within TIL_HeatPumpDefrost.Components;
model StatePoint
  extends TIL.VLEFluidComponents.Sensors.StatePoint;

  Modelica.Blocks.Interfaces.RealOutput _p = p;
  Modelica.Blocks.Interfaces.RealOutput _h = h;
end StatePoint;
