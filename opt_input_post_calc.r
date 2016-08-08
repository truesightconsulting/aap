# # halo effect of goal seek
# source(paste(main.path,"opt_modelinput_halo.r",sep=""),local = T)

# calculate final result
curve$value_decomp=calc_decomp(curve$sp_current)
curve$value_npv=curve$value_decomp*curve$clv
curve$value_factor_1=curve$value_decomp/curve$factor_1
if (ex.setup$optimization_type %in% c(3,5,9)) {
  curve$spend_start=curve$sp_plan
  curve$value_decomp_start=calc_decomp(curve$sp_plan)
  curve$value_npv_start=curve$value_decomp_start*curve$clv
  curve$value_factor_1_start=curve$value_decomp_start/curve$factor_1
  curve$support_start=curve$sp_plan/curve$cps
}else{
  curve$spend_start=curve$sp_min
  curve$value_decomp_start=calc_decomp(curve$sp_min)
  curve$value_npv_start=curve$value_decomp_start*curve$clv
  curve$value_factor_1_start=curve$value_decomp_start/curve$factor_1
  curve$support_start=curve$sp_min/curve$cps
}
curve$support=curve$sp_current/curve$cps
curve$value_npv_next=curve$clv*calc_decomp(curve$sp_current+ex.setup$input_increment)
curve$sp_inc=ex.setup$input_increment

# summarize result
input_sp=c("sp_current","spend_start")
output_sp=c("spend","spend_start")
input_decomp=c("value_decomp","value_decomp_start")
output_decomp=c("decomp","decomp_start")

source(paste(main.path,"opt_modelinput_post_calc_agg.r",sep=""),local = T)

# format output
# new var 
metric_eff=c("eff1","eff1_start")
name_eff=c("ROI","Planned ROI")
f_eff=c("decomp/spend","decomp_start/spend_start")

# existing var
metric_reg=c("spend","decomp","spend_start","decomp_start")
name_reg=c("Spend","Net Sales","Planned Spend","Planned Net Sales")

# table column order 
order_all=c("spend","decomp","eff1","spend_start","decomp_start","eff1_start")
order_other=c("spend","spend_start","decomp","decomp_start","eff1","eff1_start")

# any columns to be dropped for all, excel and other tables; NAME HERE IS AFTER RENAMED!!!!!!!!!!!!!!!!!!!!!!!!!!
drop_all=c("all_name","ROI","Planned ROI")
drop_excel=c("ROI","Planned ROI")
drop_other=c("ROI","Planned ROI")

source(paste(main.path,"opt_modelinput_post_calc_format.r",sep=""),local = T)