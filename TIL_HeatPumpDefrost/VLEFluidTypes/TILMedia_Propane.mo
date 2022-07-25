within TIL_HeatPumpDefrost.VLEFluidTypes;
record TILMedia_Propane "TILMedia.Propane"
  extends TILMedia.VLEFluidTypes.BaseVLEFluid(
    final fixedMixingRatio=true,
    final nc_propertyCalculation=1,
    final vleFluidNames={"TILMedia.Propane"},
    final mixingRatio_propertyCalculation={1});
end TILMedia_Propane;
