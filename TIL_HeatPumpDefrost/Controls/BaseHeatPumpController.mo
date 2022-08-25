within TIL_HeatPumpDefrost.Controls;
partial block BaseHeatPumpController
  extends Modelica.Blocks.Icons.Block;




  input Interfaces.Sensors sensors annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  output Interfaces.Actuators actuators annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end BaseHeatPumpController;
