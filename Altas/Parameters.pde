

/*
  Altas parameter definitions

  This firmware is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.
*/

#define GSCALAR(v, name, def) { g.v.vtype, name, Parameters::k_param_ ## v, &g.v, { def_value:def } }
#define GGROUP(v, name, class) { AP_PARAM_GROUP, name, Parameters::k_param_ ## v, &g.v, { group_info: class::var_info } }
#define GOBJECT(v, name, class) { AP_PARAM_GROUP, name, Parameters::k_param_ ## v, &v,  { group_info: class::var_info } }

/*const AP_Param::Info var_info[] PROGMEM = {
    GSCALAR(format_version,         "FORMAT_VERSION", 0),
	GSCALAR(software_type,          "SYSID_SW_TYPE",  Parameters::k_software_type),
	GSCALAR(model_name,              "MODEL_NAME",      MODEL_NAME),
	
    AP_VAREND
};



static void load_parameters(void)
{
	if (!g.format_version.load() || g.format_version != Parameters::k_format_version) {
		AP_Param::erase_all();
		// save the current format version
		g.format_version.set_and_save(Parameters::k_format_version);
    } else {
	    unsigned long before = micros();
	    // Load all auto-loaded EEPROM variables
	    AP_Param::load_all();
	}
}
*/