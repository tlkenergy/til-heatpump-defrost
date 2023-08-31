within TIL_HeatPumpDefrost.HeatExchangers.FinAndTube.MoistAirVLEFluid;
model CrossFlowHX
  "Adds total solid ice mass calculation to TIL model"
  extends TIL.HeatExchangers.FinAndTube.MoistAirVLEFluid.CrossFlowHX;
  SI.Mass mass_ice = sum(moistAirCell.massFilm.*(ones(nCells)-moistAirCell.x)) "total solid ice mass on heat exchanger";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CrossFlowHX;
